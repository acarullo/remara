package net.tirasa.remara.console.layout;

import net.tirasa.remara.console.pages.ListPatients;
import net.tirasa.remara.console.wicket.FormComponentFactory;
import net.tirasa.remara.console.wicket.IModelRemaraFactory;
import net.tirasa.remara.core.management.CaseManagement;
import java.util.Arrays;
import java.util.List;
import net.tirasa.remara.console.utilities.Constants;
import net.tirasa.remara.persistence.data.Education;
import net.tirasa.remara.persistence.data.Occupation;
import net.tirasa.remara.persistence.data.Patient;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.form.AjaxFormComponentUpdatingBehavior;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.model.CompoundPropertyModel;
import org.apache.wicket.spring.injection.annot.SpringBean;

public class PatientAdvancedFind extends AbstractPanel {

    private static final long serialVersionUID = 7310015927481017816L;

    @SpringBean
    private CaseManagement caseManagement;

    private final FormComponentFactory formComponentFactory = new FormComponentFactory();

    private final IModelRemaraFactory iModelRemaraFactory = new IModelRemaraFactory();

    private final Form form;

    private Patient patient = null;

    public PatientAdvancedFind(final String id, final PageParameters parameters) {
        super(id);
        choicePatient(parameters);
        form = createForm();
        addPatientName();
        addNationality();
        addPatientAddressBirth();
        addPatientAddressLiving();
        addEduAndJob();
        add(form);
        form.add(formComponentFactory.button("find"));
        add(addLink());
    }

    private void choicePatient(final PageParameters parameters) {
        if (parameters.containsKey("patient")) {
            patient = (Patient) parameters.get("patient");
        } else {
            patient = new Patient();
        }
    }

    private Form createForm() {
        return new Form("search", new CompoundPropertyModel(patient)) {

            private static final long serialVersionUID = -3061771342119019368L;

            @Override
            protected void onSubmit() {
                PageParameters parameters = new PageParameters();
                if (patient != null) {
                    String sex = patient.getSex();
                    if (sex != null && sex.equals(getString("tutti"))) {
                        patient.setSex(null);
                    }
                    String foreign = patient.getForeigner();
                    if (foreign != null && foreign.equals(getString("tutti"))) {
                        patient.setForeigner(null);
                    }
                }
                parameters.put("patient", patient);
                setResponsePage(new ListPatients(parameters));
            }
        };
    }

    private void addPatientName() {
        form.add(formComponentFactory.textFieldWithDifferentSimpleAttributeModifierId("name",
                "patient.name"));
        form.add(formComponentFactory.textField("surname"));
        form.add(formComponentFactory.textField("taxCode"));
        form.add(formComponentFactory.radioChoice("sex", Arrays.asList(new String[]{"M", "F",
            getString("tutti")})));
        form.add(formComponentFactory.dateTextField("birthDate"));
        form.add(formComponentFactory.dateTextField("deathDate"));
    }

    private void addPatientAddressLiving() {
        form.add(formComponentFactory.dropDownChoice("description", "livingMunicipality",
                iModelRemaraFactory.municipalityIModelWithLivingProvince(patient)).setOutputMarkupId(true));

        form.add(formComponentFactory.dropDownChoice("description", "livingProvince",
                iModelRemaraFactory.provinceIModelWithLivingProvince(patient)).setOutputMarkupId(true).add(
                        ajaxUpdate(form, Arrays.asList(
                                        new String[]{"livingMunicipality"}))));

        form.add(formComponentFactory.dropDownChoice("description", "livingRegion",
                caseManagement.getRegions()).setOutputMarkupId(true).add(ajaxUpdate(form, Arrays.asList(
                                        new String[]{"livingProvince", "livingMunicipality"}))));

        form.add(formComponentFactory.textField("livingCap"));
    }

    public final AjaxFormComponentUpdatingBehavior ajaxUpdate(
            final Form form, final List<String> ids) {
        return new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

            private static final long serialVersionUID = -1107858522700306810L;

            @Override
            protected void onUpdate(final AjaxRequestTarget target) {
                for (final String id : ids) {
                    target.addComponent(form.get(id));
                }
            }
        };
    }

    private void addPatientAddressBirth() {
        form.add(formComponentFactory.dropDownChoice("description", "birthMunicipality",
                iModelRemaraFactory.municipalityIModelWithBirthProvince(patient)).setOutputMarkupId(true));

        form.add(formComponentFactory.dropDownChoice("description", "birthProvince",
                iModelRemaraFactory.provinceIModelWithBirthProvince(patient)).setOutputMarkupId(true).add(ajaxUpdate(
                                form, Arrays.asList(new String[]{"birthMunicipality"}))));

        form.add(formComponentFactory.dropDownChoice("description", "birthRegion",
                caseManagement.getRegions()).setOutputMarkupId(true).add(ajaxUpdate(form, Arrays.asList(
                                        new String[]{"birthProvince", "birthMunicipality"}))));

        form.add(formComponentFactory.textField("birthCap"));

        form.add(formComponentFactory.dropDownChoice("description", "birthNation",
                caseManagement.getNations()));
    }

    public final void addEduAndJob() {
        List<Education> educations = caseManagement.getEducations();
        List<Occupation> occupations = caseManagement.getOccupations();

        form.add(formComponentFactory.dropDownChoice("description",
                "personalEducation", educations));
        form.add(formComponentFactory.dropDownChoice("description",
                "personalOccupation", occupations));

        form.add(formComponentFactory.textField("exactlyOccupation"));

        form.add(formComponentFactory.dropDownChoice("description",
                "fatherEducation", educations));
        form.add(formComponentFactory.dropDownChoice("description",
                "motherEducation", educations));

        form.add(formComponentFactory.dropDownChoice("description",
                "motherOccupation", occupations));
        form.add(formComponentFactory.dropDownChoice("description",
                "fatherOccupation", occupations));
    }

    private void addNationality() {
        form.add(formComponentFactory.radioChoice("foreigner", Arrays.asList(
                new String[]{getString("foreign1"), getString("foreign2"), getString("tutti")})));
    }

    private Link addLink() {
        return new Link("link") {

            private static final long serialVersionUID = -4331619903296515985L;

            @Override
            public void onClick() {
                setResponsePage(new ListPatients(new PageParameters()));
            }
        };
    }
}
