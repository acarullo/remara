package net.tirasa.remara.persistence.dao;

import java.util.List;
import net.tirasa.remara.persistence.data.FileCase;

public interface FileCaseDAO {

    public FileCase saveOrUpdate(FileCase fileCase);

    public FileCase get(Long id);

    public List<FileCase> findByProperty(String propertyName, String value);

    public List<FileCase> findByProperty(String propertyName, Object value);

    public int deleteByProperty(String propertyName, Object value);

    public void delete(FileCase fileCase);
}
