package net.tirasa.remara.console.pages;

import static net.tirasa.remara.console.pages.BasePage.CONFIRM;
import static net.tirasa.remara.console.pages.BasePage.ON;
import static net.tirasa.remara.console.pages.BasePage.REGION;

import net.tirasa.remara.console.utilities.Constants;
import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.core.management.CaseManagement;
import net.tirasa.remara.core.management.HospitalManagement;
import net.tirasa.remara.core.management.IllnessManagement;
import net.tirasa.remara.core.management.PatientManagement;
import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import net.tirasa.remara.persistence.data.Exam;
import net.tirasa.remara.persistence.data.FileCase;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import net.tirasa.remara.persistence.data.HospitalWard;
import net.tirasa.remara.persistence.data.Illness;
import net.tirasa.remara.persistence.data.MedicineCase;
import net.tirasa.remara.persistence.data.Patient;
import net.tirasa.remara.persistence.data.Region;
import org.apache.wicket.Page;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.form.AjaxFormChoiceComponentUpdatingBehavior;
import org.apache.wicket.ajax.form.AjaxFormComponentUpdatingBehavior;
import org.apache.wicket.ajax.markup.html.AjaxLink;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.datetime.markup.html.form.DateTextField;
import org.apache.wicket.extensions.ajax.markup.html.autocomplete.AutoCompleteTextField;
import org.apache.wicket.extensions.ajax.markup.html.modal.ModalWindow;
import org.apache.wicket.extensions.yui.calendar.DatePicker;
import org.apache.wicket.markup.ComponentTag;
import org.apache.wicket.markup.html.WebMarkupContainer;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.Button;
import org.apache.wicket.markup.html.form.CheckBox;
import org.apache.wicket.markup.html.form.ChoiceRenderer;
import org.apache.wicket.markup.html.form.DropDownChoice;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.HiddenField;
import org.apache.wicket.markup.html.form.RadioChoice;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.list.ListItem;
import org.apache.wicket.markup.html.list.ListView;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.markup.html.panel.Fragment;
import org.apache.wicket.model.AbstractReadOnlyModel;
import org.apache.wicket.model.CompoundPropertyModel;
import org.apache.wicket.model.IModel;
import org.apache.wicket.model.Model;
import org.apache.wicket.spring.injection.annot.SpringBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@AuthorizeInstantiation("ADMIN")
public class SavedCase extends BasePage implements FindPopupIllness, FindPopupPatient {

    private static final long serialVersionUID = -8864056901496344226L;

    private static final Logger LOG = LoggerFactory.getLogger(NewCase.class);

    @SpringBean
    private IllnessManagement illnessManagement;

    @SpringBean
    private HospitalManagement hospitalManagement;

    @SpringBean
    private CaseManagement caseManagement;

    @SpringBean
    private PatientManagement patientManagement;

    private MedicineCase medicineCase;

    private boolean newCase;

    private Form form;

    private Fragment f1;

    private Fragment f2;

    private String typeButton = "";

    private TextField exactlyIllness;

    private Patient patientSelected;

    private Illness illnessSelected;

    private ListView listView;

    private List<Exam> examToDelete;

    private List<FileCase> filesToDelete;

    private Exam editedExam;

    private List<FileCase> tempDeletedFiles;

    private Model<Boolean> categoryCMedicineModel;

    private CheckBox categoryCMedicine;

    public SavedCase(final PageParameters parameters) {
        super();
        createForm(parameters);
        createPopupPatient();
        createPopupIllness();
        createIllness();
        createPopupWard();
        createFindHospital();
        createExams();

        typeButton = "save";

        final Button confirm = new Button(CONFIRM,
                new Model(getString(CONFIRM))) {

            private static final long serialVersionUID = 429178684321093953L;

            @Override
            public void onSubmit() {
                typeButton = CONFIRM;
            }
        };
        confirm.setEnabled(!newCase);
        confirm.setVisible(false);
        form.add(confirm);
    }

