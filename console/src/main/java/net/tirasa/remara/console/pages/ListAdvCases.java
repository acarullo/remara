package net.tirasa.remara.console.pages;

import net.tirasa.remara.console.utilities.Constants;
import net.tirasa.remara.console.layout.CaseAdvancedFind;
import net.tirasa.remara.console.layout.CaseFind;
import net.tirasa.remara.console.utilities.Roles;
import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.core.management.CaseManagement;
import net.tirasa.remara.core.resource.IResourcePDFImpl;
import net.tirasa.remara.core.workflow.WorkflowManager;
import java.util.List;
import net.tirasa.remara.core.dataprovider.CaseDataProvider;
import net.tirasa.remara.persistence.data.MedicineCase;
import org.apache.wicket.Page;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.markup.html.AjaxLink;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.extensions.ajax.markup.html.modal.ModalWindow;
import org.apache.wicket.extensions.markup.html.repeater.data.sort.OrderByBorder;
import org.apache.wicket.markup.html.WebResource;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.markup.html.link.ResourceLink;
import org.apache.wicket.markup.html.list.ListItem;
import org.apache.wicket.markup.html.list.PageableListView;
import org.apache.wicket.markup.html.navigation.paging.PagingNavigator;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.model.Model;
import org.apache.wicket.protocol.http.WebResponse;
import org.apache.wicket.spring.injection.annot.SpringBean;
import org.apache.wicket.util.resource.IResourceStream;

@AuthorizeInstantiation("ADMIN")
public class ListAdvCases extends BasePage {

    private static final long serialVersionUID = -1731898950940856696L;

    @SpringBean
    private CaseDataProvider caseDataProvider;

    @SpringBean
    private CaseManagement caseManagement;

    @SpringBean
    private IResourcePDFImpl iResourcePDFImpl;

    private long role;

