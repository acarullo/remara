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
import org.apache.wicket.markup.html.WebMarkupContainer;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.markup.html.list.ListItem;
import org.apache.wicket.markup.html.list.ListView;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class WfReferentCase extends BasePage {

    private static final long serialVersionUID = 2565989581201023719L;

    @SpringBean
    private CaseManagement caseManagement;

    private final List<MedicineCase> listMedicineCase;

    private DateFormat dateFormat = null;

    public WfReferentCase() {
        super();

        dateFormat = DateFormat.getDateInstance(DateFormat.MEDIUM, getLocale());

        add(new FeedbackPanel("feedback"));

        final ModalWindow caseViewPopup = new ModalWindow("caseViewPopup");
        add(caseViewPopup);

        caseViewPopup.setPageMapName(getString("titleCaseViewPopup"));
        caseViewPopup.setCookieName("caseViewModal");

        caseViewPopup.setTitle(getString("titleCaseViewPopup"));
        caseViewPopup.setCookieName("caseViewModal");

        final WebMarkupContainer container = new WebMarkupContainer("container");
        container.setOutputMarkupId(true);
        add(container);

        final ModalWindow reasonPopup = new ModalWindow("reasonRefusalCasePopup");
        add(reasonPopup);

        reasonPopup.setCookieName("reasonPopup");
        reasonPopup.setWindowClosedCallback(new ModalWindow.WindowClosedCallback() {

            private static final long serialVersionUID = 8804221891699487139L;

            public void onClose(AjaxRequestTarget target) {
                target.addComponent(container);
            }
        });

        listMedicineCase = caseManagement.getForApprove(getRemaraUser().getUsername());

        final ListView listView = new ListView("caseList", listMedicineCase) {

            private static final long serialVersionUID = 4949588177564901031L;

            @Override
            protected void populateItem(ListItem item) {
                final MedicineCase medicineCase = (MedicineCase) item.getModelObject();
                final String name = medicineCase.getPatient().getName() + " " + medicineCase.getPatient().getSurname();
                final String illness = medicineCase.getIllness().getExempt() + " - "
                        + medicineCase.getIllness().getDescription();
                final Date insertDate = medicineCase.getInsertDate();
                String insertDateString = "";
                if (insertDate != null) {
                    insertDateString = dateFormat.format(insertDate);
                }
                item.add(new Label("data", insertDateString));
                item.add(new Label("name", name));
                item.add(new Label("illness", illness));
                item.add(new Label("compiler", medicineCase.getOwner()));

                final AjaxLink viewLink = new AjaxLink("linkView", item.getModel()) {

                    private static final long serialVersionUID = 3776750333491622263L;

                    @Override
                    public void onClick(AjaxRequestTarget target) {
                        caseViewPopup.setPageCreator(new ModalWindow.PageCreator() {

                            private static final long serialVersionUID = -7834632442532690940L;

                            public Page createPage() {
                                final PageParameters parameters = new PageParameters();
                                parameters.put("medicineCase", medicineCase);
                                return new CaseViewPopup(parameters);
                            }
                        });
                        caseViewPopup.show(target);
                    }
                };
                viewLink.add(new SimpleAttributeModifier("title", getString("view")));
                item.add(viewLink);

                final Link linkApprove = new Link("linkApprove", item.getModel()) {

                    private static final long serialVersionUID = -5665438703028610801L;

                    @Override
                    public void onClick() {
                        try {
                            caseManagement.approve(medicineCase, getRemaraUser().getUsername());
                        } catch (DBException e) {
                            error(getString(e.getMessage()));
                            return;
                        }
                        getSession().info(getString("info.approve"));
                        setResponsePage(new WfReferentCase());
                    }
                };
                linkApprove.add(new SimpleAttributeModifier("title", getString("approve")));
                item.add(linkApprove);

                final AjaxLink linkUpdate = new AjaxLink("linkUpdate", item.getModel()) {

                    private static final long serialVersionUID = 3776750333491622263L;

                    @Override
                    public void onClick(final AjaxRequestTarget target) {
                        reasonPopup.setPageMapName(getString("titleReasonUpdateCasePopup"));
                        reasonPopup.setPageCreator(new ModalWindow.PageCreator() {

                            private static final long serialVersionUID = -7834632442532690940L;

                            public Page createPage() {
                                final PageParameters pageParameters = new PageParameters();
                                pageParameters.put("medicineCase", medicineCase);
                                pageParameters.put("action", ReasonRefusalCasePopup.ACTION_UPDATE);
                                return new ReasonRefusalCasePopup(pageParameters, reasonPopup, WfReferentCase.this);
                            }
                        });
                        reasonPopup.show(target);
                    }
                };
                linkUpdate.add(new SimpleAttributeModifier("title", getString("update")));
                item.add(linkUpdate);

                final AjaxLink linkReject = new AjaxLink("linkReject", item.getModel()) {

                    private static final long serialVersionUID = 3776750333491622263L;

                    @Override
                    public void onClick(final AjaxRequestTarget target) {
                        reasonPopup.setPageMapName(getString("titleReasonRejectCasePopup"));
                        reasonPopup.setPageCreator(new ModalWindow.PageCreator() {

                            private static final long serialVersionUID = -7834632442532690940L;

                            public Page createPage() {
                                final PageParameters pageParameters = new PageParameters();
                                pageParameters.put("medicineCase", medicineCase);
                                pageParameters.put("action", ReasonRefusalCasePopup.ACTION_REJECT);
                                return new ReasonRefusalCasePopup(pageParameters, reasonPopup, WfReferentCase.this);
                            }
                        });
                        reasonPopup.show(target);
                    }
                };
                linkReject.add(new SimpleAttributeModifier("title", getString("reject")));
                item.add(linkReject);
            }
        };

        container.add(listView);

    }

    public void requestUpdate(final MedicineCase medicineCase, final String reason) throws DBException {
        caseManagement.requestModifie(medicineCase, getRemaraUser().getUsername(), reason);
        listMedicineCase.remove(medicineCase);
    }

    public void reject(final MedicineCase medicineCase, final String reason) throws DBException {
        caseManagement.reject(medicineCase, getRemaraUser().getUsername(), reason);
        listMedicineCase.remove(medicineCase);
    }
}