    private boolean verifyForm() {
        boolean verify = true;
        final String typeStartingDate = medicineCase.getTypeStartingDate();
        if (typeStartingDate == null || typeStartingDate.isEmpty()) {
            error(getString("typeStartDate.Required"));
            verify = false;
        } else {
            if (typeStartingDate.equals("dateknow")) {
                if (medicineCase.getStartingDateIllness() == null) {
                    error(getString("startingDateIllness.Required"));
                    verify = false;
                }
            }
        }
        Illness i = medicineCase.getIllness();
        if (i == null || i.getCode() == null) {
            error(getString("illnessSelected.Required"));
            verify = false;
        }
        Patient p = medicineCase.getPatient();
        if (p == null || p.getId() == null) {
            error(getString("patientSelected.Required"));
            verify = false;
        }
        if (medicineCase.getDiagnosisDateIllness() == null) {
            error(getString("diagnosisDateIllness.Required"));
            verify = false;
        }
        String foreigner = medicineCase.getForeigner();
        if (foreigner.equals(getString("foreign1"))) {
            if (medicineCase.getHospitalOrganization() == null
                    || medicineCase.getHospitalOrganization().getId() == null) {
                error(getString("hospitalOrganization.Required"));
                verify = false;
            }
            if (medicineCase.getHospitalWard() == null
                    || medicineCase.getHospitalWard().getId() == null) {
                error(getString("hospitalWard.Required"));
                verify = false;
            }
        } else {
            if (medicineCase.getNation() == null
                    || medicineCase.getNation().getId() == null) {
                error(getString("nation.Required"));
                verify = false;
            }
            if (medicineCase.getHospitalForeigner() == null
                    || medicineCase.getHospitalForeigner().isEmpty()) {
                error(getString("hospitalForeigner.Required"));
                verify = false;
            }
        }

        return verify;
    }

    private void createForm(final PageParameters parameters) {
        newCase = !parameters.containsKey("medicineCase");
        examToDelete = new ArrayList<Exam>();
        filesToDelete = new ArrayList<FileCase>();
        if (newCase) {
            medicineCase = new MedicineCase();
            medicineCase.setExams(new ArrayList<Exam>());
            add(new Label("new_case", getString("new_case.new")));
        } else {
            medicineCase = MedicineCase.createNewInstanceMC((MedicineCase) parameters.get("medicineCase"));
            illnessSelected = medicineCase.getIllness();
            patientSelected = medicineCase.getPatient();
            add(new Label("new_case", getString("new_case.update")));
        }
        add(new FeedbackPanel("feedback"));
        form = new Form("caseForm", new CompoundPropertyModel(medicineCase)) {

            private static final long serialVersionUID = -3061771342119019368L;

            @Override
            protected void onSubmit() {
                if ("save".equals(typeButton)) {
                    if (!verifyForm()) {
                        return;
                    }
                    try {
                        if (newCase) {
                            medicineCase.setOwner(getRemaraUser().getUsername());
                            caseManagement.insert(medicineCase);
                        } else {
                            caseManagement.update(medicineCase);
                            for (Exam e : examToDelete) {
                                caseManagement.deleteExam(e);
                            }
                            for (FileCase e : filesToDelete) {
                                caseManagement.deleteFile(e);
                            }
                        }
                    } catch (DBException e) {
                        error(getString(e.getMessage()));
                        return;
                    }
                    info(getString("info.save"));
                    newCase = false;
                    form.get("illnessSelected").setEnabled(false);
                    form.get("patientFind").setEnabled(false);
                    form.get("illnessFind").setEnabled(false);
                    form.get(CONFIRM).setEnabled(true);
                    return;
                }

                if (CONFIRM.equals(typeButton)) {
                    try {
                        caseManagement.confirm(medicineCase, getRemaraUser().getUsername(), getRemaraUser().getRole());
                    } catch (DBException e) {
                        error(getString(e.getMessage()));
                        return;
                    }
                    info(getString("info.confirm"));
                    newCase = false;
                    form.setEnabled(false);
                }
            }
        };
        add(form);
        form.setEnabled(false);
        form.setOutputMarkupId(true);
        form.setMultiPart(true);
        form.setMarkupId("CreateCase");

        form.add(new HiddenField("tabId", new Model("0")));
    }

