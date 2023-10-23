package net.tirasa.remara.persistence.data;

import java.io.Serializable;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "region")
@SequenceGenerator(name = "region_seq", sequenceName = "reg_seq", initialValue = 30, allocationSize = 1)
public class Region implements Serializable {

    @OneToMany(mappedBy = "region", cascade = CascadeType.ALL)
    private List<Province> provinces;

    @OneToMany(mappedBy = "livingRegion")
    private List<Patient> patients;
    
    @OneToMany(mappedBy = "birthRegion")
    private List<Patient> patientsBirth;

    @OneToMany(mappedBy = "region")
    private List<HospitalOrganization> hospitalOrganizations;

    private static final long serialVersionUID = -5690865373032301536L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "region_seq")
    private Long id;

    @Column(length = 100)
    private String description;

    @Column(name = "num_occupants")
    private Integer numOccupants;

    @Column(name = "num_municipalities")
    private Integer numMunicipalities;

    @Column(name = "num_provinces")
    private Integer numProvinces;

    public Long getId() {
        return this.id;
    }

    public void setId(final Long id) {
        this.id = id;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(final String description) {
        this.description = description;
    }

    public Integer getNumOccupants() {
        return this.numOccupants;
    }

    public void setNumOccupants(final Integer numOccupants) {
        this.numOccupants = numOccupants;
    }

    public Integer getNumMunicipalities() {
        return this.numMunicipalities;
    }

    public void setNumMunicipalities(final Integer numMunicipalities) {
        this.numMunicipalities = numMunicipalities;
    }

    public Integer getNumProvinces() {
        return this.numProvinces;
    }

    public void setNumProvinces(final Integer numProvinces) {
        this.numProvinces = numProvinces;
    }
}
