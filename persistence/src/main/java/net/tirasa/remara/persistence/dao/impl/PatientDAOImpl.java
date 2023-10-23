package net.tirasa.remara.persistence.dao.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.PatientDAO;
import net.tirasa.remara.persistence.data.Patient;
import net.tirasa.remara.persistence.data.User;
import net.tirasa.remara.persistence.utilities.JasyptMethods;
import org.apache.commons.lang.time.DateUtils;
import org.apache.openjpa.persistence.PersistenceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class PatientDAOImpl extends DAOImpl implements PatientDAO {

    private static final Logger LOG = LoggerFactory.getLogger(PatientDAOImpl.class);

    private final JasyptMethods jasyptMethods = JasyptMethods.getJasyptMethods();

    private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    @Transactional
    public Patient saveOrUpdate(final Patient patient) {
        LOG.debug("saving patient on ReMaRa database: {}", patient.getId());
        return entityManager.merge(patient);
    }

    @Override
    public Patient get(final Long id) {
        LOG.debug("searching for patient by id {}", id);
        return entityManager.find(Patient.class, id);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Patient> findByProperty(final String propertyName, final String value) {
        LOG.debug("searching for patient(s) with property {} = {}", propertyName, value);
        TypedQuery<Patient> query = entityManager.createQuery("SELECT e FROM " + Patient.class.getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + "= :value", Patient.class);
        query.setParameter("value", value);
        List<Patient> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (PersistenceException | NoResultException e) {
            LOG.debug("No patient found with property {} = {}", propertyName, value, e.getCause());
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Patient> findByCfOrSurname(final String value) {
        LOG.debug("searching for patient(s) with CF or surname {}", value);
        TypedQuery<Patient> query = entityManager.createQuery("SELECT e FROM " + Patient.class.getSimpleName()
                + " e " + "WHERE " + "e.surname= :value1 OR e.taxCode=:value ORDER BY e.surname", Patient.class);
        if (value.isEmpty()) {
            query.setParameter("value1", jasyptMethods.encrypt(value));
        } else {
            query.setParameter("value1", value.toUpperCase().substring(0, 2) + "-" + jasyptMethods.encrypt(value.
                    toUpperCase()));
        }
        query.setParameter("value", jasyptMethods.encrypt(value));
        List<Patient> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (PersistenceException | NoResultException e) {
            LOG.debug("No patient found with CF or surname {} ", value, e.getCause());
        }
        return result;
    }

    @Override
    public List<Patient> findByNameAndSurname(final String name, final String surname) {
        LOG.debug("searching for patient(s) with name {} and/or surname {}", name, surname);
        TypedQuery<Patient> query;
        if (!name.isEmpty() && !surname.isEmpty()) {
            query = entityManager.createQuery("SELECT e FROM " + Patient.class.getSimpleName()
                    + " e " + "WHERE "
                    + "(e.surname= :surname AND e.name=:name) ORDER BY e.surname",
                    Patient.class);
        } else {
            query = entityManager.createQuery("SELECT e FROM " + Patient.class.getSimpleName()
                    + " e " + "WHERE "
                    + "e.surname= :surname OR e.name=:name ORDER BY e.surname",
                    Patient.class);
        }
        if (surname.length() > 2) {
            query.setParameter("surname", surname.toUpperCase().substring(0, 2) + "-" + jasyptMethods.encrypt(surname.
                    toUpperCase()));
        } else {
            query.setParameter("surname", surname.toUpperCase() + "-" + jasyptMethods.encrypt(surname.toUpperCase()));
        }
        query.setParameter("name", jasyptMethods.encrypt(name.toUpperCase()));
        List<Patient> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (PersistenceException | NoResultException e) {
            LOG.debug("No patient found with name {} and/or surname {} ", name, surname, e.getCause());
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Patient> findByYearInterval(final String startYear, final String endYear) {
        List<Patient> result = new ArrayList<>();
        try {
            LOG.debug("searching for patient(s) with birth date in interval {} - {}", startYear, endYear);
            TypedQuery<Patient> query = entityManager.createQuery("SELECT e FROM " + Patient.class.getSimpleName()
                    + " e " + "WHERE " + "(e.birthDate >= :startYear AND e.birthDate <= :endYear)", Patient.class);
            query.setParameter("startYear", dateFormat.parse(startYear + "-01-01")); // YYYY-MM-DD
            query.setParameter("endYear", dateFormat.parse(endYear + "-12-31")); // YYYY-MM-DD
            result = query.getResultList();
        } catch (ParseException | PersistenceException | NoResultException e) {
            LOG.debug("No patient found with birth date in interval {} - {}", startYear, endYear, e.getCause());
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Patient> findByProperty(final String propertyName, final Object value) {
        LOG.debug("searching for patient(s) with property {} = {}", propertyName, value);
        TypedQuery<Patient> query = entityManager.createQuery("SELECT e FROM " + Patient.class.getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + " = :value", Patient.class);
        query.setParameter("value", value);
        List<Patient> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No patient found with property {}, {}", propertyName, value, e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Patient> findAll() {
        LOG.debug("searching for all patients on ReMaRa database");
        TypedQuery<Patient> query = entityManager.createQuery("SELECT e FROM " + Patient.class.getSimpleName()
                + " e ORDER BY e.surname",
                Patient.class);
        List<Patient> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.error("Empty table " + User.class.getSimpleName() + " " + e);
        } catch (PersistenceException pe) {
            LOG.error("Persistence exception " + User.class.getSimpleName() + " " + pe.getCause().getCause());
        }
        return result;
    }

    @Override
    @Transactional
    public int deleteByProperty(final String propertyName, final Object value) {
        LOG.debug("deleting patient by property {} with value {} from database", propertyName, value);
//        TypedQuery<Patient> query = entityManager.createQuery("delete " + Patient.class.getSimpleName()
//                + " as model where model." + propertyName + "= " + value, Patient.class);
//        return query.getResultList().size();
        int removed = 0;
        List<Patient> foundByProp = findByProperty(propertyName, value);
        if (foundByProp.size() > 1) {
            LOG.warn("Deleting more than one patient!");
            for (Patient patient : findByProperty(propertyName, value)) {
                LOG.debug("removing patient: {}", patient.getId());
                entityManager.remove(patient);
                removed++;
            }
        } else if (foundByProp.isEmpty()) {
            LOG.warn("empty result, there are no patients to delete");
        } else {
            LOG.debug("removing the only patient in list: {}", foundByProp.get(0).getId());
            entityManager.remove(foundByProp.get(0));
            removed = 1;
        }
        return removed;
    }

    @Override
    public TypedQuery<Patient> createQuery(String sql) {
        LOG.debug("creating query for patient from sql: {}", sql);
        return entityManager.createQuery(sql, Patient.class);
    }

    @Override
    public Iterator<? extends Patient> executeQuery(TypedQuery<Patient> query) {
        LOG.debug("executing query: {} and returning iterator", query.toString());
        return query.getResultList().iterator();
    }

    @Override
    public Object executeQueryUnique(Query query) {
        LOG.debug("executing unique (single) query: {}", query.toString());
        return query.getSingleResult();
    }

    @Override
    public Query createCountQuery(String sql) {
        LOG.debug("creating count query for patient from sql: {}", sql);
        return entityManager.createNativeQuery(sql, Integer.class);
    }

    @Override
    public int count() {
        String query = "SELECT COUNT(m) FROM " + Patient.class.getSimpleName() + " m";
        TypedQuery<Long> tQuery = entityManager.createQuery(query, Long.class);
        return tQuery.getSingleResult().intValue();
    }

    @Override
    public List<Patient> findAdultPatients() {
        LOG.debug("searching for adult patient(s): with age > 18 years (6574 days)");
        List<Patient> result = new ArrayList<>();
        try {
            TypedQuery<Patient> query = entityManager.createQuery("SELECT e FROM " + Patient.class.getSimpleName()
                    + " e WHERE e.birthDate <= :eighteenYearsAgo", Patient.class);
            query.setParameter("eighteenYearsAgo", dateFormat.parse(dateFormat.format(DateUtils.addYears(new Date(),
                    -18))));
            result = query.getResultList();
        } catch (ParseException | NoResultException e) {
            LOG.debug("No adult patients found ", e);
        }
        return result;
    }

    @Override
    public List<Patient> findMinorPatients() {
        LOG.debug("searching for underage patient(s): with age < 18 years (6574 days)");
        List<Patient> result = new ArrayList<>();
        try {
            TypedQuery<Patient> query = entityManager.createQuery("SELECT e FROM " + Patient.class.getSimpleName()
                    + " e WHERE e.birthDate > :eighteenYearsAgo", Patient.class);
            query.setParameter("eighteenYearsAgo", dateFormat.parse(dateFormat.format(DateUtils.addYears(new Date(),
                    -18))));
            result = query.getResultList();
        } catch (ParseException | NoResultException e) {
            LOG.debug("No underage patients found ", e);
        }
        return result;
    }
}
