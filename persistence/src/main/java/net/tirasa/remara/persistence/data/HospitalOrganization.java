package net.tirasa.remara.persistence.data;

import java.io.Serializable;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.persistence.CascadeType;
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
import javax.persistence.Transient;

@Entity
@Table(name = "hospital_organization")
@SequenceGenerator(name = "hospital_seq", sequenceName = "ho_seq", initialValue = 2000, allocationSize = 1)
public class HospitalOrganization implements Serializable, Comparable<HospitalOrganization> {

    @OneToMany(mappedBy = "hospitalOrganization")
    private List<MedicineCase> medicineCases;

    private static final long serialVersionUID = -8778170488249660750L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hospital_seq")
    private Long id;

    @Column(name = "region", nullable = false)
    @ManyToOne
    private Region region;

    @Column(length = 255)
    private String name;

    @Column(length = 255)
    private String code;

    @OneToMany(mappedBy = "hospitalOrganization", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Set<HospitalWard> hospitalWards = new HashSet<>();

    @Transient
    private Set<HospitalWard> hospitalWardsToDelete = new HashSet<>();

    public Long getId() {
        return this.id;
    }

    public void setId(final Long id) {
        this.id = id;
    }

    public Region getRegion() {
        return this.region;
    }

    public void setRegion(final Region region) {
        this.region = region;
    }

    public String getName() {
        return this.name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(final String code) {
        this.code = code;
    }

    public Set<HospitalWard> getHospitalWards() {
        return this.hospitalWards;
    }

    public void setHospitalWards(final Set<HospitalWard> hospitalWards) {
        this.hospitalWards = new HashSet<>(hospitalWards);
    }

    public Set<HospitalWard> getHospitalWardsToDelete() {
        return hospitalWardsToDelete;
    }

    public void setHospitalWardsToDelete(Set<HospitalWard> hospitalWardsToDelete) {
        this.hospitalWardsToDelete = hospitalWardsToDelete;
    }

    @Override
    public int compareTo(final HospitalOrganization o) {
        return name.compareTo(o.getName());
    }
}
