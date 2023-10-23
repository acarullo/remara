package net.tirasa.remara.console.pages;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import net.tirasa.remara.console.utilities.CFValidator;
import net.tirasa.remara.console.utilities.StringUtils;
import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.core.management.CaseManagement;
import net.tirasa.remara.core.management.PatientManagement;
import java.util.Arrays;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.regex.Pattern;
import net.tirasa.remara.console.utilities.Constants;
import net.tirasa.remara.core.management.Encoder;
import net.tirasa.remara.persistence.data.Education;
import net.tirasa.remara.persistence.data.Municipality;
import net.tirasa.remara.persistence.data.Occupation;
import net.tirasa.remara.persistence.data.Patient;
import net.tirasa.remara.persistence.data.Province;
import net.tirasa.remara.persistence.data.Region;
import org.apache.commons.lang.time.DateUtils;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.form.AjaxFormChoiceComponentUpdatingBehavior;
import org.apache.wicket.ajax.form.AjaxFormComponentUpdatingBehavior;
import org.apache.wicket.ajax.form.OnChangeAjaxBehavior;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.extensions.yui.calendar.DatePicker;
import org.apache.wicket.markup.html.WebMarkupContainer;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.Button;
import org.apache.wicket.markup.html.form.ChoiceRenderer;
import org.apache.wicket.markup.html.form.DropDownChoice;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.HiddenField;
import org.apache.wicket.markup.html.form.RadioChoice;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.markup.html.panel.Fragment;
import org.apache.wicket.model.AbstractReadOnlyModel;
import org.apache.wicket.model.CompoundPropertyModel;
import org.apache.wicket.model.IModel;
import org.apache.wicket.model.LoadableDetachableModel;
import org.apache.wicket.model.Model;
import org.apache.wicket.spring.injection.annot.SpringBean;
import org.apache.wicket.validation.IValidatable;
import org.apache.wicket.validation.IValidator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@AuthorizeInstantiation("ADMIN")
public class NewPatient extends BasePage {

    private static final int YEARS = 25;

    private static final long serialVersionUID = -1762685916904313348L;

    private static final Logger LOG = LoggerFactory.getLogger(NewPatient.class);

    @SpringBean
    private PatientManagement patientManagement;

    @SpringBean
    private CaseManagement caseManagement;

    private Patient patient = null;

    private boolean newPatient;

    private Form form;

    private Fragment f1;

    private Fragment f2;

    private TextField name;

    private IModel<String> nameModel;

    private TextField surname;

    private IModel<String> surnameModel;

    private RadioChoice sex;

    private IModel modelLSex;

    private TextField birthDate;

    private Model<Date> birthDateModel;

    private TextField deathDate;

    private Model<Date> deathDateModel;

    private TextField taxCode;

    private IModel<String> taxCodeModel;

    private TextField livingCap;

    private IModel<String> livingCapModel;

    private TextField livingAddress;

    private IModel<String> livingAddressModel;

    private TextField<String> exactlyOccupation;

    private IModel<String> exactlyOccupationModel;

    private TextField telephone;

    private IModel telephoneModel;

    private DropDownChoice personalEducation;

    private IModel personalEducationModel;

    private IModel motherEducationModel;

    private DropDownChoice motherEducation;

    private IModel fatherEducationModel;

    private DropDownChoice fatherEducation;

    private DropDownChoice personalOccupation;

    private IModel personalOccupationModel;

    private IModel motherOccupationModel;

    private DropDownChoice motherOccupation;

    private DropDownChoice fatherOccupation;

    private IModel fatherOccupationModel;

    private IModel livingMunicipalityModel;

    private DropDownChoice livingMunicipality;

    private WebMarkupContainer parentEduOccContainer;

    private final SimpleDateFormat dateFormat = new SimpleDateFormat(getString("format_date"));

    private Boolean verifyDate = true;

