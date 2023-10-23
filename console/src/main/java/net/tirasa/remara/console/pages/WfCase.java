package net.tirasa.remara.console.pages;

import java.text.DateFormat;
import java.util.Date;
import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.core.management.CaseManagement;
import java.util.List;
import net.tirasa.remara.persistence.data.MedicineCase;
import org.apache.wicket.Page;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.markup.html.AjaxLink;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.extensions.ajax.markup.html.modal.ModalWindow;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.markup.html.list.ListItem;
import org.apache.wicket.markup.html.list.ListView;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class WfCase extends BasePage {

    private static final long serialVersionUID = 6488934266849679206L;

    @SpringBean
    private CaseManagement caseManagement;

    private DateFormat dateFormat = null;

    public WfCase() {
        super();
        add(new FeedbackPanel("feedback"));

        dateFormat = DateFormat.getDateInstance(DateFormat.MEDIUM, getLocale());

        final ModalWindow caseViewPopup = new ModalWindow("caseViewPopup");
        add(caseViewPopup);

        caseViewPopup.setPageMapName(getString("titleCaseViewPopup"));
        caseViewPopup.setCookieName("caseViewModal");

        caseViewPopup.setTitle(getString("titleCaseViewPopup"));
        caseViewPopup.setCookieName("caseViewModal");

        List<MedicineCase> list = caseManagement.getForConfirm(getRemaraUser().getUsername());

        ListView listView = new ListView("caseList", list) {

            private static final long serialVersionUID = 4949588177564901031L;

            @Override
            protected void populateItem(final ListItem item) {
                final MedicineCase medicineCase = (MedicineCase) item.getModelObject();
                String name = medicineCase.getPatient().getName() + " " + medicineCase.getPatient().getSurname();
                Date insertDate = medicineCase.getInsertDate();
                String insertDateString = "";
                if (insertDate != null) {
                    insertDateString = dateFormat.format(insertDate);
                }
                item.add(new Label("data", insertDateString));
                String illness = medicineCase.getIllness().getExempt() + " - "
                        + medicineCase.getIllness().getDescription();
                item.add(new Label("name", name));
                item.add(new Label("illness", illness));

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

                Link openLink = new Link("linkOpen", item.getModel()) {

                    private static final long serialVersionUID = -5665438703028610801L;

                    @Override
                    public void onClick() {
                        PageParameters parameters = new PageParameters();
                        parameters.put("medicineCase", medicineCase);
                        setResponsePage(new NewCase(parameters));
                    }
                };
                openLink.add(new SimpleAttributeModifier("title", getString("open")));
                item.add(openLink);

                Link deleteLink = new Link("linkDelete", item.getModel()) {

                    private static final long serialVersionUID = -5665438703028610801L;

                    @Override
                    public void onClick() {
                        try {
                            caseManagement.delete(medicineCase);
                        } catch (DBException e) {
                            error(getString(e.getMessage()));
                            return;
                        }
                        getSession().info(getString("info.delete"));
                        setResponsePage(new WfCase());
                    }
                };
                deleteLink.add(new SimpleAttributeModifier("title", getString("delete")));
                deleteLink.add(new SimpleAttributeModifier(
                        "onclick",
                        "return confirm('" + getString("confirm_delete") + "');"));
                item.add(deleteLink);

                Link linkConfirm = new Link("linkConfirm", item.getModel()) {

                    private static final long serialVersionUID = -5665438703028610801L;

                    @Override
                    public void onClick() {
                        try {
                            caseManagement.confirm(medicineCase, getRemaraUser().getUsername(), getRemaraUser().
                                    getRole());
                        } catch (DBException e) {
                            error(getString(e.getMessage()));
                            return;
                        }
                        getSession().info(getString("info.confirm"));
                        setResponsePage(new WfCase());
                    }
                };
                linkConfirm.add(new SimpleAttributeModifier("title", getString("confirm")));
                item.add(linkConfirm);

            }
        };
        add(listView);
    }
}
