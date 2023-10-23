package net.tirasa.remara.persistence.data;

import java.io.Serializable;
import java.util.List;
import javax.annotation.Generated;
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

@Entity
@Table(name = "province")
@SequenceGenerator(name = "province_seq", sequenceName = "pr_seq", initialValue = 150, allocationSize = 1)
public class Province implements Serializable {

    @OneToMany(mappedBy = "province", cascade = CascadeType.ALL)
    private List<Municipality> municipalities;

    @OneToMany(mappedBy = "livingProvince")
    private List<Patient> patients;

    @OneToMany(mappedBy = "birthProvince")
    private List<Patient> patientsBirth;
    
    private static final long serialVersionUID = 7549734084359914405L;

    @Id
    @Column(length = 2)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "province_seq")
    private String id;

    @Column(name = "region")
    @ManyToOne
    private Region region;

    @Column
    private String description;

    @Column(name = "num_occupants")
    private Integer numOccupants;

    @Column(name = "num_municipalities")
    private Integer numMunicipalities;

    public String getId() {
        return this.id;
    }

    public void setId(final String id) {
        this.id = id;
    }

    public Region getRegion() {
        return this.region;
    }

    public void setRegion(Region region) {
        this.region = region;
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
}
