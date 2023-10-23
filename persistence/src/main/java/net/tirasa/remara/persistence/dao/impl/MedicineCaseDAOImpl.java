package net.tirasa.remara.persistence.dao.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.MedicineCaseDAO;
import net.tirasa.remara.persistence.data.MedicineCase;
import net.tirasa.remara.persistence.utilities.Constants;
import net.tirasa.remara.persistence.utilities.JasyptMethods;
import org.apache.openjpa.persistence.PersistenceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class MedicineCaseDAOImpl extends DAOImpl implements MedicineCaseDAO {

    private static final Logger LOG = LoggerFactory.getLogger(MedicineCaseDAOImpl.class);

    private final JasyptMethods jasyptMethods = JasyptMethods.getJasyptMethods();

    private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    @Transactional
    public MedicineCase saveOrUpdate(final MedicineCase medicineCase) {
        LOG.debug("saving medicine case on ReMaRa database: {}", medicineCase.toString());
        return entityManager.merge(medicineCase);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<MedicineCase> findByProperty(final String propertyName, final String value) {
        LOG.debug("searching for medicine case(s) with property {} = {}", propertyName, value);
        TypedQuery<MedicineCase> query = entityManager.createQuery("SELECT e FROM " + MedicineCase.class.getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + "= :value", MedicineCase.class);
        query.setParameter("value", value);
        List<MedicineCase> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No medicine case found with property {}, {}", propertyName, value, e);
        }
        return result;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<MedicineCase> findByProperty(final String propertyName, final Object value) {
        LOG.debug("searching for medicine case(s) with property {} = {}", propertyName, value);
        TypedQuery<MedicineCase> query = entityManager.createQuery("SELECT e FROM " + MedicineCase.class.getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + " = :value", MedicineCase.class);
        query.setParameter("value", value);
        List<MedicineCase> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No medicine case found with property {}, {}", propertyName, value, e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<MedicineCase> findAll() {
        LOG.debug("searching for all medicine cases on ReMaRa database");
        TypedQuery<MedicineCase> query = entityManager.createQuery("SELECT e FROM " + MedicineCase.class.getSimpleName()
                + " e ", MedicineCase.class);
        List<MedicineCase> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.error("Empty table " + MedicineCase.class.getSimpleName() + " " + e);
        } catch (PersistenceException pe) {
            LOG.error("Persistence exception " + MedicineCase.class.getSimpleName() + " " + pe.getCause().getCause());
        }
        return result;
    }

    @Override
    @Transactional
    public int deleteByProperty(final String propertyName, final Object value) {
        LOG.debug("deleting medicine case by property {} with value {} from database", propertyName, value);
        int removed = 0;
        List<MedicineCase> foundByProp = findByProperty(propertyName, value);
        if (foundByProp.size() > 1) {
            LOG.warn("Deleting more than one medicine case!");
            for (MedicineCase medicineCase : findByProperty(propertyName, value)) {
                LOG.debug("removing medicine case: {}", medicineCase.getId());
                entityManager.remove(medicineCase);
                removed++;
            }
        } else if (foundByProp.isEmpty()) {
            LOG.warn("empty result, there are no medicine cases to delete");
        } else {
            LOG.debug("removing the only medicine case in list: {}", foundByProp.get(0).getId());
            entityManager.remove(foundByProp.get(0));
            removed = 1;
        }
        return removed;
    }

    @Override
    public List<MedicineCase> getCaseAssigned() {
        LOG.debug("listing medicine cases assigned");
        TypedQuery<MedicineCase> query = entityManager.createQuery("SELECT e FROM " + MedicineCase.class.getSimpleName()
                + " e " + " WHERE e.referent is not null "
                + "   AND e.statusWorkflow <> :statusQueued "
                + "   AND e.statusWorkflow <> :statusApproved "
                + "   AND e.statusWorkflow <> :statusRejected "
                + " ORDER BY e.insertDate ", MedicineCase.class);
        query.setParameter("statusQueued", Constants.STATUS_QUEUED);
        query.setParameter("statusApproved", Constants.STATUS_APPROVED);
        query.setParameter("statusRejected", Constants.STATUS_REJECTED);
        List<MedicineCase> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No medicine case assigned found", e);
        }
        return result;
    }

    @Override
    public List<MedicineCase> getRequestModifier(final String username) {
        LOG.debug("listing medicine cases with request modifier");
        TypedQuery<MedicineCase> query = entityManager.createQuery("SELECT e FROM " + MedicineCase.class.getSimpleName()
                + " e " + " WHERE e.referent = :referent "
                + " AND e.statusWorkflow = :status "
                + " AND e.reason IS NOT NULL "
                + " ORDER BY e.insertDate ", MedicineCase.class);
        query.setParameter("referent", username);
        query.setParameter("status", Constants.STATUS_UNDERWAY);
        List<MedicineCase> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No medicine case with request modifier assigned found", e);
        }
        return result;
    }

    @Override
    public List<MedicineCase> getForWaitConfirm(final String username) {
        LOG.debug("listing medicine cases waiting for confirm");
        TypedQuery<MedicineCase> query = entityManager.createQuery("SELECT e FROM " + MedicineCase.class.getSimpleName()
                + " e " + " WHERE e.owner = :owner "
                + " AND ( e.statusWorkflow = :status1 OR e.statusWorkflow = :status2 ) "
                + " ORDER BY e.insertDate ", MedicineCase.class);
        query.setParameter("owner", username);
        query.setParameter("status1", Constants.STATUS_QUEUED);
        query.setParameter("status2", Constants.STATUS_ASSIGNED);
        List<MedicineCase> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No medicine cases waiting for confirm found", e);
        }
        return result;
    }

    @Override
    public List<MedicineCase> findForExport(final Date from, final Date to) {
        LOG.debug("listing medicine cases waiting for export");
        TypedQuery<MedicineCase> query = entityManager.createQuery("SELECT e FROM " + MedicineCase.class.getSimpleName()
                + " e " + " WHERE e.spedDate IS NULL "
                + " AND e.statusWorkflow = :statusWorkflow "
                + " AND e.insertDate >= :insertDateDa "
                + " AND e.insertDate <= :insertDateA "
                + " AND e.illness.marche = false "
                + " ORDER BY e.patient.id ", MedicineCase.class);
        query.setParameter("statusWorkflow", Constants.STATUS_APPROVED);
        query.setParameter("insertDateDa", from);
        query.setParameter("insertDateA", to);
        List<MedicineCase> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No medicine cases waiting for export found", e);
        }
        return result;
    }

    @Override
    public List<MedicineCase> findByPatientAndIllness(final String taxCode, final Long illnessId) {
        LOG.debug("searching for medicine case(s)by patient and illness");
        TypedQuery<MedicineCase> query = entityManager.createQuery("SELECT e FROM " + MedicineCase.class.
                getSimpleName()
                + " e " + "where e.patient.taxCode= :taxCode AND e.illness.id= :illnessId", MedicineCase.class);
        query.setParameter("taxCode", taxCode);
        query.setParameter("illnessId", illnessId);
        List<MedicineCase> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No medicine cases found by illness and patient", e.getCause());
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<MedicineCase> findByCfOrSurname(final String value, final String owner, final String referent) {
        LOG.debug("searching for medicine case(s) with patient with CF or surname {}, owner {}, referent {}", value,
                owner, referent);
        TypedQuery<MedicineCase> query;
        if ("XOWNERX".equals(owner) && "XREFERENTX".equals(referent)) {
            query = entityManager.createQuery("SELECT e FROM " + MedicineCase.class.
                    getSimpleName()
                    + " e " + "WHERE "
                    + "(e.patient.surname= :value1 OR e.patient.taxCode=:value)",
                    MedicineCase.class);
        } else {
            query = entityManager.createQuery("SELECT e FROM " + MedicineCase.class.getSimpleName()
                    + " e " + "WHERE "
                    + "(e.patient.surname= :value1 OR e.patient.taxCode=:value) AND (e.owner = :owner OR e.referent = :referent)",
                    MedicineCase.class);
            query.setParameter("owner", owner);
            query.setParameter("referent", referent);
        }
        query.setParameter("value1", value.toUpperCase().substring(0, 2) + "-" + jasyptMethods.encrypt(value.
                toUpperCase()));
        query.setParameter("value", jasyptMethods.encrypt(value));
        List<MedicineCase> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (PersistenceException | NoResultException e) {
            LOG.debug("No medicine case found with patient with CF or surname {} ", value, e.getCause());
        }
        return result;
    }

    @Override
    public MedicineCase get(final Long id) {
        LOG.debug("get medicine case by id: " + id);
        TypedQuery<MedicineCase> query = entityManager.createQuery("SELECT e FROM " + MedicineCase.class.getSimpleName()
                + " e " + "WHERE " + "e.id= :value", MedicineCase.class);
        query.setParameter("value", id);
        MedicineCase result = null;
        try {
            result = query.getSingleResult();
        } catch (NoResultException e) {
            LOG.error("No medicine case found with id: {}", id, e);
        }
        return result;
    }

    @Override
    public TypedQuery<MedicineCase> createQuery(String sql) {
        LOG.debug("creating query for medicine case from sql: {}", sql);
        return entityManager.createQuery(sql, MedicineCase.class);
    }

    @Override
    public TypedQuery<Long> createQueryMCId(String sql) {
        LOG.debug("creating query for medicine case from sql: {}", sql);
        return entityManager.createQuery(sql, Long.class);
    }

    @Override
    public Iterator<? extends MedicineCase> executeQuery(TypedQuery<MedicineCase> query) {
        LOG.debug("executing query: {} and returning iterator", query.toString());
        return query.getResultList().iterator();
    }

    @Override
    public List<Long> executeQueryMCId(TypedQuery<Long> query) {
        LOG.debug("executing query: {} and returning iterator", query.toString());
        return query.getResultList();
    }

    @Override
    public Object executeQueryUnique(TypedQuery<Integer> query) {
        LOG.debug("executing unique (single) query: {}", query.toString());
        return query.getSingleResult();
    }

    @Override
    public TypedQuery<Integer> createCountQuery(String sql) {
        LOG.debug("creating count query for medicine case from sql: {}", sql);
        return entityManager.createQuery(sql, Integer.class);
    }

    @Override
    public int count() {
        String query = "SELECT COUNT(m) FROM " + MedicineCase.class.getSimpleName() + " m";
        TypedQuery<Long> tQuery = entityManager.createQuery(query, Long.class);
        return tQuery.getSingleResult().intValue();
    }

    @Override
    public int countWithStatus(final String status) {
        String query = "SELECT COUNT(m) FROM " + MedicineCase.class.getSimpleName()
                + " m WHERE m.statusWorkflow=:statusWorkflow";
        TypedQuery<Long> tQuery = entityManager.createQuery(query, Long.class);
        tQuery.setParameter("statusWorkflow", status);
        return tQuery.getSingleResult().intValue();
    }

    @Override
    public List<MedicineCase> findExPP() {
        String query = "SELECT m FROM " + MedicineCase.class.getSimpleName() + " m WHERE m.exPp=:exPp";
        TypedQuery<MedicineCase> tQuery = entityManager.createQuery(query, MedicineCase.class);
        tQuery.setParameter("statusWorkflow", true);
        return tQuery.getResultList();
    }

    @Override
    public int countExPP() {
        String query = "SELECT COUNT(m) FROM " + MedicineCase.class.getSimpleName() + " m WHERE m.exPp=:exPp";
        TypedQuery<Long> tQuery = entityManager.createQuery(query, Long.class);
        tQuery.setParameter("exPp", true);
        return tQuery.getSingleResult().intValue();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<MedicineCase> findByReferentOrOwner(String owner, String referent) {
        LOG.debug("searching for medicine case(s) with patient with owner {}, referent {}", owner, referent);
        TypedQuery<MedicineCase> query;
        query = entityManager.createQuery("SELECT e FROM " + MedicineCase.class.getSimpleName()
                + " e "
                + "WHERE (e.owner = :owner AND e.owner <> 'XOWNERX') OR (e.referent = :referent AND e.referent <> 'XREFERENT')",
                MedicineCase.class);
        query.setParameter("owner", owner);
        query.setParameter("referent", referent);
        List<MedicineCase> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (PersistenceException | NoResultException e) {
            LOG.debug("No medicine case found with patient with owner {}, referent {} ", owner, referent, e.getCause());
        }
        return result;
    }

    @Override
    public List<MedicineCase> findByYearInterval(String startYear, String endYear) {
        List<MedicineCase> result = new ArrayList<>();
        try {
            LOG.debug("searching for medicine case(s) with patient with birth date in interval {} - {}", startYear,
                    endYear);
            TypedQuery<MedicineCase> query = entityManager.createQuery("SELECT e FROM " + MedicineCase.class.
                    getSimpleName()
                    + " e " + "WHERE " + "(e.patient.birthDate >= :startYear AND e.patient.birthDate <= :endYear)",
                    MedicineCase.class);
            query.setParameter("startYear", dateFormat.parse(startYear + "-01-01")); // YYYY-MM-DD
            query.setParameter("endYear", dateFormat.parse(endYear + "-12-31")); // YYYY-MM-DD
            result = query.getResultList();
        } catch (ParseException | PersistenceException | NoResultException e) {
            LOG.debug("No medicine case found with patient with birth date in interval {} - {}", startYear, endYear, e.
                    getCause());
        }
        return result;
    }
}
