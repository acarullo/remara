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
@Table(name = "role")
@SequenceGenerator(name = "remaraRole_seq", sequenceName = "role_seq", initialValue = 4, allocationSize = 1)
public class Role implements Serializable {

    @OneToMany(mappedBy = "role")
    private List<User> users;

    private static final long serialVersionUID = -559143465414129481L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "remaraRole_seq")
    private Long id;

    @Column(length = 100)
    private String description;

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
}