    private void createPopupPatient() {
        final IModel modelLPatientValue = new AbstractReadOnlyModel() {

            private static final long serialVersionUID = 8437177641834716783L;

            @Override
            public String getObject() {
                if (patientSelected == null || patientSelected.getId() == null) {
                    return "";
                }
                Patient patient = patientManagement.getById(patientSelected.getId());
                if (patient != null) {
                    medicineCase.setPatient(patient);
                    return patient.getTaxCode();
                }
                return "";
            }
        };
        final Label patientValue = new Label("patientValue", modelLPatientValue);
        patientValue.setOutputMarkupId(true);
        form.add(patientValue);

        final IModel modelLPatient = new Model() {

            private static final long serialVersionUID = 5613751443157556844L;

            @Override
            public String getObject() {
                if (patientSelected != null) {
                    return patientSelected.getTaxCode() == null ? "" : patientSelected.getTaxCode();
                } else {
                    return "";
                }
            }

            @Override
            public void setObject(final Serializable object) {
                super.setObject(object);
                patientSelected = null;
                medicineCase.setPatient(patientSelected);
                if (object != null) {
                    List<Patient> list = patientManagement.findByCF(object.toString());
                    if (!list.isEmpty()) {
                        patientSelected = patientManagement.findByCF(object.toString()).get(0);
                        medicineCase.setPatient(patientSelected);
                    }
                }
            }
        };
        final AutoCompleteTextField patient = new AutoCompleteTextField("patientSelected", modelLPatient) {

            private static final long serialVersionUID = -6981275426025821626L;

            @Override
            protected Iterator getChoices(final String input) {
                return patientManagement.getListForAutoComplete(input).iterator();
            }

            @Override
            protected void onComponentTag(final ComponentTag tag) {
                super.onComponentTag(tag);
                tag.remove("autocomplete");
            }
        };
        patient.setEnabled(true);
        patient.setOutputMarkupId(true);
        patient.add(new SimpleAttributeModifier("title", getString("patient")));
        patient.add(new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

            private static final long serialVersionUID = -1107858522700306810L;

            @Override
            protected void onUpdate(final AjaxRequestTarget target) {
                target.addComponent(form.get("patientValue"));
            }
        });

        form.add(patient);

        final ModalWindow patientPopup = new ModalWindow("patientPopup");
        form.add(patientPopup);

        patientPopup.setPageMapName(getString("titlePatientPopup"));
        patientPopup.setCookieName("patientModal");
        patientPopup.setPageCreator(new ModalWindow.PageCreator() {

            private static final long serialVersionUID = -7834632442532690940L;

            public Page createPage() {
                final ModalWindow patientPopup = (ModalWindow) form.get("patientPopup");
                return new PatientPopup(new PageParameters(), SavedCase.this, patientPopup);
            }
        });

        patientPopup.setWindowClosedCallback(
                new ModalWindow.WindowClosedCallback() {

            private static final long serialVersionUID = 8804221891699487139L;

            public void onClose(final AjaxRequestTarget target) {
                target.addComponent(form.get("patientSelected"));
                target.addComponent(form.get("patientValue"));
            }
        });