    private boolean verifyForm() {

        toUtf(patient);

        boolean verify = true;
        String patientName = patient.getName();
        if (patientName == null || patientName.isEmpty()) {
            error(getString("patient.name.Required"));
            verify = false;
        } else if (!StringUtils.containsLowerCase(patientName)) {
            error(getString(WRONG_CHAR));
            verify = false;
        }
        String patientSurname = patient.getSurname();
        if (patientSurname == null || patientSurname.isEmpty()) {
            error(getString("patient.surname.Required"));
            verify = false;
        } else if (!StringUtils.containsLowerCase(patientSurname)) {
            error(getString(WRONG_CHAR));
            verify = false;
        }
        String cf = patient.getTaxCode();
        if (cf == null || cf.isEmpty()) {
            error(getString("patient.taxCode.Required"));
            verify = false;
        } else if (!StringUtils.containsLowerCase(cf)) {
            error(getString(WRONG_CHAR));
            verify = false;
        }
        String patientSex = patient.getSex();
        if (patientSex == null || patientSex.isEmpty()) {
            error(getString("patient.sex.Required"));
            verify = false;
        }
        Date patientBirthDate = patient.getBirthDate();
        String anno;
        if (patientBirthDate == null) {
            error(getString("patient.birthDate.Required"));
            verify = false;
        }
        if (cf != null && !cf.isEmpty()) {
            if (cf.length() != 16) {
                error(getString("error.cf_length_not_valid"));
                verify = false;
            } else {
                if (!CFValidator.validate(cf)) {
                    error(getString("cf_not_valid"));
                    verify = false;
                }
                if (patientBirthDate != null) {
                    GregorianCalendar gc = new GregorianCalendar();
                    gc.setTime(patientBirthDate);
                    anno = String.valueOf(gc.get(GregorianCalendar.YEAR));
                    if (!anno.substring(2).equals(cf.substring(6, 8))) {
                        error(getString("error.cf_year_not_valid"));
                        verify = false;
                    }
                }
            }
        }

        String foreigner = patient.getForeigner();
        if (foreigner.equals(getString("foreign1"))) {
            if (patient.getBirthRegion() == null) {
                error(getString("patient.birthRegion.Required"));
                verify = false;
            }
            if (patient.getBirthProvince() == null) {
                error(getString("patient.birthProvince.Required"));
                verify = false;
            }
            if (patient.getBirthMunicipality() == null) {
                error(getString("patient.birthMunicipality.Required"));
                verify = false;
            }
            String birthCap = patient.getBirthCap();
            if (birthCap == null || birthCap.isEmpty()) {
                error(getString("patient.birthCap.Required"));
                verify = false;
            }
        } else {
            if (patient.getBirthNation() == null) {
                error(getString("patient.birthNation.Required"));
                verify = false;
            }
        }
        if (patient.getLivingRegion() == null) {
            error(getString("patient.livingRegion.Required"));
            verify = false;
        }
        if (patient.getLivingProvince() == null) {
            error(getString("patient.livingProvince.Required"));
            verify = false;
        }
        if (patient.getLivingMunicipality() == null) {
            error(getString("patient.livingMunicipality.Required"));
            verify = false;
        }
        String patientLivingCap = patient.getLivingCap();
        if (patientLivingCap == null || patientLivingCap.isEmpty()) {
            error(getString("patient.livingCap.Required"));
            verify = false;
        }
        String patientLivingAddress = patient.getLivingAddress();
        if (patientLivingAddress == null || patientLivingAddress.isEmpty()) {
            error(getString("patient.livingAddress.Required"));
            verify = false;
        } else if (!StringUtils.containsLowerCase(patientLivingAddress)) {
            error(getString(WRONG_CHAR));
            verify = false;
        }
        if (patientBirthDate != null) {
            GregorianCalendar gc = new GregorianCalendar();
            gc.setTime(new Date());
            gc.add(GregorianCalendar.YEAR, -YEARS);
            if (patientBirthDate.after(gc.getTime())) {
                if ((patient.getMotherEducation() == null)
                        && (patient.getFatherEducation() == null)) {
                    error(getString("patient.parentEducation.Required"));
                    verify = false;
                }
                if ((patient.getMotherOccupation() == null)
                        && (patient.getFatherOccupation() == null)) {
                    error(getString("patient.parentOccupation.Required"));
                    verify = false;
                }
            } else {
                if (patient.getPersonalEducation() == null) {
                    error(getString("patient.Education.Required"));
                    verify = false;
                }
                if (patient.getPersonalOccupation() == null) {
                    error(getString("patient.Occupation.Required"));
                    verify = false;
                }
            }
        }

        return verify;
    }

