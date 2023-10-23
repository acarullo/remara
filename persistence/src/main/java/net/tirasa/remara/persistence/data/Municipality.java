package net.tirasa.remara.persistence.data;

import java.io.Serializable;
import java.util.List;
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
@Table(name = "municipality")
@SequenceGenerator(name = "municipality_seq", sequenceName = "mun_seq", initialValue = 10000, allocationSize = 1)
public class Municipality implements Serializable {

    @OneToMany(mappedBy = "birthMunicipality")
    private List<Patient> patients;

    @OneToMany(mappedBy = "livingMunicipality")
    private List<Patient> patientsLiving;

    private static final long serialVersionUID = 7872698847367052966L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "municipality_seq")
    private Long id;

    @Column(name = "province", length = 2)
    @ManyToOne
    private Province province;

    @Column(length = 100)
    private String description;

    @Column(length = 10)
    private String cadastre;

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Province getProvince() {
        return this.province;
    }

    public void setProvince(Province province) {
        this.province = province;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(final String description) {
        this.description = description;
    }

    public String getCadastre() {
        return cadastre;
    }

    public void setCadastre(final String cadastre) {
        this.cadastre = cadastre;
    }
}
