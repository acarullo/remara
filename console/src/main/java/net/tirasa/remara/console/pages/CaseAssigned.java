package net.tirasa.remara.console.pages;

import java.text.DateFormat;
import java.util.Date;
import net.tirasa.remara.console.layout.AssignedCaseFind;
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
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class CaseAssigned extends BasePage {

    private static final long serialVersionUID = -7430228385302345317L;

    @SpringBean
    private CaseManagement caseManagement;

    private DateFormat dateFormat = null;

    public CaseAssigned(PageParameters parameters) {
        super();

        dateFormat = DateFormat.getDateInstance(DateFormat.MEDIUM, getLocale());

        final ModalWindow caseViewPopup = new ModalWindow("caseViewPopup");
        add(caseViewPopup);

        caseViewPopup.setPageMapName(getString("titleCaseViewPopup"));
        caseViewPopup.setCookieName("caseViewModal");
        caseViewPopup.setTitle(getString("titleCaseViewPopup"));

        String code = "";
        if (parameters != null && parameters.containsKey("findText")) {
            code = parameters.getString("findText");
        }
        add(new AssignedCaseFind("findPanel", code));

        List<MedicineCase> medicineCases;
        if (parameters != null && parameters.containsKey("findText")) {
            medicineCases = caseManagement.findAssignedByCode(code);
        } else {
            medicineCases = caseManagement.getCaseAssigned();

        }

        add(new Link("allCases") {

            private static final long serialVersionUID = -4331619903296515985L;

            @Override
            public void onClick() {
                final PageParameters parameters = new PageParameters();
                parameters.remove("findText");
                setResponsePage(new CaseAssigned(parameters));
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
                item.add(new Label("referent", medicineCase.getReferent()));

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
        add(listView);
    }
}
