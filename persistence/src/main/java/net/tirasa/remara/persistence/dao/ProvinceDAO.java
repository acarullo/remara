package net.tirasa.remara.persistence.dao;

import java.util.List;
import net.tirasa.remara.persistence.data.Province;

public interface ProvinceDAO {

    public Province saveOrUpdate(Province province);

    public List<Province> findByProperty(String propertyName, Object value, String fieldOrder);

    public Province get(String id);
}
