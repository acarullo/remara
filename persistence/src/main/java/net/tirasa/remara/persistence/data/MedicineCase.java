package net.tirasa.remara.persistence.data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "medicine_case")
@SequenceGenerator(name = "medicineCase_seq", sequenceName = "mc_seq", initialValue = 15000, allocationSize = 1)
public class MedicineCase implements Serializable, Comparable<MedicineCase> {

    @OneToMany(mappedBy = "medicineCase", cascade = CascadeType.ALL)
    private List<Exam> exams;

    private static final long serialVersionUID = -7817042022541515970L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "medicineCase_seq")
    private Long id;

    @Column(name = "illness", nullable = false)
    @ManyToOne
    private Illness illness;

    @Column(name = "exactly_illness", length = 255, nullable = false)
    private String exactlyIllness;

    @Column(length = 255)
    private String foreigner;

    @Column(name = "nation")
    @ManyToOne
    private Nation nation;

    @Column(name = "hospital_foreigner", length = 255)
    private String hospitalForeigner;

    @Column(name = "hospital")
    @ManyToOne
    private HospitalOrganization hospitalOrganization;

    @Column(name = "patient", nullable = false)
    @ManyToOne
    private Patient patient;

    @Column(name = "ward")
    @ManyToOne
    private HospitalWard hospitalWard;

    @Temporal(TemporalType.DATE)
    @Column(name = "diagnosis_date_illness", length = 13, nullable = false)
    private Date diagnosisDateIllness;

    @Temporal(TemporalType.DATE)
    @Column(name = "starting_date_illness", length = 13)
    private Date startingDateIllness;

    @Column(name = "type_starting_date", length = 15)
    private String typeStartingDate;

    @Column
    private String owner;

    @Column
    private String referent;

    @Column
    private Long workflow;

    @Column(name = "status_workflow", length = 20)
    private String statusWorkflow;

    @Temporal(TemporalType.DATE)
    @Column(name = "insert_date", length = 13, nullable = false)
    private Date insertDate;

    @Temporal(TemporalType.DATE)
    @Column(name = "sped_date", length = 13)
    private Date spedDate;

    @Column(name = "orphan_medicine")
    private Boolean orphanMedicine;

    @Column(name = "medicine_description", length = 255)
    private String medicineDescription;

    @Lob
    @Column(name = "reason", length = 12240)
    private String reason;

    @Column(name = "ex_pp", nullable = false)
    private Boolean exPp = false;

    @Column(name = "category_c_medicine")
    private Boolean categoryCMedicine;

    @Column(name = "category_c_medicine_description", length = 255)
    private String categoryCMedicineDescription;

    public Boolean isExPp() {
        return exPp;
    }

    public void setExPp(final Boolean exPp) {
        this.exPp = exPp;
    }

    public Boolean getExPp() {
        return this.exPp;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(final Long id) {
        this.id = id;
    }

    public Illness getIllness() {
        return this.illness;
    }

    public void setIllness(final Illness illness) {
        this.illness = illness;
    }

    public String getExactlyIllness() {
        return exactlyIllness;
    }

    public void setExactlyIllness(final String exactlyIllness) {
        this.exactlyIllness = exactlyIllness;
    }

    public String getForeigner() {
        return foreigner;
    }

    public void setForeigner(final String foreigner) {
        this.foreigner = foreigner;
    }

    public String getHospitalForeigner() {
        return hospitalForeigner;
    }

    public void setHospitalForeigner(final String hospitalForeigner) {
        this.hospitalForeigner = hospitalForeigner;
    }

    public Nation getNation() {
        return this.nation;
    }

    public void setNation(final Nation nation) {
        this.nation = nation;
    }

    public HospitalOrganization getHospitalOrganization() {
        return this.hospitalOrganization;
    }

    public void setHospitalOrganization(final HospitalOrganization hospitalOrganization) {
        this.hospitalOrganization = hospitalOrganization;
    }

    public Patient getPatient() {
        return this.patient;
    }

    public void setPatient(final Patient patient) {
        this.patient = patient;
    }

    public HospitalWard getHospitalWard() {
        return this.hospitalWard;
    }

    public void setHospitalWard(final HospitalWard hospitalWard) {
        this.hospitalWard = hospitalWard;
    }

    public Date getDiagnosisDateIllness() {
        return this.diagnosisDateIllness;
    }

    public void setDiagnosisDateIllness(final Date diagnosisDateIllness) {
        this.diagnosisDateIllness = diagnosisDateIllness;
    }

    public Date getStartingDateIllness() {
        return startingDateIllness;
    }

    public void setStartingDateIllness(final Date startingDateIllness) {
        this.startingDateIllness = startingDateIllness;
    }

    public String getOwner() {
        return owner;
    }

    public List<Exam> getExams() {
        return this.exams;
    }

    public void setOwner(final String owner) {
        this.owner = owner;
    }

    public String getReferent() {
        return referent;
    }

    public void setReferent(final String referent) {
        this.referent = referent;
    }

    public String getStatusWorkflow() {
        return statusWorkflow;
    }

    public void setStatusWorkflow(final String statusWorkflow) {
        this.statusWorkflow = statusWorkflow;
    }

    public Long getWorkflow() {
        return workflow;
    }

    public void setWorkflow(final Long workflow) {
        this.workflow = workflow;
    }

    public Date getInsertDate() {
        return insertDate;
    }

    public void setInsertDate(final Date insertDate) {
        this.insertDate = insertDate;
    }

    public Date getSpedDate() {
        return spedDate;
    }

    public void setSpedDate(final Date spedDate) {
        this.spedDate = spedDate;
    }

    public Boolean getOrphanMedicine() {
        return orphanMedicine;
    }

    public void setOrphanMedicine(final Boolean orphanMedicine) {
        this.orphanMedicine = orphanMedicine;
    }

    public String getMedicineDescription() {
        return medicineDescription;
    }

    public void setMedicineDescription(final String medicineDescription) {
        this.medicineDescription = medicineDescription;
    }

    public String getTypeStartingDate() {
        return typeStartingDate;
    }

    public void setTypeStartingDate(final String typeStartingDate) {
        this.typeStartingDate = typeStartingDate;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(final String reason) {
        this.reason = reason;
    }

    public void setExams(List<Exam> exams) {
        this.exams = exams;
    }

    public Boolean getCategoryCMedicine() {
        return categoryCMedicine;
    }

    public void setCategoryCMedicine(Boolean categoryCMedicine) {
        this.categoryCMedicine = categoryCMedicine;
    }

    public String getCategoryCMedicineDescription() {
        return categoryCMedicineDescription;
    }

    public void setCategoryCMedicineDescription(String categoryCMedicineDescription) {
        this.categoryCMedicineDescription = categoryCMedicineDescription;
    }

    @Override
    public int compareTo(final MedicineCase o) {
        return patient.getSurname().compareTo(o.getPatient().getSurname());
    }

    @Override
    public String toString() {
        return "MedicineCase: \n "
                + "id: " + this.id + "\n"
                + "exactlyIllness: " + this.exactlyIllness + "\n"
                + "foreigner: " + this.foreigner + "\n"
                + "hospitalForeigner: " + this.hospitalForeigner + "\n"
                + "medicineDescription: " + this.medicineDescription + "\n"
                + "owner: " + this.owner + "\n"
                + "reason: " + this.reason + "\n"
                + "referent: " + this.referent + "\n"
                + "statusWorkflow: " + this.statusWorkflow + "\n"
                + "typeStartingDate. " + this.typeStartingDate + "\n"
                + "diagnosisDateIllness: " + this.diagnosisDateIllness + "\n"
                + "exPp: " + this.exPp + "\n"
                + "exams: " + this.exams + "\n"
                + "hospitalOrganization: " + this.hospitalOrganization + "\n"
                + "hospitalWard: " + this.hospitalWard + "\n"
                + "illness: " + this.illness + "\n"
                + "insertDate: " + this.insertDate + "\n"
                + "nation: " + this.nation + "\n"
                + "orphanMedicine: " + this.orphanMedicine + "\n"
                + "patient: " + this.patient.getSurname() + "\n"
                + "spedDate: " + this.spedDate + "\n"
                + "startingDateIllness: " + this.startingDateIllness;
    }

    public static MedicineCase createNewInstanceMC(final MedicineCase medicineCase) {
        MedicineCase newMedicineCase = new MedicineCase();
        newMedicineCase.setPatient(medicineCase.getPatient());
        newMedicineCase.setExams(medicineCase.getExams());
        newMedicineCase.setId(medicineCase.getId());
        newMedicineCase.setDiagnosisDateIllness(medicineCase.getDiagnosisDateIllness());
        newMedicineCase.setExPp(medicineCase.getExPp());
        newMedicineCase.setCategoryCMedicine(medicineCase.getCategoryCMedicine());
        newMedicineCase.setCategoryCMedicineDescription(medicineCase.getCategoryCMedicineDescription());
        newMedicineCase.setExactlyIllness(medicineCase.getExactlyIllness());
        newMedicineCase.setForeigner(medicineCase.getForeigner());
        newMedicineCase.setHospitalForeigner(medicineCase.getHospitalForeigner());
        newMedicineCase.setHospitalOrganization(medicineCase.getHospitalOrganization());
        newMedicineCase.setHospitalWard(medicineCase.getHospitalWard());
        newMedicineCase.setIllness(medicineCase.getIllness());
        newMedicineCase.setInsertDate(medicineCase.getInsertDate());
        newMedicineCase.setMedicineDescription(medicineCase.getMedicineDescription());
        newMedicineCase.setNation(medicineCase.getNation());
        newMedicineCase.setOrphanMedicine(medicineCase.getOrphanMedicine());
        newMedicineCase.setOwner(medicineCase.getOwner());
        newMedicineCase.setReason(medicineCase.getReason());
        newMedicineCase.setReferent(medicineCase.getReferent());
        newMedicineCase.setSpedDate(medicineCase.getSpedDate());
        newMedicineCase.setStartingDateIllness(medicineCase.getStartingDateIllness());
        newMedicineCase.setStatusWorkflow(medicineCase.getStatusWorkflow());
        newMedicineCase.setTypeStartingDate(medicineCase.getTypeStartingDate());
        newMedicineCase.setWorkflow(medicineCase.getWorkflow());
        return newMedicineCase;
    }
}
