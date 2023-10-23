package net.tirasa.remara.persistence.dao;

import java.util.List;
import net.tirasa.remara.persistence.data.Municipality;

public interface MunicipalityDAO {

    public Municipality saveOrUpdate(Municipality municipality);

    public List<Municipality> findByProperty(String propertyName, Object value, String fieldOrder);

    public Municipality get(Long id);
}
