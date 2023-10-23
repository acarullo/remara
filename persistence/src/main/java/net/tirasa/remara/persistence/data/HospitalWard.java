package net.tirasa.remara.persistence.data;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "hospital_ward")
@SequenceGenerator(name = "hospitalWard_seq", sequenceName = "hw_seq", initialValue = 2000, allocationSize = 1)
public class HospitalWard implements Serializable, Comparable<HospitalWard> {

    @OneToMany(mappedBy = "hospitalWard")
    private List<MedicineCase> medicineCases;

    private static final long serialVersionUID = 2089180926377536857L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hospitalWard_seq")
    private Long id;

    @Column(name = "hospital", nullable = false)
    @ManyToOne(fetch = FetchType.EAGER)
    private HospitalOrganization hospitalOrganization;

    @Column(length = 255, nullable = false)
    private String name;

    public Long getId() {
        return this.id;
    }

    public void setId(final Long id) {
        this.id = id;
    }

    public HospitalOrganization getHospitalOrganization() {
        return this.hospitalOrganization;
    }

    public void setHospitalOrganization(final HospitalOrganization hospitalOrganization) {
        this.hospitalOrganization = hospitalOrganization;
    }

    public String getName() {
        return this.name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    @Override
    public int compareTo(final HospitalWard t) {
        return name.compareTo(t.getName());
    }
}
