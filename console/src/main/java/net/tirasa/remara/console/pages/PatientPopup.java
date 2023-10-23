package net.tirasa.remara.console.pages;

import net.tirasa.remara.console.utilities.Constants;
import net.tirasa.remara.core.management.PatientManagement;
import java.util.List;
import net.tirasa.remara.persistence.data.Patient;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.markup.html.AjaxLink;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.extensions.ajax.markup.html.modal.ModalWindow;
import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.Button;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.list.ListItem;
import org.apache.wicket.markup.html.list.PageableListView;
import org.apache.wicket.markup.html.navigation.paging.PagingNavigator;
import org.apache.wicket.model.Model;
import org.apache.wicket.spring.injection.annot.SpringBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@AuthorizeInstantiation("ADMIN")
public class PatientPopup extends WebPage {

    private static final long serialVersionUID = -1154890340275619507L;

    private static final Logger LOG = LoggerFactory.getLogger(PatientPopup.class);

    @SpringBean
    private PatientManagement patientManagement;

    private static final String FIND_NAME = "findName";

    private static final String FIND_SURNAME = "findSurname";

    private TextField findName;

    private TextField findSurname;

    /**
     *
     * @param parameters
     * @param modalWindowPage
     * @param window
     */
    public PatientPopup(PageParameters parameters, final FindPopupPatient modalWindowPage, final ModalWindow window) {
        super(parameters);

        final Form findForm = new Form("search") {

            private static final long serialVersionUID = 7283381648682393116L;

            @Override
            protected void onSubmit() {
                PageParameters parameters = new PageParameters();
                parameters.put(FIND_NAME, findName.getModelObject());
                parameters.put(FIND_SURNAME, findSurname.getModelObject());
                setResponsePage(new PatientPopup(parameters, modalWindowPage, window));
            }
        };
        add(findForm);

        String name = "";
        if (parameters != null && parameters.containsKey(FIND_NAME)) {
            name = parameters.getString(FIND_NAME);
        }
        String surname = "";
        if (parameters != null && parameters.containsKey(FIND_SURNAME)) {
            surname = parameters.getString(FIND_SURNAME);
        }

        findName = new TextField(FIND_NAME, new Model(name));
        findForm.add(findName);

        findSurname = new TextField(FIND_SURNAME, new Model(surname));
        findForm.add(findSurname);

        findForm.add(new Button("find", new Model(getString("find"))));

        List<Patient> patientLists;
        if (parameters != null && parameters.containsKey(FIND_NAME)) {
            if (name == null) {
                name = "";
            }
            if (surname == null) {
                surname = "";
            }
            patientLists = patientManagement.findByNameAndSurname(name, surname);
        } else {
            patientLists = patientManagement.findAllPatient();
        }

        final PageableListView dataView = new PageableListView("patientList",
                patientLists, Constants.MAX_ROWS) {

            private static final long serialVersionUID = -9186076471982907981L;

            @Override
            protected void populateItem(ListItem item) {
                final Patient patient = (Patient) item.getModelObject();
                String name = patient.getName() + " " + patient.getSurname();
                item.add(new Label("name", name));

                String residence = "";
                if (patient.getLivingAddress() != null) {
                    residence = patient.getLivingAddress();
                }

                if (patient.getLivingMunicipality() != null) {
                    residence += " " + patient.getLivingMunicipality().getDescription();
                }
                if (patient.getLivingProvince() != null) {
                    residence += " (" + patient.getLivingProvince().getId() + ") ";
                }
                if (patient.getLivingCap() != null && !patient.getLivingCap().isEmpty()) {
                    residence += " - " + patient.getLivingCap();
                }
                item.add(new Label("residence", residence));

                AjaxLink linkSelect = new AjaxLink("linkSelect", item.getModel()) {

                    private static final long serialVersionUID = 3776750333491622263L;

                    public void onClick(AjaxRequestTarget target) {
                        if (modalWindowPage != null) {
                            modalWindowPage.setResultPatient(patient);
                        }
                        window.close(target);
                    }
                };
                item.add(linkSelect);
            }
        };
        add(dataView);
        add(new PagingNavigator("headerPaginator", dataView));
    }
}
