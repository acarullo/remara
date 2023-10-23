package net.tirasa.remara.persistence.data;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "education")
@SequenceGenerator(name = "education_seq", sequenceName = "ed_seq", initialValue = 10, allocationSize = 1)
public class Education implements Serializable {

    @OneToMany(mappedBy = "personalEducation")
    private List<Patient> patients;

    @OneToMany(mappedBy = "motherEducation")
    private List<Patient> patientsMother;

    @OneToMany(mappedBy = "fatherEducation")
    private List<Patient> patientsFather;

    private static final long serialVersionUID = 5148738801304071572L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "education_seq")
    private Long id;

    @Column(name = "description_it")
    private String descriptionIt;

    @Column(name = "description_en")
    private String descriptionEn;

    @Column
    private String code;

    public Long getId() {
        return this.id;
    }

    public void setId(final Long id) {
        this.id = id;
    }

    public String getDescriptionIt() {
        return this.descriptionIt;
    }

    public void setDescriptionIt(final String descriptionIt) {
        this.descriptionIt = descriptionIt;
    }

    public String getDescriptionEn() {
        return this.descriptionEn;
    }

    public void setDescriptionEn(final String descriptionEn) {
        this.descriptionEn = descriptionEn;
    }

    public String getCode() {
        return code;
    }

    public void setCode(final String code) {
        this.code = code;
    }
}
