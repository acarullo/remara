package net.tirasa.remara.persistence.data;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import net.tirasa.remara.persistence.utilities.JasyptMethods;

@Entity
@Table(name = "file_case")
@SequenceGenerator(name = "fileCase_seq", sequenceName = "fc_seq", initialValue = 55000, allocationSize = 1)
public class FileCase implements Serializable {

    private static final long serialVersionUID = -7522401798113804664L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "fileCase_seq")
    private Long id;

    @Column(name = "exam", nullable = false)
    @ManyToOne
    private Exam exam;

    @Column(length = 255, nullable = false)
    private String name;

    @Column(nullable = false)
    private byte[] file;

    public Long getId() {
        return this.id;
    }

    public void setId(final Long id) {
        this.id = id;
    }

    public Exam getExam() {
        return this.exam;
    }

    public void setExam(final Exam exam) {
        this.exam = exam;
    }

    public byte[] getFile() {
        final JasyptMethods jasyptMethods = JasyptMethods.getJasyptMethods();
        return jasyptMethods.bdecrypt(file);
    }

    public void setFile(final byte[] file) {
        final JasyptMethods jasyptMethods = JasyptMethods.getJasyptMethods();
        this.file = jasyptMethods.bencrypt(file);
    }

    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }
}