    /**
     *
     * @param parameters
     */
    private void createForm(final PageParameters parameters) {
        newPatient = false;
        if (parameters.containsKey("patient")) {
            patient = (Patient) parameters.get("patient");
            if (patient.getBirthNation() != null && getString("foreign1").equalsIgnoreCase(patient.getForeigner())) {
                patient.setBirthNation(null);
                patient.setBirthForeignInformation(null);
            }
            add(new Label("new_patient", getString("new_patient.update")));
        } else {
            patient = new Patient();
            patient.setForeigner(getString("foreign1"));
            newPatient = true;
            add(new Label("new_patient", getString("new_patient.new")));
        }
        add(new FeedbackPanel("feedback"));
        form = new Form("patientForm", new CompoundPropertyModel(patient)) {

            private static final long serialVersionUID = -3061771342119019368L;

            @Override
            protected void onSubmit() {
                if (!verifyForm() || !verifyDate) {
                    return;
                }
                try {
                    if (newPatient) {
                        patientManagement.insert(patient);
                    } else {
                        patientManagement.update(patient);
                    }
                } catch (DBException e) {
                    error(getString(e.getMessage()));
                    return;
                }
                getSession().info(getString("info.save"));
                setResponsePage(new ListPatients(null));
            }
        };
        add(form);
    }

    private void createPatientName() {
        nameModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                String name = patient.getName();
                if (name == null) {
                    return null;
                }
                return name;
            }

            @Override
            public void setObject(final Serializable object) {
                if (object == null) {
                    patient.setName("");
                } else {
                    patient.setName((String) object);
                }
            }
        };
        name = new TextField("name", nameModel);
        name.add(new SimpleAttributeModifier("title", getString("name")));
        name.setOutputMarkupId(true);
        form.add(name);

        surnameModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                String surname = patient.getSurname();
                if (surname == null) {
                    return null;
                }
                return surname;
            }

            @Override
            public void setObject(final Serializable object) {
                LOG.debug("PATIENT {}", patient);
                if (object == null) {
                    patient.setSurname("");
                } else {
                    patient.setSurname((String) object);
                }
            }
        };
        surname = new TextField("surname", surnameModel);
        surname.add(new SimpleAttributeModifier("title", getString("surname")));
        surname.setOutputMarkupId(true);
        form.add(surname);

        taxCodeModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                String taxCode = patient.getTaxCode();
                if (taxCode == null) {
                    return null;
                }
                return taxCode;
            }

            @Override
            public void setObject(Serializable object) {
                patient.setTaxCode((String) object);
            }
        };
        taxCode = new TextField("taxCode", taxCodeModel);
        taxCode.setEnabled(newPatient);
        taxCode.add(new SimpleAttributeModifier("title", getString("taxCode")));
        form.add(taxCode);

        telephoneModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Long getObject() {
                return patient.getTelephone();
            }

            @Override
            public void setObject(final Object object) {
                try {
                    if (object != null) {
                        patient.setTelephone(Long.valueOf(object.toString()));
                    } else {
                        patient.setTelephone(null);
                    }
                } catch (NumberFormatException e) {
                    LOG.error("Not valid telephone number", e);
                    error("Not Valid telephone number");
                }
            }
        };
        telephone = new TextField("telephone", telephoneModel);
        telephone.add(new SimpleAttributeModifier("title", getString("telephone")));
        form.add(telephone);

        modelLSex = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                String sex = patient.getSex();
                if (sex == null || sex.isEmpty()) {
                    return null;
                }
                return getString(sex);
            }

            @Override
            public void setObject(final Serializable object) {
                super.setObject(object);
                patient.setSex(null);
                if (object == null) {
                    return;
                }
                String sex = object.toString();
                if (sex.equals(getString("F"))) {
                    patient.setSex(getString("F"));
                } else {
                    patient.setSex(getString("M"));
                }
            }
        };

        List sexs = Arrays.asList(new String[]{"M", "F"});
        sex = new RadioChoice("sex", modelLSex, sexs);
        sex.setOutputMarkupId(true);
        form.add(sex);

        birthDateModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                Date birthDate = patient.getBirthDate();
                if (birthDate == null) {
                    return null;
                }
                return dateFormat.format(birthDate);
            }

            @Override
            public void setObject(Serializable object) {
                if (object != null) {

                    if (object instanceof Date) {

                        Date data = (Date) object;

                        LOG.info("Setting patient birth date to {}", data);

                        patient.setBirthDate(data);
                    } else {
                        try {
                            LOG.info("Setting patient birth date to {}", object.toString());
                            patient.setBirthDate(dateFormat.parse(object.toString()));
                        } catch (ParseException ex) {
                            LOG.error("Error parsing patient birth date {}", ex.getMessage(), ex);
                        }
                    }

                } else {
                    patient.setBirthDate(null);
                }
            }
        };