        final AjaxLink patientFind = new AjaxLink("patientFind") {

            private static final long serialVersionUID = -7978723352517770644L;

            public void onClick(final AjaxRequestTarget target) {
                final ModalWindow patientPopup = (ModalWindow) form.get("patientPopup");
                patientPopup.show(target);
            }
        };
        patientFind.setEnabled(true);
        form.add(patientFind);
    }

    private void createPopupIllness() {
        IModel modelLIllnessValue = new AbstractReadOnlyModel() {

            private static final long serialVersionUID = 8437177641834716783L;

            @Override
            public String getObject() {
                if (illnessSelected == null) {
                    return "";
                }
                Illness illness = illnessManagement.getByCode(
                        illnessSelected.getCode());
                if (illness != null) {
                    medicineCase.setIllness(illness);
                    return illness.getExempt();
                }
                return "";
            }
        };
        final Label illnessValue = new Label("illnessValue", modelLIllnessValue);
        illnessValue.setOutputMarkupId(true);
        form.add(illnessValue);

        final IModel modelLIllness = new Model() {

            private static final long serialVersionUID = 5613751443157556844L;

            @Override
            public String getObject() {
                if (illnessSelected != null) {
                    return illnessSelected.getDescription();
                }
                return "";
            }

            @Override
            public void setObject(final Serializable object) {
                super.setObject(object);
                illnessSelected = null;
                medicineCase.setIllness(illnessSelected);
                if (object == null) {
                    return;
                }
                illnessSelected = illnessManagement.getByDescription(
                        object.toString());
                medicineCase.setIllness(illnessSelected);
            }
        };
        final AutoCompleteTextField illness = new AutoCompleteTextField("illnessSelected", modelLIllness) {

            private static final long serialVersionUID = -6981275426025821626L;

            @Override
            protected Iterator getChoices(final String input) {
                return illnessManagement.getListForAutoComplete(
                        input).iterator();
            }

            @Override
            protected void onComponentTag(final ComponentTag tag) {
                super.onComponentTag(tag);
                tag.remove("autocomplete");
            }
        };
        illness.setEnabled(true);
        illness.setOutputMarkupId(true);
        illness.add(new SimpleAttributeModifier("title", getString("illness")));
        illness.add(new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

            private static final long serialVersionUID = -1107858522700306810L;

            @Override
            protected void onUpdate(final AjaxRequestTarget target) {
                target.addComponent(form.get("illnessValue"));
            }
        });

        form.add(illness);

        final ModalWindow illnessPopup = new ModalWindow("illnessPopup");
        form.add(illnessPopup);

        illnessPopup.setPageMapName(getString("titleIllnessPopup"));
        illnessPopup.setCookieName("illnessModal");
        illnessPopup.setPageCreator(new ModalWindow.PageCreator() {

            private static final long serialVersionUID = -7834632442532690940L;

            public Page createPage() {
                final ModalWindow illnessPopup = (ModalWindow) form.get("illnessPopup");
                return new IllnessPopup(
                        new PageParameters(), SavedCase.this, illnessPopup);
            }
        });

        illnessPopup.setWindowClosedCallback(
                new ModalWindow.WindowClosedCallback() {

            private static final long serialVersionUID = 8804221891699487139L;

            public void onClose(final AjaxRequestTarget target) {
                target.addComponent(form.get("illnessSelected"));
                target.addComponent(form.get("illnessValue"));
            }
        });

        final AjaxLink illnessFind = new AjaxLink("illnessFind") {

            private static final long serialVersionUID = -7978723352517770644L;

            public void onClick(final AjaxRequestTarget target) {
                final ModalWindow illnessPopup = (ModalWindow) form.get("illnessPopup");
                illnessPopup.show(target);
            }
        };
        illnessFind.setEnabled(true);
        form.add(illnessFind);
    }

    private void createIllness() {
        final Model<String> exactlyIllnessModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                String exactlyIllness = medicineCase.getExactlyIllness();
                if (exactlyIllness == null) {
                    return null;
                }
                return exactlyIllness;
            }

            @Override
            public void setObject(Serializable object) {
                medicineCase.setExactlyIllness((String) object);
            }
        };
        exactlyIllness = new TextField("exactlyIllness", exactlyIllnessModel);
        exactlyIllness.setOutputMarkupId(true);
        exactlyIllness.add(new SimpleAttributeModifier("title", getString("exactlyIllness")));
        form.add(exactlyIllness);

        final Model<Date> diagnosisDateIllnessModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                Date typeStartingDate = medicineCase.getDiagnosisDateIllness();
                if (typeStartingDate == null) {
                    return null;
                }
                return typeStartingDate;
            }

            @Override
            public void setObject(Serializable object) {
                medicineCase.setDiagnosisDateIllness((Date) object);
            }
        };
        final DateTextField diagnosisDateIllness = DateTextField.forDatePattern("diagnosisDateIllness",
                diagnosisDateIllnessModel, getString("format_date"));
        diagnosisDateIllness.add(new SimpleAttributeModifier("title", getString("diagnosisDateIllness")));
        diagnosisDateIllness.add(new DatePicker() {

            private static final long serialVersionUID = 4166072895162221956L;

            @Override
            protected boolean enableMonthYearSelection() {
                return true;
            }
        });
        form.add(diagnosisDateIllness);

        final IModel modelLTypeStartDate = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                String typeStartingDate = medicineCase.getTypeStartingDate();
                if (typeStartingDate == null || typeStartingDate.isEmpty()) {
                    return null;
                }
                return getString(typeStartingDate);
            }

            @Override
            public void setObject(final Serializable object) {
                super.setObject(object);
                medicineCase.setTypeStartingDate(null);
                if (object == null) {
                    return;
                }
                String typeStartingDate = object.toString();
                if (typeStartingDate.equals(getString("dateknow"))) {
                    medicineCase.setTypeStartingDate("dateknow");
                }
                if (typeStartingDate.equals(getString("dateNotknow"))) {
                    medicineCase.setTypeStartingDate("dateNotknow");
                }
                if (typeStartingDate.equals(getString("dateNotManifest"))) {
                    medicineCase.setTypeStartingDate("dateNotManifest");
                }
            }
        };

        final List typeStartingDates = Arrays.asList(new String[] {
            getString("dateknow"),
            getString("dateNotknow"),
            getString("dateNotManifest")
        });
        final RadioChoice typeStartingDate = new RadioChoice("typeStartDate", modelLTypeStartDate, typeStartingDates);
        typeStartingDate.setOutputMarkupId(true);
        form.add(typeStartingDate);

        final Model<Date> startingDateIllnessModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                Date typeStartingDate = medicineCase.getStartingDateIllness();
                if (typeStartingDate == null) {
                    return null;
                }
                return typeStartingDate;
            }

            @Override
            public void setObject(final Serializable object) {
                medicineCase.setStartingDateIllness((Date) object);
            }
        };
        final DateTextField startingDateIllness = DateTextField.forDatePattern("startingDateIllness",
                startingDateIllnessModel, getString("format_date"));
        startingDateIllness.add(new SimpleAttributeModifier("title", getString("startingDateIllness")));
        startingDateIllness.add(new DatePicker() {

            private static final long serialVersionUID = 4166072895162221956L;

            @Override
            protected boolean enableMonthYearSelection() {
                return true;
            }
        });
        form.add(startingDateIllness);

        final Model<Boolean> orphanMedicineModel = new Model<Boolean>() {

            private static final long serialVersionUID = -7029353267336822618L;

            @Override
            public Boolean getObject() {
                return medicineCase.getOrphanMedicine();
            }

            @Override
            public void setObject(Boolean object) {
                super.setObject(object);
                medicineCase.setOrphanMedicine(object);
            }
        };
        final CheckBox orphanMedicine = new CheckBox("orphanMedicine", orphanMedicineModel);
        orphanMedicine.add(new SimpleAttributeModifier("title", getString("orphanMedicine")));
        orphanMedicine.setOutputMarkupId(true);
        form.add(orphanMedicine);

        categoryCMedicineModel = new Model<Boolean>() {

            private static final long serialVersionUID = -7157802546272668001L;

            @Override
            public Boolean getObject() {
                return medicineCase.getCategoryCMedicine();
            }

            @Override
            public void setObject(Boolean object) {
                super.setObject(object);
                medicineCase.setCategoryCMedicine(object);
            }
        };
        categoryCMedicine = new CheckBox("categoryCMedicine", categoryCMedicineModel);
        categoryCMedicine.add(new SimpleAttributeModifier("title", getString("categoryCMedicine")));
        categoryCMedicine.setOutputMarkupId(true);
        form.add(categoryCMedicine);

        final Model<String> categoryCMedicineDescriptionModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                String categoryCMedicineDescription = medicineCase.getCategoryCMedicineDescription();
                if (categoryCMedicineDescription == null) {
                    return null;
                }
                return categoryCMedicineDescription;
            }

            @Override
            public void setObject(Serializable object) {
                if (object == null) {
                    medicineCase.setCategoryCMedicineDescription("");
                } else {
                    medicineCase.setCategoryCMedicineDescription((String) object);
                }
            }
        };

        final TextField categoryCMedicineDescription = new TextField("categoryCMedicineDescription",
                categoryCMedicineDescriptionModel);
        categoryCMedicineDescription.add(new SimpleAttributeModifier("title", getString(
                "categoryCMedicineDescription")));
        form.add(categoryCMedicineDescription);

        final Model<String> medicineDescriptionModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                String medicineDescription = medicineCase.getMedicineDescription();
                if (medicineDescription == null) {
                    return null;
                }
                return medicineDescription;
            }

            @Override
            public void setObject(Serializable object) {
                if (object == null) {
                    medicineCase.setMedicineDescription("");
                } else {
                    medicineCase.setMedicineDescription((String) object);
                }
            }
        };


        final TextField medicineDescription = new TextField("medicineDescription", medicineDescriptionModel);
        medicineDescription.add(new SimpleAttributeModifier("title", getString("medicineDescription")));
        form.add(medicineDescription);

        final ChoiceRenderer rendererHosOrg = new ChoiceRenderer("name", "id");
        final IModel modelHosWard = new AbstractReadOnlyModel() {

            private static final long serialVersionUID = -2583290457773357445L;

            @Override
            public List<HospitalWard> getObject() {
                List<HospitalWard> list = hospitalManagement.getHospitalWard(
                        medicineCase.getHospitalOrganization());
                return list;
            }
        };
        final DropDownChoice hospitalWard = new DropDownChoice("hospitalWard", modelHosWard, rendererHosOrg);
        hospitalWard.setOutputMarkupId(true);
        hospitalWard.add(new SimpleAttributeModifier("title", getString("hospitalWard")));

        f1 = new Fragment("fragmentContainer", "fragment1", form);
        f1.setOutputMarkupId(true);

        final IModel modelHosOrg = new AbstractReadOnlyModel() {

            private static final long serialVersionUID = -2583290457773357445L;

            @Override
            public List<HospitalOrganization> getObject() {
                final Region r = (Region) f1.get(REGION).getDefaultModelObject();
                List<HospitalOrganization> hospitalOrganizations = hospitalManagement.findByRegion(r);
                return hospitalOrganizations;
            }
        };

        final DropDownChoice hospitalOrganization = new DropDownChoice("hospitalOrganization", modelHosOrg,
                rendererHosOrg);
        hospitalOrganization.setOutputMarkupId(true);
        hospitalOrganization.add(new SimpleAttributeModifier("title", getString("hospitalOrganization")));
        hospitalOrganization.add(new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

            private static final long serialVersionUID = -1107858522700306810L;

            @Override
            protected void onUpdate(final AjaxRequestTarget target) {
                target.addComponent(f1.get("hospitalWard"));
            }
        });

        f2 = new Fragment("fragmentContainer", "fragment2", form);
        f2.setOutputMarkupId(true);

        ChoiceRenderer renderer = new ChoiceRenderer("description", "id");
        List<Region> regions = hospitalManagement.getRegions();
        Region r = null;
        if (medicineCase.getHospitalOrganization() != null) {
            r = medicineCase.getHospitalOrganization().getRegion();
        }
        final DropDownChoice region = new DropDownChoice(REGION, new Model(r), regions, renderer);
        region.setOutputMarkupId(true);

        final ChoiceRenderer rendererIt = new ChoiceRenderer("descriptionIt", "id");
        final DropDownChoice birthNation = new DropDownChoice("nation", caseManagement.getNations(), rendererIt);
        birthNation.add(new SimpleAttributeModifier("title", getString("nation")));
        f2.add(birthNation);

        final TextField hospitalForeigner = new TextField("hospitalForeigner");
        hospitalForeigner.add(new SimpleAttributeModifier("title", getString("hospitalForeigner")));
        f2.add(hospitalForeigner);

        final List nations = Arrays.asList(new String[] {getString("foreign1"), getString("foreign2")});

        final RadioChoice<String> rc = new RadioChoice("foreigner", nations);

        rc.setRequired(true);

        rc.add(new AjaxFormChoiceComponentUpdatingBehavior() {

            private static final long serialVersionUID = -151291731388673682L;

            @Override
            protected void onUpdate(final AjaxRequestTarget target) {

                form.modelChanged();

                exactlyIllnessModel.setObject(exactlyIllness.getInput());
                try {
                    diagnosisDateIllnessModel.setObject(
                            new SimpleDateFormat(getString("format_date")).parse(diagnosisDateIllness.getInput()));
                    startingDateIllnessModel.setObject(
                            new SimpleDateFormat(getString("format_date")).parse(startingDateIllness.getInput()));
                } catch (ParseException ex) {
                    LOG.error("Parsing error date {}", startingDateIllness.getInput(), ex);
                }
                medicineDescriptionModel.setObject(medicineDescription.getInput());
                if (typeStartingDate.getInput() != null) {
                    {
                        if (Integer.parseInt(typeStartingDate.getInput()) == 0) {
                            modelLTypeStartDate.setObject(getString("dateknow"));
                        } else if (Integer.parseInt(typeStartingDate.getInput()) == 1) {
                            modelLTypeStartDate.setObject(getString("dateNotknow"));
                        } else {
                            modelLTypeStartDate.setObject(getString("dateNotManifest"));
                        }
                    }
                }
                if (ON.equalsIgnoreCase(orphanMedicine.getInput())) {
                    orphanMedicineModel.setObject(true);
                } else {
                    orphanMedicineModel.setObject(false);
                }
                if (ON.equalsIgnoreCase(categoryCMedicine.getInput())) {
                    categoryCMedicineModel.setObject(true);
                } else {
                    categoryCMedicineModel.setObject(false);
                }
                categoryCMedicineDescriptionModel.setObject(categoryCMedicineDescription.getInput());
                if (getString("foreign1").equalsIgnoreCase(rc.getDefaultModelObjectAsString())) {
                    form.addOrReplace(f1);
                    if (!newCase && medicineCase.getNation() != null) {
                        medicineCase.setNation(null);
                        medicineCase.setHospitalForeigner(null);
                    }
                } else {
                    form.addOrReplace(f2);
                }
                target.addComponent(form);
            }
        });
        f1.add(hospitalOrganization);
        f1.add(hospitalWard);
        f1.add(region);

        form.add(rc);

        region.add(new SimpleAttributeModifier("title", getString("regionHospital")));
        region.add(new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

            private static final long serialVersionUID = -1107858522700306810L;

            @Override
            protected void onUpdate(AjaxRequestTarget target) {
                target.addComponent(f1.get("hospitalOrganization"));
                target.addComponent(f1.get("hospitalWard"));
            }
        });

        if (newCase || medicineCase.getNation() == null) {
            form.add(f1);
        } else if (getString("foreign1").equalsIgnoreCase(medicineCase.getForeigner())) {
            form.add(f1);
        } else {
            form.add(f2);
        }
    }

    private void createFindHospital() {
        ModalWindow hoPopup = new ModalWindow("hoPopup");
        form.add(hoPopup);

        hoPopup.setPageMapName(getString("titleHoPopup"));
        hoPopup.setCookieName("hoModal");
        hoPopup.setPageCreator(new ModalWindow.PageCreator() {

            private static final long serialVersionUID = -7834632442532690940L;

            public Page createPage() {
                ModalWindow hoPopup = (ModalWindow) form.get("hoPopup");
                PageParameters pageParameters = new PageParameters();
                pageParameters.put(REGION, f1.get(REGION).getDefaultModelObject());
                return new HoPopup(pageParameters, hoPopup, SavedCase.this);
            }
        });

        hoPopup.setWindowClosedCallback(new ModalWindow.WindowClosedCallback() {

            private static final long serialVersionUID = 8804221891699487139L;

            public void onClose(AjaxRequestTarget target) {
                target.addComponent(f1.get("hospitalOrganization"));
            }
        });

        AjaxLink hospitalHoAdd = new AjaxLink("hospitalHoAdd") {

            private static final long serialVersionUID = -7978723352517770644L;

            public void onClick(AjaxRequestTarget target) {
                ModalWindow hoPopup = (ModalWindow) form.get("hoPopup");
                hoPopup.show(target);
            }
        };
        hospitalHoAdd.setEnabled(newCase);
        f1.add(hospitalHoAdd);
    }

    private void createPopupWard() {
        ModalWindow wardPopup = new ModalWindow("wardPopup");
        form.add(wardPopup);

        wardPopup.setPageMapName(getString("titleWardPopup"));
        wardPopup.setCookieName("wardModal");
        wardPopup.setPageCreator(new ModalWindow.PageCreator() {

            private static final long serialVersionUID = -7834632442532690940L;

            public Page createPage() {
                ModalWindow wardPopup = (ModalWindow) form.get("wardPopup");
                PageParameters pageParameters = new PageParameters();
                pageParameters.put(REGION, f1.get(REGION).getDefaultModelObject());
                pageParameters.put("hospital", f1.get("hospitalOrganization").getDefaultModelObject());
                return new WardPopup(pageParameters, wardPopup, SavedCase.this);
            }
        });

        wardPopup.setWindowClosedCallback(new ModalWindow.WindowClosedCallback() {

            private static final long serialVersionUID = 8804221891699487139L;

            public void onClose(AjaxRequestTarget target) {
                target.addComponent(f1.get("hospitalWard"));
            }
        });

        AjaxLink hospitalWardAdd = new AjaxLink("hospitalWardAdd") {

            private static final long serialVersionUID = -7978723352517770644L;

            public void onClick(AjaxRequestTarget target) {
                ModalWindow wardPopup = (ModalWindow) form.get("wardPopup");
                wardPopup.show(target);
            }
        };
        hospitalWardAdd.setEnabled(newCase);
        f1.add(hospitalWardAdd);
    }

    private void createExams() {
        ModalWindow examPopup = new ModalWindow("examPopup");
        form.add(examPopup);

        examPopup.setPageMapName(getString("titleExamPopup"));
        examPopup.setCookieName("examModal");
        examPopup.setTitle(getString("titleExamPopup"));
        examPopup.setCloseButtonCallback(new ModalWindow.CloseButtonCallback() {

            private static final long serialVersionUID = -6245977337732467667L;

            public boolean onCloseButtonClicked(AjaxRequestTarget target) {
                if (editedExam != null) {
                    if (editedExam.getFileCases() != null) {
                        for (FileCase file : tempDeletedFiles) {
                            editedExam.getFileCases().add(file);
                        }
                    }
                    medicineCase.getExams().add(editedExam);
                    editedExam = null;
                }
                return true;
            }
        });
        examPopup.setWindowClosedCallback(new ModalWindow.WindowClosedCallback() {

            private static final long serialVersionUID = 8804221891699487139L;

            public void onClose(AjaxRequestTarget target) {
                target.addComponent(form.get("container"));
            }
        });

        WebMarkupContainer container = new WebMarkupContainer("container");
        listView = new ListView("examList", medicineCase.getExams()) {

            private static final long serialVersionUID = 4949588177564901031L;

            @Override
            protected void populateItem(ListItem item) {
                final Exam exam = (Exam) item.getModelObject();
                item.add(new Label("description", exam.getDescription()).setEscapeModelStrings(false));
                item.add(new Label("typeExam", exam.getTypeExam()));

                AjaxLink delete = new AjaxLink("delete") {

                    private static final long serialVersionUID = -7978723352517770644L;

                    @Override
                    public void onClick(AjaxRequestTarget target) {
                        examToDelete.add(exam);
                        medicineCase.getExams().remove(exam);
                        listView.setList(medicineCase.getExams());
                        target.addComponent(form.get("container"));
                    }
                };
                delete.add(new SimpleAttributeModifier("title", getString("delete")));
                item.add(delete);

                AjaxLink update = new AjaxLink("update") {

                    private static final long serialVersionUID = -7978723352517770644L;

                    @Override
                    public void onClick(AjaxRequestTarget target) {
                        ModalWindow examPopup = (ModalWindow) form.get("examPopup");
                        examPopup.setPageCreator(new ModalWindow.PageCreator() {

                            private static final long serialVersionUID = -7834632442532690940L;

                            public Page createPage() {
                                ModalWindow examPopup = (ModalWindow) form.get("examPopup");
                                PageParameters parameters = new PageParameters();
                                Exam ne;
                                if (!newCase && exam.getFileCases() == null) {
                                    ne = Exam.createNewInstanceExam(exam);
                                    ne.setFileCases(new ArrayList<FileCase>());
                                    ne.getFileCases().addAll(caseManagement.getFiles(exam.getId()));
                                } else {
                                    ne = exam;
                                }
                                parameters.put("exam", ne);
                                tempDeletedFiles = new ArrayList<FileCase>();
                                editedExam = exam;
                                medicineCase.getExams().remove(exam);
                                return new ExamPopup(parameters, SavedCase.this, examPopup);
                            }
                        });
                        examPopup.show(target);
                    }
                };
                update.add(
                        new SimpleAttributeModifier("title", getString("update")));
                item.add(update);
            }
        };
        container.add(listView);

        AjaxLink addExam = new AjaxLink("addExam") {

            private static final long serialVersionUID = -7978723352517770644L;

            public void onClick(AjaxRequestTarget target) {
                ModalWindow examPopup = (ModalWindow) form.get("examPopup");
                examPopup.setPageCreator(new ModalWindow.PageCreator() {

                    private static final long serialVersionUID = -7834632442532690940L;

                    public Page createPage() {
                        ModalWindow examPopup = (ModalWindow) form.get("examPopup");
                        PageParameters parameters = new PageParameters();
                        Exam ne = new Exam();
                        ne.setFileCases(new ArrayList<FileCase>());
                        parameters.put("exam", ne);
                        return new ExamPopup(parameters, SavedCase.this, examPopup);
                    }
                });
                examPopup.show(target);
            }
        };

        addExam.add(
                new SimpleAttributeModifier("title", getString("addExam")));
        container.add(addExam);

        container.setOutputMarkupId(
                true);
        form.add(container);
    }

    public void setResult(Illness illness) {
        illnessSelected = illness;
    }

    public void setResultPatient(Patient patient) {
        patientSelected = patient;
    }

    public void setHospitalWard(HospitalWard hospitalWard) {
        medicineCase.setHospitalWard(hospitalWard);
    }

    public void setHo(final HospitalOrganization ho) {
        medicineCase.setHospitalOrganization(ho);
    }

    public MedicineCase getMC() {
        return medicineCase;
    }

    public List<FileCase> getFilesToDelete() {
        return filesToDelete;
    }

    public List<FileCase> getTempDeletedFiles() {
        return tempDeletedFiles;
    }
}
