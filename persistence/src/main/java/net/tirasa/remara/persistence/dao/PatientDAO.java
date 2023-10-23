package net.tirasa.remara.persistence.dao;

import java.util.Iterator;
import java.util.List;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.data.Patient;

public interface PatientDAO {

    public Patient saveOrUpdate(Patient patient);

    public Patient get(Long id);

    public List<Patient> findByProperty(String propertyName, String value);

    public List<Patient> findByProperty(String propertyName, Object value);

    public List<Patient> findAll();

    public List<Patient> findByCfOrSurname(String code);

    public List<Patient> findByYearInterval(String startYear, String endYear);

    public int deleteByProperty(String propertyName, Object value);

    public TypedQuery<Patient> createQuery(String sql);

    public Iterator<? extends Patient> executeQuery(TypedQuery<Patient> query);

    public Object executeQueryUnique(Query query);

    public Query createCountQuery(String sql);

    public int count();

    public List<Patient> findAdultPatients();

    public List<Patient> findMinorPatients();

    public List<Patient> findByNameAndSurname(String name, String surname);
}
