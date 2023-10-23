package net.tirasa.remara.console.pages;

import java.text.DateFormat;
import net.tirasa.remara.console.utilities.Constants;
import net.tirasa.remara.console.layout.WfAdminCaseFind;
import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.core.management.CaseManagement;
import net.tirasa.remara.core.management.UserManagement;
import java.util.Date;
import java.util.List;
import net.tirasa.remara.persistence.data.MedicineCase;
import org.apache.wicket.Page;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.form.AjaxFormComponentUpdatingBehavior;
import org.apache.wicket.ajax.markup.html.AjaxLink;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.extensions.ajax.markup.html.modal.ModalWindow;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.Button;
import org.apache.wicket.markup.html.form.DropDownChoice;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.markup.html.list.ListItem;
import org.apache.wicket.markup.html.list.ListView;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.model.Model;
import org.apache.wicket.model.PropertyModel;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class WfAdminCase extends BasePage {

    private static final long serialVersionUID = -6084699474518005713L;

    @SpringBean
    private UserManagement userManagement;

    @SpringBean
    private CaseManagement caseManagement;

    private final Form form;

    private List<MedicineCase> medicineCases;

    private DateFormat dateFormat = null;

    public WfAdminCase(PageParameters parameters) {
        super();

        dateFormat = DateFormat.getDateInstance(DateFormat.MEDIUM, getLocale());

        add(new FeedbackPanel("feedback"));

        final ModalWindow caseViewPopup = new ModalWindow("caseViewPopup");
        add(caseViewPopup);

        caseViewPopup.setPageMapName(getString("titleCaseViewPopup"));
        caseViewPopup.setCookieName("caseViewModal");

        caseViewPopup.setTitle(getString("titleCaseViewPopup"));
        caseViewPopup.setCookieName("caseViewModal");

        form = new Form("caseForm") {

            private static final long serialVersionUID = 7283381648682393116L;

            @Override
            protected void onSubmit() {
                try {
                    caseManagement.update(medicineCases);
                } catch (DBException e) {
                    error(getString(e.getMessage()));
                    return;
                }
                info(getString("info.update"));
            }
        };
        add(form);

        final List<String> referents = userManagement.getReferents();

        String code = "";
        if (parameters != null && parameters.containsKey("findText")) {
            code = parameters.getString("findText");
        }
        add(new WfAdminCaseFind("findPanel", code));

        if (parameters != null && parameters.containsKey("findText")) {
            medicineCases = caseManagement.findForAssignedReferentByCode(code, getRemaraUser().getUsername());
        } else {
            medicineCases = caseManagement.getForAssignReferent(getRemaraUser().getUsername());
        }

        add(new Link("allCases") {

            private static final long serialVersionUID = -4331619903296515985L;

            @Override
            public void onClick() {
                final PageParameters parameters = new PageParameters();
                parameters.remove("findText");
                setResponsePage(new WfAdminCase(parameters));
            }
        });

        ListView listView = new ListView("caseList", medicineCases) {

            private static final long serialVersionUID = 4949588177564901031L;

            @Override
            protected void populateItem(ListItem item) {
                final MedicineCase medicineCase = (MedicineCase) item.getModelObject();
                String name = medicineCase.getPatient().getName() + " " + medicineCase.getPatient().getSurname();
                Date insertDate = medicineCase.getInsertDate();
                String insertDateString = "";
                if (insertDate != null) {
                    insertDateString = dateFormat.format(insertDate);
                }
                item.add(new Label("data", insertDateString));
                item.add(new Label("name", name));
                item.add(new Label("code", medicineCase.getIllness().getExempt()));
                item.add(new Label("description", medicineCase.getIllness().getDescription()));
                item.add(new Label("compiler", medicineCase.getOwner()));

                DropDownChoice referent = new DropDownChoice("referent",
                        new PropertyModel(medicineCase, "referent"), referents);
                referent.setOutputMarkupId(true);
                referent.add(new SimpleAttributeModifier("title", getString("referent")));
                referent.add(new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

                    private static final long serialVersionUID = -1107858522700306810L;

                    @Override
                    protected void onUpdate(final AjaxRequestTarget target) {
                    }
                });
                item.add(referent);

                AjaxLink viewLink = new AjaxLink("linkView", item.getModel()) {

                    private static final long serialVersionUID = 3776750333491622263L;

                    @Override
                    public void onClick(AjaxRequestTarget target) {
                        caseViewPopup.setPageCreator(new ModalWindow.PageCreator() {

                            private static final long serialVersionUID = -7834632442532690940L;

                            public Page createPage() {
                                PageParameters parameters = new PageParameters();
                                parameters.put("medicineCase", medicineCase);
                                return new CaseViewPopup(parameters);
                            }
                        });
                        caseViewPopup.show(target);
                    }
                };
                viewLink.add(new SimpleAttributeModifier("title", getString("view")));
                item.add(viewLink);

                Link linkConfirm = new Link("linkConfirm", item.getModel()) {

                    private static final long serialVersionUID = -5665438703028610801L;

                    @Override
                    public void onClick() {
                        try {
                            caseManagement.assign(medicineCase, getRemaraUser().getUsername());
                        } catch (DBException e) {
                            error(getString(e.getMessage()));
                            return;
                        }
                        getSession().info(getString("info.confirm"));
                        setResponsePage(new WfAdminCase(null));
                    }
                };
                linkConfirm.add(new SimpleAttributeModifier("title", getString("confirm")));
                item.add(linkConfirm);
            }
        };
        form.add(listView);

        Button save = new Button("save", new Model(getString("save")));
        form.add(save);
    }
}
