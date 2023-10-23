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
@Table(name = "illness")
@SequenceGenerator(name = "illness_seq", sequenceName = "ill_seq", initialValue = 1000, allocationSize = 1)
public class Illness implements Serializable {

    @OneToMany(mappedBy = "illness")
    private List<MedicineCase> medicineCases;

    private static final long serialVersionUID = 7731869533275122559L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "illness_seq")
    protected Long id;

    @Column(length = 255)
    protected String code;

    @Column(length = 255)
    protected String description;

    @Column(length = 255)
    protected String exempt;

    @Column
    protected Boolean marche;

    public Long getId() {
        return id;
    }

    public void setId(final Long id) {
        this.id = id;
    }

    public String getCode() {
        return this.code;
    }

    public void setCode(final String code) {
        this.code = code;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(final String description) {
        this.description = description;
    }

    public String getExempt() {
        return this.exempt;
    }

    public void setExempt(final String exempt) {
        this.exempt = exempt;
    }

    public Boolean getMarche() {
        return marche;
    }

    public void setMarche(final Boolean marche) {
        this.marche = marche;
    }
}
