package net.tirasa.remara.console.pages;

import net.tirasa.remara.core.management.CaseManagement;
import net.tirasa.remara.core.management.UserManagement;
import net.tirasa.remara.core.resource.IResourcePDFImpl;
import net.tirasa.remara.core.resource.IResourceStreamImpl;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;

import net.tirasa.remara.core.workflow.WorkflowManager;
import net.tirasa.remara.persistence.data.Exam;
import net.tirasa.remara.persistence.data.FileCase;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import net.tirasa.remara.persistence.data.MedicineCase;
import net.tirasa.remara.persistence.data.Patient;
import net.tirasa.remara.persistence.data.User;
import org.apache.wicket.PageParameters;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.markup.html.WebResource;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.link.ResourceLink;
import org.apache.wicket.markup.html.list.ListItem;
import org.apache.wicket.markup.html.list.ListView;
import org.apache.wicket.model.Model;
import org.apache.wicket.protocol.http.WebResponse;
import org.apache.wicket.spring.injection.annot.SpringBean;
import org.apache.wicket.util.resource.IResourceStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@AuthorizeInstantiation("ADMIN")
public final class CaseViewPopup extends WebPage {

    private static final long serialVersionUID = 5359474749907027511L;

    private static final Logger LOG = LoggerFactory.getLogger(CaseViewPopup.class);

    @SpringBean
    private UserManagement userManagement;

    @SpringBean
    private CaseManagement caseManagement;

    @SpringBean
    private IResourcePDFImpl iResourcePDFImpl;

    private DateFormat df = null;

    private void viewCompiler(final User compiler, String owner) {
        if (compiler != null) {
            String compilerName = compiler.getName() + " " + compiler.getSurname();

            add(new Label("compilerName", new Model(compilerName)));
            add(new Label("email", new Model(compiler.getEmail())));
            add(new Label("compilerHospital", new Model(compiler.getHospitalOrganization())));
            add(new Label("compilerWard", new Model(compiler.getHospitalWard())));
            add(new Label("compilerAddress", new Model(compiler.getAddress())));
            add(new Label("phone", new Model(compiler.getPhone())));
            add(new Label("fax", new Model(compiler.getFax())));
        } else {
            add(new Label("compilerName", "USER " + owner + " DOES NOT EXIST ON ReMaRa DATABASE"));
            add(new Label("email", "not available"));
            add(new Label("compilerHospital", "not available"));
            add(new Label("compilerWard", "not available"));
            add(new Label("compilerAddress", "not available"));
            add(new Label("phone", "not available"));
            add(new Label("fax", "not available"));
        }
    }

