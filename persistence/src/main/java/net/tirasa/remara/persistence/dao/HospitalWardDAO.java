package net.tirasa.remara.persistence.dao;

import java.util.List;
import net.tirasa.remara.persistence.data.HospitalWard;

public interface HospitalWardDAO {

    public HospitalWard saveOrUpdate(HospitalWard hospitalWard);

    public HospitalWard get(Long id);

    public List<HospitalWard> findAll();

    public List<HospitalWard> findHWForHospitalId(final long id);

    public List<HospitalWard> findByProperty(String propertyName, Object value, String fieldOrder);

    public List<HospitalWard> findByProperty(String propertyName, Object value);

    public List<HospitalWard> findHWByProperty(String propertyName, Object value, String fieldOrder);

    public void delete(HospitalWard hospitalWard);

    public int deleteByProperty(String propertyName, Object value);
}
