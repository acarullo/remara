package net.tirasa.remara.persistence.dao.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.HospitalWardDAO;
import net.tirasa.remara.persistence.data.HospitalWard;
import org.apache.openjpa.persistence.PersistenceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class HospitalWardDAOImpl extends DAOImpl implements HospitalWardDAO {

    private static final Logger LOG = LoggerFactory.getLogger(HospitalWardDAOImpl.class);

    @Override
    @Transactional
    public HospitalWard saveOrUpdate(final HospitalWard hospitalWard) {
        LOG.debug("saving hospital ward on ReMaRa database: {}", hospitalWard.getName());
        return entityManager.merge(hospitalWard);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<HospitalWard> findAll() {
        LOG.debug("searching for all hospital wards on ReMaRa database");
        TypedQuery<HospitalWard> query = entityManager.createQuery("SELECT e FROM " + HospitalWard.class.getSimpleName()
                + " e ORDER BY e.name", HospitalWard.class);
        List<HospitalWard> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.error("Empty table " + HospitalWard.class.getSimpleName() + " " + e);
        } catch (PersistenceException pe) {
            LOG.error("Persistence exception " + HospitalWard.class.getSimpleName() + " " + pe.getCause());
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<HospitalWard> findByProperty(final String propertyName, final Object value, final String fieldOrder) {
        LOG.debug("searching for hospital ward(s) with property {} = {}", propertyName, value);
        TypedQuery<HospitalWard> query = entityManager.createQuery("SELECT e FROM " + HospitalWard.class.getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + " = :value" // e.HospitalOrganization= org AND org.
                + " ORDER BY e." + fieldOrder, HospitalWard.class);
        query.setParameter("value", value);
        List<HospitalWard> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No hospital ward found with property {}, {}", propertyName, value, e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<HospitalWard> findHWForHospitalId(final long id) {
        LOG.debug("searching for hospital ward(s) with hospital organization id {}", id);
        TypedQuery<HospitalWard> query = entityManager.createQuery("SELECT e FROM " + HospitalWard.class.getSimpleName()
                + " e WHERE e.hospitalOrganization.id=:value", HospitalWard.class);
        query.setParameter("value", id);
        List<HospitalWard> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No hospital ward found with id {},", id, e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<HospitalWard> findHWByProperty(final String propertyName, final Object value, final String fieldOrder) {
        LOG.debug("searching for hospital ward(s) with hospital organization property {} = {}", propertyName, value);
        TypedQuery<HospitalWard> query = entityManager.createQuery("SELECT e FROM " + HospitalWard.class.getSimpleName()
                + " e " + "WHERE " + "e.hospitalOrganization." + propertyName + " = :value"
                + " ORDER BY e." + fieldOrder, HospitalWard.class);
        query.setParameter("value", value);
        List<HospitalWard> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No hospital ward found with property {}, {} and hospital org", propertyName, value, e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<HospitalWard> findByProperty(final String propertyName, final Object value) {
        LOG.debug("searching for hospital ward(s) with property {} = {}", propertyName, value);
        TypedQuery<HospitalWard> query = entityManager.createQuery("SELECT e FROM " + HospitalWard.class.getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + " = :value", HospitalWard.class);
        query.setParameter("value", value);
        List<HospitalWard> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No hospital ward found with property {}, {}", propertyName, value, e);
        }
        return result;
    }

    @Override
    public HospitalWard get(final Long id) {
        LOG.debug("get hospital ward by id: " + id);
//        return entityManager.find(Exam.class, id);
        TypedQuery<HospitalWard> query = entityManager.createQuery("SELECT e FROM " + HospitalWard.class.getSimpleName()
                + " e " + "WHERE " + "e.id= :value", HospitalWard.class);
        query.setParameter("value", id);
        HospitalWard result = null;
        try {
            result = query.getSingleResult();
        } catch (NoResultException e) {
            LOG.error("No hospital ward found with property {}= {}", "id", id, e);
        }
        return result;
    }

    @Override
    @Transactional
    public void delete(HospitalWard hospitalWard) {
        LOG.debug("removing hospital ward: {}, id {}", hospitalWard.getName(), hospitalWard.getId());
        entityManager.remove(get(hospitalWard.getId()));
    }

    @Override
    @Transactional
    public int deleteByProperty(final String propertyName, final Object value) {
        LOG.debug("deleting hospital ward by property {} with value {} from database", propertyName, value);
//        TypedQuery<User> query = entityManager.createQuery("delete " + User.class.getSimpleName()
//                + " as model where model." + propertyName + "= " + value, User.class);
//        return query.getResultList().size();
        int removed = 0;
        List<HospitalWard> foundByProp = findByProperty(propertyName, value);
        if (foundByProp.size() > 1) {
            LOG.warn("Deleting more than one hospital ward!");
            for (HospitalWard hospitalWard : findByProperty(propertyName, value)) {
                LOG.debug("removing hospital ward: {}", hospitalWard.getName());
                entityManager.remove(hospitalWard);
                removed++;
            }
        } else if (foundByProp.isEmpty()) {
            LOG.warn("empty result, there are no hospital wards to delete");
        } else {
            LOG.debug("removing the only hospital ward in list: {}", foundByProp.get(0).getName());
            entityManager.remove(foundByProp.get(0));
            removed = 1;
        }
        return removed;
    }
}
