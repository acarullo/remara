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
@Table(name = "nation")
@SequenceGenerator(name = "nation_seq", sequenceName = "nat_seq", initialValue = 300, allocationSize = 1)
public class Nation implements Serializable {

    @OneToMany(mappedBy = "nation")
    private List<MedicineCase> medicineCases;

    @OneToMany(mappedBy = "birthNation")
    private List<Patient> patients;

    @OneToMany(mappedBy = "livingNation")
    private List<Patient> patientsLiving;
    
    private static final long serialVersionUID = 5823042972490243473L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "nation_seq")
    private Long id;

    @Column(name = "description_it")
    private String descriptionIt;

    @Column(length = 3)
    private String initials;

    @Column(name = "description_en")
    private String descriptionEn;

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

    public String getInitials() {
        return this.initials;
    }

    public void setInitials(final String initials) {
        this.initials = initials;
    }

    public String getDescriptionEn() {
        return this.descriptionEn;
    }

    public void setDescriptionEn(final String descriptionEn) {
        this.descriptionEn = descriptionEn;
    }
}
