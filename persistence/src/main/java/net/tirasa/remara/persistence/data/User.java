package net.tirasa.remara.persistence.data;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import net.tirasa.remara.persistence.utilities.JasyptMethods;

@Entity
@Table(name = "\"user\"")
public class User implements Serializable {

    private static final long serialVersionUID = -411189220192752562L;

    @Id
    @Column
    private String username;

    @Column(length = 255, nullable = false)
    private String password;

    @Column(length = 200)
    private String name;

    @Column(length = 200)
    private String surname;

    @Column(length = 200)
    private String email;

    @Column(name = "role", nullable = false)
    @ManyToOne
    private Role role;

    @Column
    private Boolean pediatrician;

    @Column(name = "hospital")
    private String hospitalOrganization;

    @Column(name = "ward")
    private String hospitalWard;

    @Column(length = 100)
    private String phone;

    @Column(length = 100)
    private String fax;

    @Column(length = 200)
    private String address;

    public String getUsername() {
        return this.username;
    }

    public void setUsername(final String username) {
        this.username = username;
    }

    public String getPassword() {
        final JasyptMethods jasyptMethods = JasyptMethods.getJasyptMethods();
        return jasyptMethods.decrypt(this.password);
    }

    public void setPassword(final String password) {
        final JasyptMethods jasyptMethods = JasyptMethods.getJasyptMethods();
        this.password = jasyptMethods.encrypt(password);
    }

    public String getName() {
        return this.name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public String getSurname() {
        return this.surname;
    }

    public void setSurname(final String surname) {
        this.surname = surname;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(final String email) {
        this.email = email;
    }

    public Role getRole() {
        return this.role;
    }

    public void setRole(final Role role) {
        this.role = role;
    }

    public Boolean getPediatrician() {
        return pediatrician;
    }

    public void setPediatrician(final Boolean pediatrician) {
        this.pediatrician = pediatrician;
    }

    public String getHospitalOrganization() {
        return hospitalOrganization;
    }

    public void setHospitalOrganization(final String hospitalOrganization) {
        this.hospitalOrganization = hospitalOrganization;
    }

    public String getHospitalWard() {
        return hospitalWard;
    }

    public void setHospitalWard(final String hospitalWard) {
        this.hospitalWard = hospitalWard;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(final String address) {
        this.address = address;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(final String fax) {
        this.fax = fax;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(final String phone) {
        this.phone = phone;
    }

    public boolean isEmpty() {
        return getUsername().isEmpty();
    }
}
