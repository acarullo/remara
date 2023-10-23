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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;

@Entity
@Table(name = "exam")
@SequenceGenerator(name = "exam_seq", sequenceName = "ex_seq", initialValue = 25000, allocationSize = 1)
public class Exam implements Serializable {

    private static final long serialVersionUID = 6109310880962136164L;

    @OneToMany(mappedBy = "exam", cascade = CascadeType.ALL)
    private List<FileCase> fileCases;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "exam_seq")
    private Long id;

    @Column(name = "medicine_case", nullable = false)
    @ManyToOne
    private MedicineCase medicineCase;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "type_exam", length = 20)
    private String typeExam;

    @Column(name = "data_exam", length = 13)
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date dataExam;

    @Column(columnDefinition = "TEXT")
    private String report;

    @Column(columnDefinition = "TEXT")
    private String criterion;

    public String getDescription() {
        return description;
    }

    public void setDescription(final String description) {
        this.description = description;
    }

    public Long getId() {
        return id;
    }

    public void setId(final Long id) {
        this.id = id;
    }

    public MedicineCase getMedicineCase() {
        return medicineCase;
    }

    public void setMedicineCase(final MedicineCase medicineCase) {
        this.medicineCase = medicineCase;
    }

    public String getTypeExam() {
        return typeExam;
    }

    public void setTypeExam(final String typeExam) {
        this.typeExam = typeExam;
    }

    public String getCriterion() {
        return criterion;
    }

    public void setCriterion(final String criterion) {
        this.criterion = criterion;
    }

    public Date getDataExam() {
        return dataExam;
    }

    public void setDataExam(final Date dataExam) {
        this.dataExam = dataExam;
    }

    public String getReport() {
        return report;
    }

    public void setReport(final String report) {
        this.report = report;
    }

    public List<FileCase> getFileCases() {
        return fileCases;
    }

    public void setFileCases(final List<FileCase> fileCases) {
        this.fileCases = fileCases;
    }
    
    public static Exam createNewInstanceExam(final Exam exam) {
        Exam newExam = new Exam();
        newExam.setId(exam.getId());
        newExam.setMedicineCase(exam.getMedicineCase());
        newExam.setDescription(exam.getDescription());
        newExam.setReport(exam.getReport());
        newExam.setCriterion(exam.getCriterion());
        newExam.setDataExam(exam.getDataExam());
        newExam.setTypeExam(exam.getTypeExam());
        return newExam;
    }
}
