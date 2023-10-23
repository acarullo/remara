package net.tirasa.remara.persistence.dao;

import java.util.List;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import net.tirasa.remara.persistence.data.Region;

public interface HospitalOrganizationDAO {

    public List<Region> getRegions();

    public HospitalOrganization get(Long id);

    public HospitalOrganization saveOrUpdate(HospitalOrganization hospitalOrganization);

    public List<HospitalOrganization> findAll();

    public List<HospitalOrganization> findByProperty(String propertyName, Object value, String fieldOrder);

    public List<HospitalOrganization> findByProperty(String propertyName, String value);

    public void delete(HospitalOrganization hospitalOrganization);

    public int deleteByProperty(String propertyName, Object value);
}
