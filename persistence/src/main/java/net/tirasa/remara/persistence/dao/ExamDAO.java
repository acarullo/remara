package net.tirasa.remara.persistence.dao;

import java.util.List;
import net.tirasa.remara.persistence.data.Exam;

public interface ExamDAO {

    public Exam saveOrUpdate(Exam exam);

    public Exam get(Long id);

    public List<Exam> findByProperty(String propertyName, String value);

    public List<Exam> findByProperty(String propertyName, Object value);

    public int deleteByProperty(String propertyName, Object value);
}
