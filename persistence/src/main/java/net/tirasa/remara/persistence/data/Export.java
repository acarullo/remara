package net.tirasa.remara.persistence.data;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;

@Entity
@Table(name = "export")
@SequenceGenerator(name = "export_seq", sequenceName = "exp_seq", initialValue = 10, allocationSize = 1)
public class Export implements Serializable, Comparable<Export> {

    private static final long serialVersionUID = -4412514631999945935L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "export_seq")
    private Long id;

    @Column(length = 100)
    private String comment;

    @Column(length = 13)
    @Temporal(javax.persistence.TemporalType.DATE)
    Date exportdate;

    public Long getId() {
        return this.id;
    }

    public void setId(final Long id) {
        this.id = id;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(final String comment) {
        this.comment = comment;
    }

    public Date getExportdate() {
        return exportdate;
    }

    public void setExportdate(final Date exportdate) {
        this.exportdate = exportdate;
    }

    @Override
    public int compareTo(final Export o) {
        return exportdate.compareTo(o.getExportdate());
    }
}