    public CaseViewPopup(final PageParameters parameters) {
        super(parameters);

        MedicineCase medicineCase = (MedicineCase) parameters.get("medicineCase");
        viewCompiler(userManagement.getUser(medicineCase.getOwner()), medicineCase.getOwner());
        String illness = medicineCase.getIllness().getExempt() + " - " + medicineCase.getIllness().getDescription();
        Date startingDateIllness = null;
        Date diagnosisDateIllness = null;
        try {
            startingDateIllness = medicineCase.getStartingDateIllness();
            diagnosisDateIllness = medicineCase.getDiagnosisDateIllness();
        } catch (Exception ex) {
            LOG.error("Error parsisng date illness: {}", ex);
        }

        Date lastAction = caseManagement.getLastActionForMC(medicineCase.getWorkflow());
        String status = ListCases.getStatus(medicineCase);

        WebResource export = new WebResource() {

            private final MedicineCase medicineCase = (MedicineCase) parameters.get("medicineCase");

            private static final long serialVersionUID = 1L;

            @Override
            public IResourceStream getResourceStream() {

                return iResourcePDFImpl.iResourcePDFImpl(medicineCase, true);
            }

            @Override
            protected void setHeaders(WebResponse response) {
                super.setHeaders(response);
                response.setHeader("Pragma", "public");
                response.setHeader("Cache-Control", "no-store, must-revalidate");
                response.setHeader("Expires", "-1");
                response.setAttachmentHeader(medicineCase.getId() + ".pdf");
            }
        };
        export.setCacheable(false);

        ResourceLink linkPrint = new ResourceLink("linkPrint", export);
        linkPrint.add(new SimpleAttributeModifier("title", getString("print")));
        add(linkPrint);

        df = DateFormat.getDateInstance(DateFormat.MEDIUM, getLocale());
        String dataAction = "";
        if (lastAction != null) {
            dataAction = df.format(lastAction);
        }

        String reason = medicineCase.getReason();
        if (reason == null) {
            reason = "";
        }
        if (status.equals(WorkflowManager.STATUS_REJECTED)
                || status.equals("Modified")) {
            dataAction += " (" + reason + ")";
        }

        HospitalOrganization hospital = medicineCase.getHospitalOrganization();

        String hospitalOrganization;
        String foreignerHospital = medicineCase.getForeigner();
        if (foreignerHospital.equals(getString("foreign1"))) {
            hospitalOrganization = medicineCase.getHospitalWard().getName()
                    + " - " + hospital.getName()
                    + " (" + hospital.getRegion().getDescription() + ")";
        } else {
            hospitalOrganization = medicineCase.getHospitalForeigner()
                    + " (" + medicineCase.getNation().getDescriptionIt() + ")";
        }

        String orphanMedicine = "";
        if (medicineCase.getOrphanMedicine() != null) {
            if (medicineCase.getOrphanMedicine()) {
                orphanMedicine = getString("true");
            }
            if (!medicineCase.getOrphanMedicine()) {
                orphanMedicine = getString("false");
            }
        }
        String medicineDescription = medicineCase.getMedicineDescription();

        String categoryCMedicine = "";
        if (medicineCase.getCategoryCMedicine() != null) {
            if (medicineCase.getCategoryCMedicine()) {
                categoryCMedicine = getString("true");
            }
            if (!medicineCase.getCategoryCMedicine()) {
                categoryCMedicine = getString("false");
            }
        }

        String categoryCMedicineDescription = medicineCase.getCategoryCMedicineDescription();

        String exactlyIllness = medicineCase.getExactlyIllness();
        String strStartingDateIllness;
        if (startingDateIllness != null) {
            strStartingDateIllness = df.format(startingDateIllness);
        } else {
            strStartingDateIllness = getString(medicineCase.getTypeStartingDate());
        }

        add(new Label("data_action", new Model(dataAction)));
        add(new Label("status", new Model(getString(status))));
        add(new Label("illness", new Model(illness)));
        add(new Label("exactlyIllness", new Model(exactlyIllness)));
        add(new Label("startingDateIllness", new Model(strStartingDateIllness)));
        add(new Label("diagnosisDateIllness", new Model(df.format(diagnosisDateIllness))));
        add(new Label("hospitalOrganization", new Model(hospitalOrganization)));
        add(new Label("orphanMedicine", new Model(orphanMedicine)));
        add(new Label("medicineDescription", new Model(medicineDescription)));
        add(new Label("categoryCMedicine", new Model(categoryCMedicine)));
        add(new Label("categoryCMedicineDescription", new Model(categoryCMedicineDescription)));

        addPersonView(medicineCase);
        addExamsView(medicineCase);
    }

