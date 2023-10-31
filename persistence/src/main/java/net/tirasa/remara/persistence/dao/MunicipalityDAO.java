package net.tirasa.remara.persistence.dao;

import java.util.List;
import net.tirasa.remara.persistence.data.Municipality;

public interface MunicipalityDAO {

    Municipality saveOrUpdate(Municipality municipality);

    List<Municipality> findByProperty(String propertyName, Object value, String fieldOrder);

    Municipality get(Long id);

    void deleteByProperty(final Long id);
}