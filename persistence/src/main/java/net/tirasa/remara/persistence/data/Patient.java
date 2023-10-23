package net.tirasa.remara.persistence.data;

import java.io.Serializable;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.Transient;
import net.tirasa.remara.persistence.utilities.JasyptMethods;

@Entity
@Table(name = "patient")
@SequenceGenerator(name = "patient_seq", sequenceName = "pat_seq", initialValue = 40000, allocationSize = 1)
public class Patient implements Serializable, Comparable<Patient> {

    private static final long serialVersionUID = -7552233391477699729L;

    @OneToMany(mappedBy = "patient")
    private List<MedicineCase> medicineCases;

    @Transient
    private boolean forceCf;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "patient_seq")
    private Long id;

    @Temporal(javax.persistence.TemporalType.DATE)
    @Column(name = "birth_date", length = 13)
    private Date birthDate;

    @Column(name = "tax_code", length = 255)
    private String taxCode;

    @Column(length = 255)
    private String name;

    @Column(length = 255)
    private String surname;

    @Column(length = 1)
    private String sex;
    
    @Column(length = 20)
    private Long telephone;

    @Column(length = 255)
    private String foreigner;

    @Column(name = "birth_nation")
    @ManyToOne
    private Nation birthNation;

    @ManyToOne
    @Column(name = "birth_region")
    private Region birthRegion;

    @Column(name = "birth_province", length = 2)
    @ManyToOne
    private Province birthProvince;

    @ManyToOne
    @Column(name = "birth_municipality")
    private Municipality birthMunicipality;

    @Column(length = 255, name = "birth_cap")
    private String birthCap;

    @Column(name = "birth_foreign_information", length = 255)
    private String birthForeignInformation;

    @Column(name = "living_nation")
    @ManyToOne
    private Nation livingNation;

    @Column(name = "living_region")
    @ManyToOne
    private Region livingRegion;

    @Column(name = "living_province", length = 2)
    @ManyToOne
    private Province livingProvince;

    @Column(name = "living_municipality")
    @ManyToOne
    private Municipality livingMunicipality;

    @Column(name = "living_cap", length = 255)
    private String livingCap;

    @Column(name = "living_address", length = 255)
    private String livingAddress;

    @Temporal(javax.persistence.TemporalType.DATE)
    @Column(name = "death_date", length = 13)
    private Date deathDate;

    @Column(name = "education")
    @ManyToOne
    private Education personalEducation;

    @Column(name = "occupation")
    @ManyToOne
    private Occupation personalOccupation;

    @Column(name = "exactly_occupation", length = 255)
    private String exactlyOccupation;

    @Column(name = "mother_education")
    @ManyToOne
    private Education motherEducation;

    @Column(name = "father_education")
    @ManyToOne
    private Education fatherEducation;

    @Column(name = "mother_occupation")
    @ManyToOne
    private Occupation motherOccupation;

    @Column(name = "father_occupation")
    @ManyToOne
    private Occupation fatherOccupation;

    public Long getTelephone() {
        return telephone;
    }

    public void setTelephone(final Long telephone) {
        this.telephone = telephone;
    }

    public boolean isForceCf() {
        return forceCf;
    }

    public void setForceCf(final boolean forceCf) {
        this.forceCf = forceCf;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(final Long id) {
        this.id = id;
    }

    public Municipality getBirthMunicipality() {
        return this.birthMunicipality;
    }

    public void setBirthMunicipality(final Municipality birthMunicipality) {
        this.birthMunicipality = birthMunicipality;
    }

    public Nation getBirthNation() {
        return this.birthNation;
    }

    public void setBirthNation(final Nation birthNation) {
        this.birthNation = birthNation;
    }

    public Region getBirthRegion() {
        return this.birthRegion;
    }

    public void setBirthRegion(final Region birthRegion) {
        this.birthRegion = birthRegion;
    }

    public Province getLivingProvince() {
        return this.livingProvince;
    }

    public void setLivingProvince(final Province livingProvince) {
        this.livingProvince = livingProvince;
    }

    public Nation getLivingNation() {
        return this.livingNation;
    }

    public void setLivingNation(final Nation livingNation) {
        this.livingNation = livingNation;
    }

    public Education getFatherEducation() {
        return this.fatherEducation;
    }

    public void setFatherEducation(final Education fatherEducation) {
        this.fatherEducation = fatherEducation;
    }

    public Province getBirthProvince() {
        return this.birthProvince;
    }

    public void setBirthProvince(final Province birthProvince) {
        this.birthProvince = birthProvince;
    }

    public Education getPersonalEducation() {
        return this.personalEducation;
    }

    public void setPersonalEducation(final Education personalEducation) {
        this.personalEducation = personalEducation;
    }

    public Occupation getPersonalOccupation() {
        return this.personalOccupation;
    }

    public void setPersonalOccupation(final Occupation personalOccupation) {
        this.personalOccupation = personalOccupation;
    }

    public String getExactlyOccupation() {
        return exactlyOccupation;
    }

    public void setExactlyOccupation(final String exactlyOccupation) {
        this.exactlyOccupation = exactlyOccupation;
    }

    public Occupation getFatherOccupation() {
        return this.fatherOccupation;
    }

    public void setFatherOccupation(final Occupation fatherOccupation) {
        this.fatherOccupation = fatherOccupation;
    }

    public Occupation getMotherOccupation() {
        return this.motherOccupation;
    }

    public void setMotherOccupation(final Occupation motherOccupation) {
        this.motherOccupation = motherOccupation;
    }

    public Region getLivingRegion() {
        return this.livingRegion;
    }

    public void setLivingRegion(final Region livingRegion) {
        this.livingRegion = livingRegion;
    }

    public Education getMotherEducation() {
        return this.motherEducation;
    }

    public void setMotherEducation(final Education motherEducation) {
        this.motherEducation = motherEducation;
    }

    public Municipality getLivingMunicipality() {
        return this.livingMunicipality;
    }

    public void setLivingMunicipality(final Municipality livingMunicipality) {
        this.livingMunicipality = livingMunicipality;
    }

    public String getTaxCode() {
        final JasyptMethods jasyptMethods = JasyptMethods.getJasyptMethods();
        return jasyptMethods.decrypt(taxCode);
    }

    public void setTaxCode(final String taxCode) {
        final JasyptMethods jasyptMethods = JasyptMethods.getJasyptMethods();
        this.taxCode = jasyptMethods.encrypt(taxCode);
    }

    public String getName() {
        final JasyptMethods jasyptMethods = JasyptMethods.getJasyptMethods();
        return jasyptMethods.decrypt(name);
    }

    public void setName(final String name) {
        final JasyptMethods jasyptMethods = JasyptMethods.getJasyptMethods();
        this.name = jasyptMethods.encrypt(name);
    }

    public String getSurname() {
        final JasyptMethods jasyptMethods = JasyptMethods.getJasyptMethods();
        String tempSurname = surname;
        if (surname != null) {
            if (surname.startsWith("-")) {
                tempSurname = surname.replaceFirst("-", "");
            } else {
                tempSurname = surname.substring(3, surname.length());
            }
        }
        return jasyptMethods.decrypt(tempSurname);
    }

    public void setSurname(final String surname) {
        final JasyptMethods jasyptMethods = JasyptMethods.getJasyptMethods();
        if (surname.length() > 2) {
            this.surname = surname.substring(0, 2) + "-" + jasyptMethods.encrypt(surname);
        } else {
            this.surname = surname + "-" + jasyptMethods.encrypt(surname);
        }
    }

    public String getSex() {
        return this.sex;
    }

    public void setSex(final String sex) {
        this.sex = sex;
    }

    public String getForeigner() {
        return this.foreigner;
    }

    public void setForeigner(final String foreigner) {
        this.foreigner = foreigner;
    }

    public Date getBirthDate() {
        return this.birthDate;
    }

    public void setBirthDate(final Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getBirthForeignInformation() {
        return this.birthForeignInformation;
    }

    public void setBirthForeignInformation(final String birthForeignInformation) {
        this.birthForeignInformation = birthForeignInformation;
    }

    public String getBirthCap() {
        return this.birthCap;
    }

    public void setBirthCap(final String birthCap) {
        this.birthCap = birthCap;
    }

    public String getLivingCap() {
        return this.livingCap;
    }

    public void setLivingCap(final String livingCap) {
        this.livingCap = livingCap;
    }

    public String getLivingAddress() {
        return this.livingAddress;
    }

    public void setLivingAddress(final String livingAddress) {
        this.livingAddress = livingAddress;
    }

    public Date getDeathDate() {
        return deathDate;
    }

    public void setDeathDate(final Date deathDate) {
        this.deathDate = deathDate;
    }

    @Override
    public int compareTo(final Patient o) {
        return surname.compareTo(o.getSurname());
    }
}
