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
@Table(name = "occupation")
@SequenceGenerator(name = "occupation_seq", sequenceName = "occ_seq", initialValue = 10, allocationSize = 1)
public class Occupation implements Serializable {

    @OneToMany(mappedBy = "personalOccupation")
    private List<Patient> patients;

    @OneToMany(mappedBy = "motherOccupation")
    private List<Patient> patientsMother;

    @OneToMany(mappedBy = "fatherOccupation")
    private List<Patient> patientsFather;

    private static final long serialVersionUID = 526650622171455001L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "occupation_seq")
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