//        birthDate = DateTextField.forDatePattern("birthDate", birthDateModel, getString("format_date"));

        birthDate = new TextField<Date>("birthDate", birthDateModel);

        birthDate.add(new SimpleAttributeModifier("title", getString("birthDate")));

        birthDate.add(new CustomDateValidator());

        final DatePicker birthDatePicker = new DatePicker() {

            private static final long serialVersionUID = 4166072895162221956L;

            @Override
            protected String getDatePattern() {
                return getString("format_date");
            }

            public void setFORMAT_DATE() {
                DatePicker.FORMAT_DATE = getString("format_date");
            }

            @Override
            protected boolean enableMonthYearSelection() {
                return true;
            }
        };

        birthDate.add(birthDatePicker);

        birthDate.add(new OnChangeAjaxBehavior() {

            private static final long serialVersionUID = -151291731388673682L;

            @Override
            protected void onUpdate(AjaxRequestTarget target) {
                form.modelChanged();

                Date date = null;
                try {
                    if (birthDate.getModelObject() != null) {
                        date = dateFormat.parse(birthDate.getModelObject().toString());
                    }
                } catch (ParseException ex) {
                    LOG.error("Error parsing birth date {}", ex.getMessage(), ex);
                }

                if (birthDate.getModelObject() != null && DateUtils.addYears(date, YEARS).
                        after(new Date())) {
                    parentEduOccContainer.setVisible(true);
                } else {
                    parentEduOccContainer.setVisible(false);
                }
                target.addComponent(parentEduOccContainer);
            }
        });
        birthDate.setOutputMarkupId(true);
        form.add(birthDate);

        deathDateModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                Date deathDate = patient.getDeathDate();
                if (deathDate == null) {
                    return null;
                }
                return dateFormat.format(deathDate);
            }

            @Override
            public void setObject(Serializable object) {

                if (object != null) {
                    if (object instanceof Date) {

                        Date data = (Date) object;

                        LOG.info("Setting death date to {}", data);

                        patient.setDeathDate(data);
                    } else {
                        try {
                            LOG.info("Setting death date illness to {}", object.toString());
                            patient.setDeathDate(dateFormat.parse(object.toString()));
                        } catch (ParseException ex) {
                            LOG.error("Error parsing diagnosis date illness {}", ex.getMessage(), ex);
                        }
                    }
                } else {
                    patient.setDeathDate(null);
                }
            }
        };

        deathDate = new TextField<Date>("deathDate", deathDateModel);

        final DatePicker deathDatePicker = new DatePicker() {

            private static final long serialVersionUID = 4166072895162221956L;

            @Override
            protected String getDatePattern() {
                return getString("format_date");
            }

            public void setFORMAT_DATE() {
                DatePicker.FORMAT_DATE = getString("format_date");
            }

            @Override
            protected boolean enableMonthYearSelection() {
                return true;
            }
        };

        deathDate.add(new CustomDateValidator());

        deathDate.add(new SimpleAttributeModifier("title", getString("deathDate")));
        deathDate.add(deathDatePicker);
        deathDate.setOutputMarkupId(true);
        form.add(deathDate);

    }

    private void createPatientAdressLiving(List<Region> regions) {
        ChoiceRenderer renderer = new ChoiceRenderer("description", "id");
        IModel modelLMunicipality = new AbstractReadOnlyModel() {

            private static final long serialVersionUID = -2583290457773357445L;

            @Override
            public List<Municipality> getObject() {
                return caseManagement.getMunicipality(patient.getLivingProvince());
            }
        };

        livingMunicipalityModel = new Model() {

            private static final long serialVersionUID = 3109256773218160485L;

            @Override
            public Serializable getObject() {
                if (patient.getLivingMunicipality() != null) {
                    return patient.getLivingMunicipality();
                }
                return null;
            }

            @Override
            public void setObject(Serializable object) {
                super.setObject(object);
                if (object instanceof Municipality) {
                    patient.setLivingMunicipality((Municipality) object);
                } else if (object instanceof String && !object.toString().isEmpty()) {
                    patient.setLivingMunicipality(caseManagement.findMunicipality(Long.parseLong(object.toString())));
                } else {
                    patient.setLivingMunicipality(null);
                }
            }
        };
        livingMunicipality = new DropDownChoice("livingMunicipality", livingMunicipalityModel, modelLMunicipality,
                renderer);
        livingMunicipality.add(new SimpleAttributeModifier("title", getString("livingMunicipality")));
        livingMunicipality.setOutputMarkupId(true);
        form.add(livingMunicipality);

        IModel modelLProvince = new AbstractReadOnlyModel() {

            private static final long serialVersionUID = -2583290457773357445L;

            @Override
            public List<Province> getObject() {
                return caseManagement.getProvince(patient.getLivingRegion());
            }
        };
        DropDownChoice livingProvince = new DropDownChoice("livingProvince", modelLProvince, renderer);
        livingProvince.setOutputMarkupId(true);
        livingProvince.add(new SimpleAttributeModifier("title", getString("livingProvince")));
        livingProvince.add(new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

            private static final long serialVersionUID = -1107858522700306810L;

            @Override
            protected void onUpdate(AjaxRequestTarget target) {
                target.addComponent(form.get("livingMunicipality"));
            }
        });
        form.add(livingProvince);

        DropDownChoice livingRegion = new DropDownChoice("livingRegion", regions, renderer);
        livingRegion.setOutputMarkupId(true);
        livingRegion.add(new SimpleAttributeModifier("title", getString("livingRegion")));
        livingRegion.add(new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

            private static final long serialVersionUID = -1107858522700306810L;

            @Override
            protected void onUpdate(AjaxRequestTarget target) {
                target.addComponent(form.get("livingProvince"));
                target.addComponent(form.get("livingMunicipality"));
            }
        });
        form.add(livingRegion);

        livingCapModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                String livingCap = patient.getLivingCap();
                if (livingCap == null) {
                    return null;
                }
                return livingCap;
            }

            @Override
            public void setObject(Serializable object) {
                patient.setLivingCap((String) object);
            }
        };
        livingCap = new TextField("livingCap", livingCapModel);
        livingCap.add(new SimpleAttributeModifier("title", getString("livingCap")));
        form.add(livingCap);

        livingAddressModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                String livingAddress = patient.getLivingAddress();
                if (livingAddress == null) {
                    return null;
                }
                return livingAddress;
            }

            @Override
            public void setObject(Serializable object) {
                patient.setLivingAddress((String) object);
            }
        };
        livingAddress = new TextField("livingAddress", livingAddressModel);
        livingAddress.add(new SimpleAttributeModifier("title", getString("livingAddress")));
        form.add(livingAddress);
    }

    private void createPatientAdressBirth(List<Region> regions) {

        f1 = new Fragment("fragmentContainer", "fragment1", form);
        f1.setOutputMarkupId(true);
        f2 = new Fragment("fragmentContainer", "fragment2", form);
        f2.setOutputMarkupId(true);
        List nations = Arrays.asList(new String[]{getString("foreign1"), getString("foreign2")});
        final RadioChoice rc = new RadioChoice("foreigner", nations);
        rc.add(new AjaxFormChoiceComponentUpdatingBehavior() {

            private static final long serialVersionUID = -151291731388673682L;

            @Override
            protected void onUpdate(AjaxRequestTarget target) {
                form.modelChanged();
                nameModel.setObject(name.getInput());
                surnameModel.setObject(surname.getInput());
                if (newPatient) {
                    taxCodeModel.setObject(taxCode.getInput());
                } else {
                    taxCodeModel.setObject(patient.getTaxCode());
                }
                telephoneModel.setObject(telephone.getInput());
                livingCapModel.setObject(livingCap.getInput());
                livingAddressModel.setObject(livingAddress.getInput());
                exactlyOccupationModel.setObject(exactlyOccupation.getInput());
                try {
                    birthDateModel.setObject(dateFormat.parse(birthDate.getInput()));
                    deathDateModel.setObject(dateFormat.parse(deathDate.getInput()));
                } catch (ParseException e) {
                    LOG.error("Errore nel parsing della data di nascita del paziente");
                }
                if (sex.getInput() != null && Integer.parseInt(sex.getInput()) == 1) {
                    modelLSex.setObject(getString("F"));
                } else {
                    modelLSex.setObject(getString("M"));
                }

                if (personalEducation.getInput() != null) {
                    personalEducationModel.setObject(personalEducation.getInput());
                }
                if (personalOccupation.getInput() != null) {
                    personalOccupationModel.setObject(personalOccupation.getInput());
                }
                if (motherEducation.getInput() != null) {
                    motherEducationModel.setObject(motherEducation.getInput());
                }
                if (fatherEducation.getInput() != null) {
                    fatherEducationModel.setObject(fatherEducation.getInput());
                }
                if (motherOccupation.getInput() != null) {
                    motherOccupationModel.setObject(motherOccupation.getInput());
                }
                if (fatherOccupation.getInput() != null) {
                    fatherOccupationModel.setObject(fatherOccupation.getInput());
                }
                if (livingMunicipality.getInput() != null) {
                    livingMunicipalityModel.setObject(livingMunicipality.getInput());
                }
                if (getString("foreign1").equalsIgnoreCase(rc.getDefaultModelObjectAsString())) {
                    form.addOrReplace(f1);
                    if (!newPatient && patient.getBirthNation() != null) {
                        patient.setBirthNation(null);
                        patient.setBirthForeignInformation(null);
                    }
                } else {
                    form.addOrReplace(f2);
                }
                target.addComponent(form);
            }
        });

        if (newPatient || patient.getBirthNation() == null) {
            form.add(f1);
        } else {
            form.add(f2);
        }
        form.add(rc);

        IModel modelLCadastre = new LoadableDetachableModel() {

            private static final long serialVersionUID = 1881223977635673509L;

            @Override
            public String getObject() {
                if (patient.getBirthMunicipality() != null) {
                    return patient.getBirthMunicipality().getCadastre();
                }
                return "";
            }

            @Override
            protected Object load() {
                if (patient.getBirthMunicipality() != null) {
                    return patient.getBirthMunicipality().getCadastre();
                }
                return "";
            }
        };
        HiddenField cadastre = new HiddenField("cadastre", modelLCadastre);
        cadastre.setOutputMarkupId(true);
        form.add(cadastre);

        ChoiceRenderer renderer = new ChoiceRenderer("description", "id");
        IModel modelMunicipality = new AbstractReadOnlyModel() {

            private static final long serialVersionUID = -2583290457773357445L;

            @Override
            public List<Municipality> getObject() {
                return caseManagement.getMunicipality(patient.getBirthProvince());
            }
        };
        DropDownChoice birthMunicipality = new DropDownChoice("birthMunicipality", modelMunicipality,
                renderer);
        birthMunicipality.setOutputMarkupId(true);
        birthMunicipality.add(new SimpleAttributeModifier("title", getString("birthMunicipality")));
        birthMunicipality.add(new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

            private static final long serialVersionUID = -1107858522700306810L;

            @Override
            protected void onUpdate(AjaxRequestTarget target) {
                target.addComponent(form.get("cadastre"));
            }
        });
        f1.add(birthMunicipality);

        IModel modelProvince = new AbstractReadOnlyModel() {

            private static final long serialVersionUID = -2583290457773357445L;

            @Override
            public List<Province> getObject() {
                return caseManagement.getProvince(patient.getBirthRegion());
            }
        };
        DropDownChoice birthProvince = new DropDownChoice("birthProvince", modelProvince, renderer);
        birthProvince.setOutputMarkupId(true);
        birthProvince.add(new SimpleAttributeModifier("title", getString("birthProvince")));
        birthProvince.add(new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

            private static final long serialVersionUID = -1107858522700306810L;

            @Override
            protected void onUpdate(AjaxRequestTarget target) {
                target.addComponent(f1.get("birthMunicipality"));
            }
        });
        f1.add(birthProvince);

        DropDownChoice birthRegion = new DropDownChoice("birthRegion", regions, renderer);
        birthRegion.setOutputMarkupId(true);
        birthRegion.add(new SimpleAttributeModifier("title", getString("birthRegion")));
        birthRegion.add(new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

            private static final long serialVersionUID = -1107858522700306810L;

            @Override
            protected void onUpdate(AjaxRequestTarget target) {
                target.addComponent(f1.get("birthProvince"));
                target.addComponent(f1.get("birthMunicipality"));
            }
        });
        f1.add(birthRegion);

        TextField birthCap = new TextField("birthCap");
        birthCap.add(new SimpleAttributeModifier("title", getString("birthCap")));
        f1.add(birthCap);

        ChoiceRenderer rendererIt = new ChoiceRenderer("descriptionIt", "id");

        DropDownChoice birthNation = new DropDownChoice("birthNation", caseManagement.getNations(), rendererIt);
        birthNation.add(new SimpleAttributeModifier("title", getString("birthNation")));
        f2.add(birthNation);

        TextField birthForeignInformation = new TextField("birthForeignInformation");
        birthForeignInformation.add(new SimpleAttributeModifier("title", getString(
                "birthForeignInformation")));
        f2.add(birthForeignInformation);
    }

    private void createEduOcc() {
        ChoiceRenderer renderer = new ChoiceRenderer("descriptionIt", "id");

        List<Education> educations = caseManagement.getEducations();
        List<Occupation> occupations = caseManagement.getOccupations();

        personalEducationModel = new Model() {

            private static final long serialVersionUID = 3109256773218160485L;

            @Override
            public Serializable getObject() {
                if (patient.getPersonalEducation() != null) {
                    return patient.getPersonalEducation();
                }
                return null;
            }

            @Override
            public void setObject(Serializable object) {
                super.setObject(object);
                if (object instanceof Education) {
                    patient.setPersonalEducation((Education) object);
                } else if (object instanceof String && !object.toString().isEmpty()) {
                    patient.setPersonalEducation(caseManagement.findEducation(Long.parseLong(object.toString())));
                } else {
                    patient.setPersonalEducation(null);
                }
            }
        };
        personalEducation = new DropDownChoice("personalEducation", personalEducationModel, educations,
                renderer);
        personalEducation.add(new SimpleAttributeModifier("title", getString("personalEducation")));
        form.add(personalEducation);

        personalOccupationModel = new Model() {

            private static final long serialVersionUID = 3109256773218160485L;

            @Override
            public Serializable getObject() {
                if (patient.getPersonalOccupation() != null) {
                    return patient.getPersonalOccupation();
                }
                return null;
            }

            @Override
            public void setObject(Serializable object) {
                super.setObject(object);
                if (object instanceof Occupation) {
                    patient.setPersonalOccupation((Occupation) object);
                } else if (object instanceof String && !object.toString().isEmpty()) {
                    patient.setPersonalOccupation(caseManagement.findOccupation(Long.parseLong(object.toString())));
                } else {
                    patient.setPersonalOccupation(null);
                }
            }
        };
        personalOccupation = new DropDownChoice("personalOccupation", personalOccupationModel, occupations, renderer);
        personalOccupation.add(new SimpleAttributeModifier("title", getString("personalOccupation")));
        form.add(personalOccupation);

        exactlyOccupationModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                String exactlyOccupation = patient.getExactlyOccupation();
                if (exactlyOccupation == null) {
                    return null;
                }
                return exactlyOccupation;
            }

            @Override
            public void setObject(Serializable object) {
                patient.setExactlyOccupation((String) object);
            }
        };
        exactlyOccupation = new TextField("exactlyOccupation", exactlyOccupationModel);
        exactlyOccupation.add(
                new SimpleAttributeModifier("title", getString("exactlyOccupation")));
        form.add(exactlyOccupation);

        ///////// BEGINNING OF PARENT EDUCATION-OCCUPATION //////////
        parentEduOccContainer = new WebMarkupContainer("parentContainer");

        motherEducationModel = new Model() {

            private static final long serialVersionUID = 3109256773218160485L;

            @Override
            public Serializable getObject() {
                if (patient.getMotherEducation() != null) {
                    return patient.getMotherEducation();
                }
                return null;
            }

            @Override
            public void setObject(Serializable object) {
                super.setObject(object);
                if (object instanceof Education) {
                    patient.setMotherEducation((Education) object);
                } else if (object instanceof String && !object.toString().isEmpty()) {
                    patient.setMotherEducation(caseManagement.findEducation(Long.parseLong(object.toString())));
                } else {
                    patient.setMotherEducation(null);
                }
            }
        };
        motherEducation = new DropDownChoice("motherEducation", motherEducationModel, educations, renderer);
        motherEducation.add(new SimpleAttributeModifier("title", getString("motherEducation")));
        parentEduOccContainer.add(motherEducation);

        fatherEducationModel = new Model() {

            private static final long serialVersionUID = 3109256773218160485L;

            @Override
            public Serializable getObject() {
                if (patient.getFatherEducation() != null) {
                    return patient.getFatherEducation();
                }
                return null;
            }

            @Override
            public void setObject(Serializable object) {
                super.setObject(object);
                if (object instanceof Education) {
                    patient.setFatherEducation((Education) object);
                } else if (object instanceof String && !object.toString().isEmpty()) {
                    patient.setFatherEducation(caseManagement.findEducation(Long.parseLong(object.toString())));
                } else {
                    patient.setFatherEducation(null);
                }
            }
        };
        fatherEducation = new DropDownChoice("fatherEducation", fatherEducationModel, educations, renderer);
        fatherEducation.add(new SimpleAttributeModifier("title", getString("fatherEducation")));
        parentEduOccContainer.add(fatherEducation);

        motherOccupationModel = new Model() {

            private static final long serialVersionUID = 3109256773218160485L;

            @Override
            public Serializable getObject() {
                if (patient.getMotherOccupation() != null) {
                    return patient.getMotherOccupation();
                }
                return null;
            }

            @Override
            public void setObject(Serializable object) {
                super.setObject(object);
                if (object instanceof Occupation) {
                    patient.setMotherOccupation((Occupation) object);
                } else if (object instanceof String && !object.toString().isEmpty()) {
                    patient.setMotherOccupation(caseManagement.findOccupation(Long.parseLong(object.toString())));
                } else {
                    patient.setMotherOccupation(null);
                }
            }
        };
        motherOccupation = new DropDownChoice("motherOccupation", motherOccupationModel, occupations, renderer);
        motherOccupation.add(new SimpleAttributeModifier("title", getString("motherOccupation")));
        parentEduOccContainer.add(motherOccupation);

        fatherOccupationModel = new Model() {

            private static final long serialVersionUID = 3109256773218160485L;

            @Override
            public Serializable getObject() {
                if (patient.getFatherOccupation() != null) {
                    return patient.getFatherOccupation();
                }
                return null;
            }

            @Override
            public void setObject(Serializable object) {
                super.setObject(object);
                if (object instanceof Occupation) {
                    patient.setFatherOccupation((Occupation) object);
                } else if (object instanceof String && !object.toString().isEmpty()) {
                    patient.setFatherOccupation(caseManagement.findOccupation(Long.parseLong(object.toString())));
                } else {
                    patient.setFatherOccupation(null);
                }
            }
        };
        fatherOccupation = new DropDownChoice("fatherOccupation", fatherOccupationModel, occupations, renderer);
        fatherOccupation.add(new SimpleAttributeModifier("title", getString("fatherOccupation")));
        parentEduOccContainer.add(fatherOccupation);
        parentEduOccContainer.setOutputMarkupId(true);

        Date date = null;
        try {
            if (birthDate.getModelObject() != null) {
                date = dateFormat.parse(birthDate.getModelObject().toString());
            }
        } catch (ParseException ex) {
            LOG.error("Error parsing birth date {}", ex.getMessage(), ex);
        }

        if (birthDate.getModelObject() != null && DateUtils.addYears(date, YEARS).
                after(new Date())) {
            parentEduOccContainer.setVisible(true);
        } else {
            parentEduOccContainer.setVisible(false);
        }
        parentEduOccContainer.setOutputMarkupPlaceholderTag(true);
        form.add(parentEduOccContainer);
    }

    public NewPatient(PageParameters parameters) {
        super();
        createForm(parameters);
        createPatientName();
        List<Region> regions = caseManagement.getRegions();
        createPatientAdressBirth(regions);
        createPatientAdressLiving(regions);
        createEduOcc();

        Button save = new Button("save", new Model(getString("save")));
        form.add(save);
    }

    private void toUtf(Patient patient) {
        if (patient.getExactlyOccupation() != null) {
            patient.setExactlyOccupation(
                    Encoder.toUtf(patient.getExactlyOccupation()));
        }
        if (patient.getLivingAddress() != null) {
            patient.setLivingAddress(Encoder.toUtf(patient.getLivingAddress()));
        }

        if (patient.getName() != null) {
            patient.setName(Encoder.toUtf(patient.getName()));
        }

        if (patient.getSurname() != null) {
            patient.setSurname(Encoder.toUtf(patient.getSurname()));
        }
    }

    public class CustomDateValidator implements IValidator<String> {

        private static final long serialVersionUID = 5144828945491869293L;

        private final String DATE_PATTERN = "[0-9]{4}-[01]+[0-9]*-[0123][0-9]*";

        private final Pattern pattern;

        CustomDateValidator() {
            pattern = Pattern.compile(DATE_PATTERN);
        }

        @Override
        public void validate(IValidatable<String> validatable) {

            if (!pattern.matcher(validatable.getValue()).matches()) {
                error(validatable.getValue() + " " + getString("wrongDateFormat") + " " + getString("format_date"));
                verifyDate = false;
            } else if (!(validatable.getValue().contains("-") && Integer.parseInt(validatable.getValue().split("-")[1])
                    <= 12 && Integer.parseInt(validatable.getValue().split("-")[1]) >= 1)) {

                error(validatable.getValue() + " " + getString("wrongDateFormat") + " " + getString("format_date"));
                verifyDate = false;

            } else {
                verifyDate = true;
            }
        }
    }
}
