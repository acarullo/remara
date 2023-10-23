package net.tirasa.remara.console.pages;

import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.core.management.CaseManagement;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import net.tirasa.remara.persistence.data.MedicineCase;
import org.apache.wicket.Page;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.markup.html.AjaxLink;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.extensions.ajax.markup.html.modal.ModalWindow;
import org.apache.wicket.markup.html.WebMarkupContainer;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.list.ListItem;
import org.apache.wicket.markup.html.list.ListView;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class RequestModifiedCase extends BasePage {

    private static final long serialVersionUID = -6922201520373599093L;

    @SpringBean
    private CaseManagement caseManagement;

    private final List<MedicineCase> listMedicineCase;

    private DateFormat df = null;

    public RequestModifiedCase() {
        super();

        add(new FeedbackPanel("feedback"));
        df = DateFormat.getDateInstance(DateFormat.MEDIUM, getLocale());

        final ModalWindow caseViewPopup = new ModalWindow("caseViewPopup");
        add(caseViewPopup);

        caseViewPopup.setPageMapName(getString("titleCaseViewPopup"));
        caseViewPopup.setCookieName("caseViewModal");

        caseViewPopup.setTitle(getString("titleCaseViewPopup"));
        caseViewPopup.setCookieName("caseViewModal");

        final WebMarkupContainer container = new WebMarkupContainer("container");
        container.setOutputMarkupId(true);
        add(container);

//        final ModalWindow reasonPopup = new ModalWindow("reasonRefusalCasePopup");
//        add(reasonPopup);
//
//        reasonPopup.setCookieName("reasonPopup");
//        reasonPopup.setWindowClosedCallback(new ModalWindow.WindowClosedCallback() {
//
//            private static final long serialVersionUID = 8804221891699487139L;
//
//            public void onClose(AjaxRequestTarget target) {
//                target.addComponent(container);
//            }
//        });

        listMedicineCase = caseManagement.getRequestModifier(getRemaraUser().getUsername());

        ListView listView = new ListView("caseList", listMedicineCase) {

            private static final long serialVersionUID = 4949588177564901031L;

            @Override
            protected void populateItem(ListItem item) {
                final MedicineCase medicineCase = (MedicineCase) item.getModelObject();
                String name = medicineCase.getPatient().getName() + " " + medicineCase.getPatient().getSurname();
                String illness = medicineCase.getIllness().getExempt() + " - "
                        + medicineCase.getIllness().getDescription();
                Date lastAction = caseManagement.getLastActionForMC(medicineCase.getWorkflow());
                String dataAction = "";
                if (lastAction != null) {
                    dataAction = df.format(lastAction);
                }

                item.add(new Label("data", dataAction));
                item.add(new Label("name", name));
                item.add(new Label("illness", illness));
                item.add(new Label("compiler", medicineCase.getOwner()));

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
            }
        };

        container.add(listView);

    }

    public void requestUpdate(MedicineCase medicineCase, String reason)
            throws DBException {
        caseManagement.requestModifie(medicineCase, getRemaraUser().getUsername(), reason);
        listMedicineCase.remove(medicineCase);
    }

    public void reject(MedicineCase medicineCase, String reason)
            throws DBException {
        caseManagement.reject(medicineCase, getRemaraUser().getUsername(), reason);
        listMedicineCase.remove(medicineCase);
    }
}