    private void addPersonView(MedicineCase medicineCase) {
        Patient patient = medicineCase.getPatient();
        String name = patient.getName() + " " + patient.getSurname();
        String foreigner = patient.getForeigner();
        String birthAddress = "";

        if (foreigner.equals("Italia")) {
            if (patient.getBirthMunicipality() != null) {
                birthAddress += patient.getBirthMunicipality().getDescription();
            }
            if (patient.getBirthProvince() != null) {
                birthAddress += " (" + patient.getBirthProvince().getId() + ") ";
            }
            if (patient.getBirthCap() != null && !patient.getBirthCap().isEmpty()) {
                birthAddress += " - " + patient.getBirthCap();
            }
        } else {
            birthAddress += " " + patient.getBirthForeignInformation();
            if (patient.getBirthNation() != null) {
                birthAddress += " " + patient.getBirthNation().getDescriptionIt();
            }
        }
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
        String personalEducation = "";
        if (patient.getPersonalEducation() != null) {
            personalEducation = patient.getPersonalEducation().getDescriptionIt();
        }
        String personalOccupation = "";
        if (patient.getPersonalOccupation() != null) {
            personalOccupation = patient.getPersonalOccupation().getDescriptionIt();
        }
        String motherEducation = "";
        if (patient.getMotherEducation() != null) {
            motherEducation = patient.getMotherEducation().getDescriptionIt();
        }
        String fatherEducation = "";
        if (patient.getFatherEducation() != null) {
            fatherEducation = patient.getFatherEducation().getDescriptionIt();
        }
        String motherOccupation = "";
        if (patient.getMotherOccupation() != null) {
            motherOccupation = patient.getMotherOccupation().getDescriptionIt();
        }
        String fatherOccupation = "";
        if (patient.getFatherOccupation() != null) {
            fatherOccupation = patient.getFatherOccupation().getDescriptionIt();
        }
        String deathDate = "";
        if (patient.getDeathDate() != null) {
            deathDate = df.format(patient.getDeathDate());
        }

        add(new Label("name", new Model(name)));
        add(new Label("sex", new Model(patient.getSex())));
        add(new Label("taxCode", new Model(patient.getTaxCode())));
        add(new Label("birthDate", new Model(df.format(patient.getBirthDate()))));
        add(new Label("deathDate", new Model(deathDate)));
        add(new Label("place_of_birth", new Model(birthAddress)));
        add(new Label("residence", new Model(residence)));
        add(new Label("personalEducation", new Model(personalEducation)));
        add(new Label("personalOccupation", new Model(personalOccupation)));
        add(new Label("exactlyOccupation", new Model(patient.getExactlyOccupation())));
        add(new Label("motherEducation", new Model(motherEducation)));
        add(new Label("fatherEducation", new Model(fatherEducation)));
        add(new Label("motherOccupation", new Model(motherOccupation)));
        add(new Label("fatherOccupation", new Model(fatherOccupation)));
    }

    private void addExamsView(final MedicineCase medicineCase) {
        List<Exam> exams = caseManagement.getExamsOfMC(medicineCase.getId());
        add(new ListView("examsList", exams) {

            private static final long serialVersionUID = 4949588177564901031L;

            @Override
            protected void populateItem(ListItem item) {
                final Exam exam = (Exam) item.getModelObject();
                String dataExam = getString("dateNotknow");
                if (exam.getDataExam() != null) {
                    dataExam = df.format(exam.getDataExam());
                }
                item.add(new Label("dataExam", new Model(dataExam)));
                item.add(new Label("typeExam", new Model(getString(exam.getTypeExam()))));
                item.add(new Label("exam", new Model(exam.getDescription())).setEscapeModelStrings(false));
                item.add(new Label("report", new Model(exam.getReport())).setEscapeModelStrings(false));
                item.add(new Label("criterion", new Model(exam.getCriterion())).setEscapeModelStrings(false));
                List<FileCase> files = caseManagement.getFiles(exam.getId());
                item.add(new ListView("fileList", files) {

                    private static final long serialVersionUID = 4949588177564901031L;

                    @Override
                    protected void populateItem(ListItem item) {
                        final FileCase file = (FileCase) item.getModelObject();

                        WebResource export = new WebResource() {

                            private static final long serialVersionUID = 1L;

                            @Override
                            public IResourceStream getResourceStream() {
                                return new IResourceStreamImpl(file);
                            }

                            @Override
                            protected void setHeaders(WebResponse response) {
                                super.setHeaders(response);
                                response.setHeader("Pragma", "public");
                                response.setHeader("Cache-Control", "no-store, must-revalidate");
                                response.setHeader("Expires", "-1");
                                response.setAttachmentHeader(file.getName());
                            }
                        };
                        export.setCacheable(false);

                        ResourceLink dlLink = new ResourceLink("file", export);
                        dlLink.add(new Label("nameFile", file.getName()));
                        item.add(dlLink);
                    }
                });
            }
        });
    }
}
