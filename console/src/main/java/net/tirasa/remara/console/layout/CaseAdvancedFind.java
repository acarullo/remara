package net.tirasa.remara.console.layout;

import net.tirasa.remara.console.utilities.Constants;
import net.tirasa.remara.console.pages.IllnessPopup;
import net.tirasa.remara.console.pages.ListCases;
import net.tirasa.remara.console.pages.FindPopupIllness;
import net.tirasa.remara.console.pages.ListPatients;
import net.tirasa.remara.core.management.CaseManagement;
import net.tirasa.remara.core.management.HospitalManagement;
import net.tirasa.remara.core.management.IllnessManagement;
import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import net.tirasa.remara.persistence.data.Education;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import net.tirasa.remara.persistence.data.HospitalWard;
import net.tirasa.remara.persistence.data.Illness;
import net.tirasa.remara.persistence.data.MedicineCase;
import net.tirasa.remara.persistence.data.Municipality;
import net.tirasa.remara.persistence.data.Occupation;
import net.tirasa.remara.persistence.data.Patient;
import net.tirasa.remara.persistence.data.Province;
import net.tirasa.remara.persistence.data.Region;
import org.apache.wicket.Page;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.form.AjaxFormComponentUpdatingBehavior;
import org.apache.wicket.ajax.markup.html.AjaxLink;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.extensions.ajax.markup.html.autocomplete.AutoCompleteTextField;
import org.apache.wicket.extensions.ajax.markup.html.modal.ModalWindow;
import org.apache.wicket.extensions.yui.calendar.DatePicker;
import org.apache.wicket.markup.ComponentTag;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.Button;
import org.apache.wicket.markup.html.form.CheckBox;
import org.apache.wicket.markup.html.form.ChoiceRenderer;
import org.apache.wicket.markup.html.form.DropDownChoice;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.RadioChoice;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.model.AbstractReadOnlyModel;
import org.apache.wicket.model.CompoundPropertyModel;
import org.apache.wicket.model.IModel;
import org.apache.wicket.model.Model;
import org.apache.wicket.model.PropertyModel;
import org.apache.wicket.spring.injection.annot.SpringBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CaseAdvancedFind extends AbstractPanel implements FindPopupIllness {

    private static final long serialVersionUID = 6904532859741076840L;

    private static final Logger LOG = LoggerFactory.getLogger(CaseAdvancedFind.class);

    @SpringBean
    private HospitalManagement hospitalManagement;

    @SpringBean
    private CaseManagement caseManagement;

    @SpringBean
    private IllnessManagement illnessManagement;

    private final Form form;

    private MedicineCase medicineCase = null;

    private Illness illnessSelected;

    private String illnessText;

    private Class fromClass;

    private Integer selectedStartYear;

    private Integer selectedEndYear;

    private Integer selectedStartYearMC;

    private Integer selectedEndYearMC;

    private final List<Integer> yearList;

    final SimpleDateFormat dateFormat = new SimpleDateFormat(getString("format_date"));

    private void createPatientName() {
        TextField name = new TextField("patient.name");
        name.add(new SimpleAttributeModifier("title", getString("patient.name")));
        form.add(name);

        TextField surname = new TextField("patient.surname");
        surname.add(new SimpleAttributeModifier("title", getString("surname")));
        form.add(surname);

        TextField taxCode = new TextField("patient.taxCode");
        taxCode.add(new SimpleAttributeModifier("title", getString("taxCode")));
        form.add(taxCode);

        form.
                add(new RadioChoice("patient.sex", Arrays.asList(
                                        new String[]{"M", "F", getString("tutti")})));

        DropDownChoice<Integer> startYear
                = new DropDownChoice<Integer>("startYear", new PropertyModel<Integer>(this, "selectedStartYear"),
                        yearList);
        startYear.add(new SimpleAttributeModifier("title", getString("startYear")));
        startYear.setOutputMarkupId(true);

        DropDownChoice<Integer> endYear
                = new DropDownChoice<Integer>("endYear", new PropertyModel<Integer>(this, "selectedEndYear"),
                        yearList);
        endYear.add(new SimpleAttributeModifier("title", getString("endYear")));
        endYear.setOutputMarkupId(true);

        form.add(startYear);
        form.add(endYear);

        final IModel birthDateModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                Date birthDate = medicineCase.getPatient().getBirthDate();
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

                        LOG.info("Searching for patient birth date to {}", data);

                        medicineCase.getPatient().setBirthDate(data);
                    } else {
                        try {
                            LOG.info("Searching for patient birth date to {}", object.toString());
                            medicineCase.getPatient().setBirthDate(dateFormat.parse(object.toString()));
                        } catch (ParseException ex) {
                            LOG.error("Error parsing patient birth date {}", ex.getMessage(), ex);
                        }
                    }

                } else {
                    medicineCase.getPatient().setBirthDate(null);
                }
            }
        };

        final TextField<Date> birthDate = new TextField<Date>("patient.birthDate", birthDateModel);

        birthDate.add(new SimpleAttributeModifier("title", getString("birthDate")));

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

        form.add(birthDate);


        final IModel deathDateModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                Date deathDate = medicineCase.getPatient().getDeathDate();
                if (deathDate == null) {
                    return null;
                }
                return dateFormat.format(deathDate);
            }

            @Override
            public void setObject(final Serializable object) {
                if (object != null) {

                    if (object instanceof Date) {

                        final Date data = (Date) object;

                        LOG.info("Searching for patient death date to {}", data);

                        medicineCase.getPatient().setDeathDate(data);
                    } else {
                        try {
                            LOG.info("Searching for patient death date to {}", object.toString());
                            medicineCase.getPatient().setDeathDate(dateFormat.parse(object.toString()));
                        } catch (ParseException ex) {
                            LOG.error("Error parsing patient death date {}", ex.getMessage(), ex);
                        }
                    }

                } else {
                    medicineCase.getPatient().setDeathDate(null);
                }
            }
        };

        final TextField<Date> deathDate = new TextField<Date>("patient.deathDate", deathDateModel);

        birthDate.add(new SimpleAttributeModifier("title", getString("deathDate")));

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

        deathDate.add(deathDatePicker);

        form.add(deathDate);
    }

    private void createPatientAdressLiving(List<Region> regions) {
        ChoiceRenderer renderer = new ChoiceRenderer("description", "id");
        IModel modelLMunicipality = new AbstractReadOnlyModel() {

            private static final long serialVersionUID = -2583290457773357445L;

            @Override
            public List<Municipality> getObject() {
                return caseManagement.getMunicipality(medicineCase.getPatient().getLivingProvince());
            }
        };
        DropDownChoice livingMunicipality = new DropDownChoice("patient.livingMunicipality", modelLMunicipality,
                renderer);
        livingMunicipality.setOutputMarkupId(true);
        livingMunicipality.add(new SimpleAttributeModifier("title", getString("livingMunicipality")));
        form.add(livingMunicipality);

        IModel modelLProvince = new AbstractReadOnlyModel() {

            private static final long serialVersionUID = -2583290457773357445L;

            @Override
            public List<Province> getObject() {
                return caseManagement.getProvince(medicineCase.getPatient().getLivingRegion());
            }
        };
        DropDownChoice livingProvince = new DropDownChoice("patient.livingProvince", modelLProvince, renderer);
        livingProvince.setOutputMarkupId(true);
        livingProvince.add(new SimpleAttributeModifier("title", getString("livingProvince")));
        livingProvince.add(new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

            private static final long serialVersionUID = -1107858522700306810L;

            @Override
            protected void onUpdate(AjaxRequestTarget target) {
                target.addComponent(form.get("patient.livingMunicipality"));
            }
        });
        form.add(livingProvince);

        DropDownChoice livingRegion = new DropDownChoice("patient.livingRegion", regions, renderer);
        livingRegion.setOutputMarkupId(true);
        livingRegion.add(new SimpleAttributeModifier("title", getString("livingRegion")));
        livingRegion.add(new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

            private static final long serialVersionUID = -1107858522700306810L;

            @Override
            protected void onUpdate(AjaxRequestTarget target) {
                target.addComponent(form.get("patient.livingProvince"));
                target.addComponent(form.get("patient.livingMunicipality"));
            }
        });
        form.add(livingRegion);

        TextField livingCap = new TextField("patient.livingCap");
        livingCap.add(new SimpleAttributeModifier("title", getString("livingCap")));
        form.add(livingCap);
    }

    private void createPatientAdressBirth(List<Region> regions) {
        List nations = Arrays.asList(new String[]{
            getString("foreign1"),
            getString("foreign2"),
            getString("tutti")});
        form.add(new RadioChoice("patient.foreigner", nations));

        ChoiceRenderer renderer = new ChoiceRenderer("description", "id");
        IModel modelMunicipality = new AbstractReadOnlyModel() {

            private static final long serialVersionUID = -2583290457773357445L;

            @Override
            public List<Municipality> getObject() {
                return caseManagement.getMunicipality(medicineCase.getPatient().getBirthProvince());
            }
        };
        DropDownChoice birthMunicipality = new DropDownChoice("patient.birthMunicipality", modelMunicipality,
                renderer);
        birthMunicipality.setOutputMarkupId(true);
        birthMunicipality.add(new SimpleAttributeModifier("title", getString("birthMunicipality")));
        form.add(birthMunicipality);

        IModel modelProvince = new AbstractReadOnlyModel() {

            private static final long serialVersionUID = -2583290457773357445L;

            @Override
            public List<Province> getObject() {
                return caseManagement.getProvince(medicineCase.getPatient().getBirthRegion());
            }
        };
        DropDownChoice birthProvince = new DropDownChoice("patient.birthProvince", modelProvince, renderer);
        birthProvince.setOutputMarkupId(true);
        birthProvince.add(new SimpleAttributeModifier("title", getString("birthProvince")));
        birthProvince.add(new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

            private static final long serialVersionUID = -1107858522700306810L;

            @Override
            protected void onUpdate(AjaxRequestTarget target) {
                target.addComponent(form.get("patient.birthMunicipality"));
            }
        });
        form.add(birthProvince);

        DropDownChoice birthRegion = new DropDownChoice("patient.birthRegion", regions, renderer);
        birthRegion.setOutputMarkupId(true);
        birthRegion.add(new SimpleAttributeModifier("title", getString("birthRegion")));
        birthRegion.add(new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

            private static final long serialVersionUID = -1107858522700306810L;

            @Override
            protected void onUpdate(AjaxRequestTarget target) {
                target.addComponent(form.get("patient.birthProvince"));
                target.addComponent(form.get("patient.birthMunicipality"));
            }
        });
        form.add(birthRegion);

        TextField birthCap = new TextField("patient.birthCap");
        birthCap.add(new SimpleAttributeModifier("title", getString("birthCap")));
        form.add(birthCap);

        ChoiceRenderer rendererIt = new ChoiceRenderer("descriptionIt", "id");

        DropDownChoice birthNation = new DropDownChoice("patient.birthNation", caseManagement.getNations(),
                rendererIt);
        birthNation.add(new SimpleAttributeModifier("title", getString("birthNation")));
        form.add(birthNation);
    }

    private void createEduOcc() {
        ChoiceRenderer renderer = new ChoiceRenderer("descriptionIt", "id");

        List<Education> educations = caseManagement.getEducations();
        List<Occupation> occupations = caseManagement.getOccupations();

        DropDownChoice personalEducation = new DropDownChoice("patient.personalEducation", educations, renderer);
        personalEducation.add(new SimpleAttributeModifier("title", getString("personalEducation")));
        form.add(personalEducation);

        DropDownChoice personalOccupation = new DropDownChoice("patient.personalOccupation", occupations, renderer);
        personalOccupation.add(
                new SimpleAttributeModifier("title", getString("personalOccupation")));
        form.add(personalOccupation);

        TextField exactlyOccupation = new TextField("patient.exactlyOccupation");
        exactlyOccupation.add(new SimpleAttributeModifier("title", getString("exactlyOccupation")));
        form.add(exactlyOccupation);

        DropDownChoice motherEducation = new DropDownChoice("patient.motherEducation", educations, renderer);
        motherEducation.add(new SimpleAttributeModifier("title", getString("motherEducation")));
        form.add(motherEducation);

        DropDownChoice fatherEducation = new DropDownChoice("patient.fatherEducation", educations, renderer);
        fatherEducation.add(new SimpleAttributeModifier("title", getString("fatherEducation")));
        form.add(fatherEducation);

        DropDownChoice motherOccupation = new DropDownChoice("patient.motherOccupation", occupations, renderer);
        motherOccupation.add(new SimpleAttributeModifier("title", getString("motherOccupation")));
        form.add(motherOccupation);

        DropDownChoice fatherOccupation = new DropDownChoice("patient.fatherOccupation", occupations, renderer);
        fatherOccupation.add(new SimpleAttributeModifier("title", getString("fatherOccupation")));
        form.add(fatherOccupation);
    }

    private void createPopupIllness() {
        IModel modelLIllnessValue = new AbstractReadOnlyModel() {

            private static final long serialVersionUID = 8437177641834716783L;

            @Override
            public String getObject() {
                if (illnessSelected == null) {
                    return "";
                }
                Illness illness = illnessManagement.getByCode(illnessSelected.getCode());
                if (illness != null) {
                    medicineCase.setIllness(illness);
                    return illness.getExempt();
                }
                return "";
            }
        };
        Label illnessValue = new Label("illnessValue", modelLIllnessValue);
        illnessValue.setOutputMarkupId(true);
        form.add(illnessValue);

        IModel modelLIllness = new Model() {

            private static final long serialVersionUID = 5613751443157556844L;

            @Override
            public String getObject() {
                if (illnessSelected != null) {
                    return illnessSelected.getDescription();
                }
                return "";
            }

            @Override
            public void setObject(Serializable object) {
                super.setObject(object);
                illnessSelected = null;
                medicineCase.setIllness(illnessSelected);
                if (object == null) {
                    return;
                }
                illnessSelected = illnessManagement.getByDescription(object.toString());
                medicineCase.setIllness(illnessSelected);
            }
        };
        AutoCompleteTextField illness = new AutoCompleteTextField("illnessSelected", modelLIllness) {

            private static final long serialVersionUID = -6981275426025821626L;

            @Override
            protected Iterator getChoices(String input) {
                illnessText = input;
                return illnessManagement.getListForAutoComplete(input).iterator();
            }

            @Override
            protected void onComponentTag(ComponentTag tag) {
                super.onComponentTag(tag);
                tag.remove("autocomplete");
            }
        };
        illness.setOutputMarkupId(true);
        illness.add(new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

            private static final long serialVersionUID = -1107858522700306810L;

            @Override
            protected void onUpdate(AjaxRequestTarget target) {
                target.addComponent(form.get("illnessValue"));
            }
        });
        illness.add(new SimpleAttributeModifier("title", getString("illness")));
        form.add(illness);

        ModalWindow illnessPopup = new ModalWindow("illnessPopup");
        form.add(illnessPopup);

        illnessPopup.setPageMapName(getString("titleIllnessPopup"));
        illnessPopup.setCookieName("illnessModal");
        illnessPopup.setPageCreator(new ModalWindow.PageCreator() {

            private static final long serialVersionUID = -7834632442532690940L;

            public Page createPage() {
                ModalWindow illnessPopup = (ModalWindow) form.get("illnessPopup");
                PageParameters p = new PageParameters();
                p.add("findDescription", illnessText);
                return new IllnessPopup(p, CaseAdvancedFind.this, illnessPopup);
            }
        });

        illnessPopup.setWindowClosedCallback(new ModalWindow.WindowClosedCallback() {

            private static final long serialVersionUID = 8804221891699487139L;

            public void onClose(AjaxRequestTarget target) {
                target.addComponent(form.get("illnessSelected"));
                target.addComponent(form.get("illnessValue"));
            }
        });

        AjaxLink illnessFind = new AjaxLink("illnessFind") {

            private static final long serialVersionUID = -7978723352517770644L;

            public void onClick(AjaxRequestTarget target) {
                ModalWindow illnessPopup = (ModalWindow) form.get("illnessPopup");
                illnessPopup.show(target);
            }
        };
        form.add(illnessFind);
    }

    private void createIllness() {

        final IModel diagnosisDateModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                final Date diagnosisDate = medicineCase.getDiagnosisDateIllness();
                if (diagnosisDate == null) {
                    return null;
                }
                return dateFormat.format(diagnosisDate);
            }

            @Override
            public void setObject(final Serializable object) {
                if (object != null) {

                    if (object instanceof Date) {

                        final Date data = (Date) object;

                        LOG.info("Searching for illness diagnosis date to {}", data);

                        medicineCase.setDiagnosisDateIllness(data);
                    } else {
                        try {
                            LOG.info("Searching for illness diagnosis date to {}", object.toString());
                            medicineCase.setDiagnosisDateIllness(dateFormat.parse(object.toString()));
                        } catch (ParseException ex) {
                            LOG.error("Error parsing illness diagnosis date {}", ex.getMessage(), ex);
                        }
                    }

                } else {
                    medicineCase.setDiagnosisDateIllness(null);
                }
            }
        };

        final TextField<Date> diagnosisDateIllness = new TextField<Date>("diagnosisDateIllness", diagnosisDateModel);

        diagnosisDateIllness.add(new SimpleAttributeModifier("title", getString("diagnosisDateIllness")));

        final DatePicker diagnosisDateIllnessPicker = new DatePicker() {

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

        diagnosisDateIllness.add(diagnosisDateIllnessPicker);

        form.add(diagnosisDateIllness);

        final IModel startingDateModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                final Date startingDate = medicineCase.getStartingDateIllness();
                if (startingDate == null) {
                    return null;
                }
                return dateFormat.format(startingDate);
            }

            @Override
            public void setObject(final Serializable object) {
                if (object != null) {

                    if (object instanceof Date) {

                        final Date data = (Date) object;

                        LOG.info("Searching for illness starting date to {}", data);

                        medicineCase.setDiagnosisDateIllness(data);
                    } else {
                        try {
                            LOG.info("Searching for illness starting date to {}", object.toString());
                            medicineCase.setStartingDateIllness(dateFormat.parse(object.toString()));
                        } catch (ParseException ex) {
                            LOG.error("Error parsing illness starting date {}", ex.getMessage(), ex);
                        }
                    }

                } else {
                    medicineCase.setStartingDateIllness(null);
                }
            }
        };

        final TextField<Date> startingDateIllness = new TextField<Date>("startingDateIllness", startingDateModel);

        diagnosisDateIllness.add(new SimpleAttributeModifier("title", getString("startingDateIllness")));

        final DatePicker startingDateIllnessPicker = new DatePicker() {

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

        startingDateIllness.add(startingDateIllnessPicker);

        form.add(startingDateIllness);

        ChoiceRenderer rendererHosOrg = new ChoiceRenderer("name", "id");
        IModel modelHosWard = new AbstractReadOnlyModel() {

            private static final long serialVersionUID = -2583290457773357445L;

            @Override
            public List<HospitalWard> getObject() {
                return hospitalManagement.getHospitalWard(medicineCase.getHospitalOrganization());
            }
        };
        DropDownChoice hospitalWard = new DropDownChoice("hospitalWard", modelHosWard, rendererHosOrg);
        hospitalWard.setOutputMarkupId(true);
        hospitalWard.add(new SimpleAttributeModifier("title", getString("hospitalWard")));
        form.add(hospitalWard);

        IModel modelHosOrg = new AbstractReadOnlyModel() {

            private static final long serialVersionUID = -2583290457773357445L;

            @Override
            public List<HospitalOrganization> getObject() {
                Region r = (Region) form.get("region").getDefaultModelObject();
                return hospitalManagement.findByRegion(r);
            }
        };
        DropDownChoice hospitalOrganization = new DropDownChoice("hospitalOrganization", modelHosOrg,
                rendererHosOrg);
        hospitalOrganization.setOutputMarkupId(true);
        hospitalOrganization.add(new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

            private static final long serialVersionUID = -1107858522700306810L;

            @Override
            protected void onUpdate(AjaxRequestTarget target) {
                target.addComponent(form.get("hospitalWard"));
            }
        });
        hospitalOrganization.add(new SimpleAttributeModifier("title", getString(
                "hospitalOrganization")));
        form.add(hospitalOrganization);

        ChoiceRenderer renderer = new ChoiceRenderer("description", "id");
        List<Region> regions = hospitalManagement.getRegions();
        Region r = medicineCase.getHospitalOrganization().getRegion();
        DropDownChoice region = new DropDownChoice("region", new Model(r), regions, renderer);
        region.add(new SimpleAttributeModifier("title", getString("regionHospital")));
        region.setOutputMarkupId(true);
        region.add(new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

            private static final long serialVersionUID = -1107858522700306810L;

            @Override
            protected void onUpdate(AjaxRequestTarget target) {
                target.addComponent(form.get("hospitalOrganization"));
                target.addComponent(form.get("hospitalWard"));
            }
        });
        form.add(region);

        CheckBox orphanMedicine = new CheckBox("orphanMedicine");
        orphanMedicine.add(new SimpleAttributeModifier("title", getString("orphanMedicine")));
        form.add(orphanMedicine);
    }

    private void createYearSearchCase() {

        DropDownChoice<Integer> startYearMC
                = new DropDownChoice<Integer>("startYearMC",
                        new PropertyModel<Integer>(this, "selectedStartYearMC"),
                        yearList);
        startYearMC.add(new SimpleAttributeModifier("title", getString("startYear")));
        startYearMC.setOutputMarkupId(true);

        DropDownChoice<Integer> endYearMC
                = new DropDownChoice<Integer>("endYearMC", new PropertyModel<Integer>(this, "selectedEndYearMC"),
                        yearList);
        endYearMC.add(new SimpleAttributeModifier("title", getString("endYear")));
        endYearMC.setOutputMarkupId(true);

        form.add(startYearMC);
        form.add(endYearMC);
    }

    public CaseAdvancedFind(String id, PageParameters parameters, Class classs) {
        super(id);
        fromClass = classs;
        if (parameters != null && parameters.containsKey("medicineCase")) {
            medicineCase = (MedicineCase) parameters.get("medicineCase");
        } else {
            medicineCase = new MedicineCase();
        }
        if (medicineCase.getPatient() == null) {
            medicineCase.setPatient(new Patient());
        }
        if (medicineCase.getIllness() == null) {
            medicineCase.setIllness(new Illness());
        }
        if (medicineCase.getHospitalOrganization() == null) {
            medicineCase.setHospitalOrganization(new HospitalOrganization());
        }
        illnessSelected = medicineCase.getIllness();
        form = new Form("search", new CompoundPropertyModel(medicineCase)) {

            private static final long serialVersionUID = -3061771342119019368L;

            @Override
            protected void onSubmit() {
                PageParameters parameters = new PageParameters();
                Patient patient = medicineCase.getPatient();
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

                LOG.debug("start year selected: {}", selectedStartYear);
                LOG.debug("end year selected: {}", selectedEndYear);
                LOG.debug("start year selected for MC insertion: {}", selectedStartYearMC);
                LOG.debug("end year selected for MC insertion: {}", selectedEndYearMC);
                if (selectedStartYear != null && selectedEndYear != null) {
                    // set parameters to pass for adv search by patient birth year
                    parameters.put("selectedStartYear", selectedStartYear);
                    parameters.put("selectedEndYear", selectedEndYear);
                }
                if (selectedStartYearMC != null && selectedEndYearMC != null) {
                    // set parameters to pass for adv search by medicine case insertion
                    parameters.put("selectedStartYearMC", selectedStartYearMC);
                    parameters.put("selectedEndYearMC", selectedEndYearMC);
                }
                parameters.put("medicineCase", medicineCase);
                if (fromClass.getClass().isInstance(ListCases.class)) {
                    setResponsePage(new ListCases(parameters));
                } else if (fromClass.getClass().isInstance(ListPatients.class)) {
                    setResponsePage(new ListPatients(parameters));

                }
            }
        };
        // initialize year list for advanced search
        yearList = new ArrayList<Integer>();
        for (int i = Calendar.getInstance().get(Calendar.YEAR); i >= 1910; i--) { // instead of 1910 Calendar.getInstance().get(Calendar.YEAR) - 105
            yearList.add(i);
        }

        createPatientName();
        List<Region> regions = caseManagement.getRegions();
        createPatientAdressBirth(regions);
        createPatientAdressLiving(regions);
        createEduOcc();
        createPopupIllness();
        createIllness();
        createYearSearchCase();
        add(form);

        form.add(new Button("find", new Model(getString("find"))));

        add(new Link("link") {

            private static final long serialVersionUID = -4331619903296515985L;

            @Override
            public void onClick() {
                if (fromClass.getClass().isInstance(ListCases.class)) {
                    setResponsePage(new ListCases(new PageParameters()));
                } else if (fromClass.getClass().isInstance(ListPatients.class)) {
                    setResponsePage(new ListPatients(new PageParameters()));

                }
            }
        });
    }

    public void setResult(Illness illness) {
        illnessSelected = illness;
    }
}