    public ListAdvCases(PageParameters parameters) {
        super();
        role = getRemaraUser().getRole();

        add(new FeedbackPanel("feedback"));

        final ModalWindow caseViewPopup = new ModalWindow("caseViewPopup");
        add(caseViewPopup);

        caseViewPopup.setPageMapName(getString("titleCaseViewPopup"));
        caseViewPopup.setCookieName("caseViewModal");
        caseViewPopup.setTitle(getString("titleCaseViewPopup"));

        String code = "";
        if (parameters != null && parameters.containsKey("findText")) {
            code = parameters.getString("findText");
        }
        add(new CaseFind("findPanel", code));

        CaseAdvancedFind caseAdvancedFind = new CaseAdvancedFind("advancedFindPanel", parameters, ListAdvCases.class);
        add(caseAdvancedFind);
        if (parameters != null && parameters.containsKey("advanced")) {
            caseAdvancedFind.setVisible(true);
        } else {
            caseAdvancedFind.setVisible(false);
        }

        add(new Link("advancedSearch") {

            private static final long serialVersionUID = -4331619903296515985L;

            @Override
            public void onClick() {
                final PageParameters parameters = new PageParameters();
                parameters.remove("findText");
                parameters.add("advanced", "true");
                setResponsePage(new ListCases(parameters));
            }
        });

        String owner = "XOWNERX";
        if (getRemaraUser().getRole() == Roles.COMPILER.getCode()) {
            owner = getRemaraUser().getUsername();
        }
        String referent = "XREFERENTX";
        if (getRemaraUser().getRole() == Roles.REFERENT.getCode()) {
            referent = getRemaraUser().getUsername();
        }

        List<MedicineCase> caseLists;
        if (parameters != null && parameters.containsKey("findText")) {
            caseLists = caseManagement.findByCode(parameters.getString("findText"), owner, referent);
        } else {
            caseLists = caseManagement.getAllCases(owner, referent);
        }

        add(new Link("allCases") {

            private static final long serialVersionUID = -4331619903296515985L;

            @Override
            public void onClick() {
                final PageParameters parameters = new PageParameters();
                parameters.remove("findText");
                setResponsePage(new ListCases(parameters));
            }
        });

        final Label searchSizeLabel = new Label("searchSize", new Model<Integer>(null));
        searchSizeLabel.setOutputMarkupId(true);
        searchSizeLabel.setDefaultModelObject(caseLists.size());
        final PageableListView dataView = new PageableListView("caseList", caseLists, Constants.MAX_ROWS) {

            private static final long serialVersionUID = 3730925125889062563L;

            @Override
            protected void populateItem(ListItem item) {
                final MedicineCase medicineCase = (MedicineCase) item.getModelObject();
                String name = medicineCase.getPatient().getSurname() + " " + medicineCase.getPatient().getName();
                String illness = medicineCase.getIllness().getExempt() + " - " + medicineCase.getIllness().
                        getDescription();
                item.add(new Label("name", name));
                item.add(new Label("illness", illness));

                String status = getStatus(medicineCase);

                Label statusLabel = new Label("statusLabel", status);

                if ("Approved".equalsIgnoreCase(status)) {
                    statusLabel.add(new SimpleAttributeModifier("class", "label label-success"));
                } else if ("Rejected".equalsIgnoreCase(status)) {
                    statusLabel.add(new SimpleAttributeModifier("class", "label label-important"));
                } else if ("Underway".equalsIgnoreCase(status)) {
                    statusLabel.add(new SimpleAttributeModifier("class", "label label-warning"));
                } else if ("Assigned".equalsIgnoreCase(status)) {
                    statusLabel.add(new SimpleAttributeModifier("class", "label label-info"));
                } else if ("Queued".equalsIgnoreCase(status)) {
                    statusLabel.add(new SimpleAttributeModifier("class", "label"));
                } else if ("Modified".equalsIgnoreCase(status)) {
                    statusLabel.add(new SimpleAttributeModifier("class", "label label-inverse"));
                }

                item.add(statusLabel);

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

                WebResource export = new WebResource() {

                    private static final long serialVersionUID = 1L;

                    @Override
                    public IResourceStream getResourceStream() {
                        return iResourcePDFImpl.iResourcePDFImpl(medicineCase, false);
                    }

                    @Override
                    protected void setHeaders(final WebResponse response) {
                        super.setHeaders(response);
                        responeSetHeader(response);
                        response.setAttachmentHeader(medicineCase.getId() + ".pdf");
                    }
                };
                export.setCacheable(false);

                ResourceLink linkPrint = new ResourceLink("linkPrint", export);
                linkPrint.add(new SimpleAttributeModifier("title", getString("print")));
                if (role == 3 || !status.equals(WorkflowManager.STATUS_APPROVED)) {
                    linkPrint.setVisible(false);
                }
                item.add(linkPrint);

                Link linkDelete = new Link("linkDelete", item.getModel()) {

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
                        setResponsePage(new ListCases(null));
                    }
                };
                linkDelete.add(new SimpleAttributeModifier("title", getString("delete")));
                linkDelete.add(new SimpleAttributeModifier("onclick", "return confirm('" + getString(
                        "confirm_delete")
                        + "');"));
                if (role != 1) {
                    linkDelete.setVisible(false);
                }
                item.add(linkDelete);

            }
        };
        add(dataView);
        add(searchSizeLabel);
        add(new PagingNavigator("headerPaginator", dataView));
        add(new OrderByBorder("orderByName", "m.patient.surname", caseDataProvider));
    }

    public static String getStatus(final MedicineCase medicineCase) {
        String status = medicineCase.getStatusWorkflow();
        String reason = medicineCase.getReason();
        if (reason == null) {
            reason = "";
        }
        if (status != null && status.equals(WorkflowManager.STATUS_UNDERWAY) && !reason.isEmpty()) {
            status = "Modified";
        }
        return status;
    }
}
