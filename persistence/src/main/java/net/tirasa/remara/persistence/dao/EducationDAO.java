package net.tirasa.remara.persistence.dao;

import java.util.List;
import net.tirasa.remara.persistence.data.Education;

public interface EducationDAO {

    public Education saveOrUpdate(Education education);

    public List<Education> findAll(String fieldOrder);

    public Education get(Long id);
}
