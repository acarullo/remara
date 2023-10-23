package net.tirasa.remara.console.pages;

import java.util.List;
import net.tirasa.remara.console.utilities.Constants;
import net.tirasa.remara.console.layout.PatientFind;
import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.core.management.PatientManagement;
import net.tirasa.remara.persistence.data.Patient;
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
import org.apache.wicket.markup.html.list.PageableListView;
import org.apache.wicket.markup.html.navigation.paging.PagingNavigator;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class ListPatients extends BasePage {

    private static final long serialVersionUID = 6015259781360296758L;

    @SpringBean
    private PatientManagement patientManagement;

    private long role;

    public ListPatients(final PageParameters parameters) {
        super();

        role = getRemaraUser().getRole();

        add(new FeedbackPanel("feedback"));

        final ModalWindow patientViewPopup = createPatientViewPopup();
        add(patientViewPopup);

        String code = "";
        if (parameters != null && parameters.containsKey("findText")) {
            code = parameters.getString("findText");
        }
        add(new PatientFind("findPanel", code));

        List<Patient> patientLists;
        if (parameters != null && parameters.containsKey("findText")) {
            patientLists = patientManagement.findByCode(parameters.getString("findText"));
        } else {
            patientLists = patientManagement.findAllPatient();
        }

        add(new Link("allPatients") {

            private static final long serialVersionUID = -4331619903296515985L;

            @Override
            public void onClick() {
                final PageParameters parameters = new PageParameters();
                parameters.remove("findText");
                setResponsePage(new ListPatients(parameters));
            }
        });

        final PageableListView dataView = new PageableListView("patientList", patientLists, Constants.MAX_ROWS) {

            private static final long serialVersionUID = -9186076471982907981L;

            @Override
            protected void populateItem(final ListItem item) {
                final Patient patient = (Patient) item.getModelObject();
                String name = patient.getSurname() + " " + patient.getName();
                item.add(new Label("name", name));

                StringBuilder residence = new StringBuilder();
                if (patient.getLivingAddress() != null) {
                    residence.append(patient.getLivingAddress());
                }

                if (patient.getLivingMunicipality() != null) {
                    residence.append(" ").append(patient.getLivingMunicipality().getDescription());
                }
                if (patient.getLivingProvince() != null) {
                    residence.append(" (").append(patient.getLivingProvince().getId()).append(") ");

                }
                if (patient.getLivingCap() != null && !patient.getLivingCap().isEmpty()) {
                    residence.append(" - ").append(patient.getLivingCap());
                }
                item.add(new Label("residence", residence.toString()));

                AjaxLink linkView = new AjaxLink("linkView", item.getModel()) {

                    private static final long serialVersionUID = 3776750333491622263L;

                    @Override
                    public void onClick(final AjaxRequestTarget target) {
                        patientViewPopup.setPageCreator(
                                new ModalWindow.PageCreator() {

                            private static final long serialVersionUID = -7834632442532690940L;

                            public Page createPage() {
                                PageParameters parameters = new PageParameters();
                                parameters.put("patient", patient);
                                return new PatientViewPopup(parameters);
                            }
                        });
                        patientViewPopup.show(target);
                    }
                };
                linkView.add(new SimpleAttributeModifier("title", getString("view")));
                item.add(linkView);

                Link linkOpen = new Link("linkOpen", item.getModel()) {

                    private static final long serialVersionUID = -5665438703028610801L;

                    @Override
                    public void onClick() {
                        PageParameters parameters = new PageParameters();
                        parameters.put("patient", patient);
                        setResponsePage(new NewPatient(parameters));
                    }
                };
                linkOpen.add(new SimpleAttributeModifier("title", getString("open")));
                item.add(linkOpen);

                Link linkDelete = new Link("linkDelete", item.getModel()) {

                    private static final long serialVersionUID = -5665438703028610801L;

                    @Override
                    public void onClick() {
                        try {
                            patientManagement.delete(patient);
                        } catch (DBException e) {
                            error(getString(e.getMessage()));
                            return;
                        }

                        getSession().info(getString("info.delete"));
                        setResponsePage(new ListPatients(null));
                    }
                };
                linkDelete.add(new SimpleAttributeModifier("title", getString("delete")));
                linkDelete.add(new SimpleAttributeModifier("onclick", "return confirm('" + getString("confirm_delete")
                        + "');"));
                if (role != 1) {
                    linkDelete.setVisible(false);
                }
                item.add(linkDelete);

            }
        };
        add(dataView);
        add(new PagingNavigator("headerPaginator", dataView));
    }

    private ModalWindow createPatientViewPopup() {
        final ModalWindow patientViewPopup = new ModalWindow("patientViewPopup");
        patientViewPopup.setPageMapName(getString("titlePatientViewPopup"));
        patientViewPopup.setCookieName("patientViewModal");
        patientViewPopup.setTitle(getString("titlePatientViewPopup"));
        return patientViewPopup;
    }
}
