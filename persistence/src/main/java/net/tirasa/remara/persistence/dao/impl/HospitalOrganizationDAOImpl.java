package net.tirasa.remara.persistence.dao.impl;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.HospitalOrganizationDAO;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import net.tirasa.remara.persistence.data.Region;
import org.apache.openjpa.persistence.PersistenceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class HospitalOrganizationDAOImpl extends DAOImpl implements HospitalOrganizationDAO {

    private static final Logger LOG = LoggerFactory.getLogger(HospitalOrganizationDAOImpl.class);

    @Override
    @Transactional
    public HospitalOrganization saveOrUpdate(final HospitalOrganization hospitalOrganization) {
        LOG.debug("saving hospital organization on ReMaRa database: {}", hospitalOrganization.getName() + " "
                + " " + hospitalOrganization.getId());
        return entityManager.merge(hospitalOrganization);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<HospitalOrganization> findAll() {
        LOG.debug("searching for all hospital organizations on ReMaRa database");
        TypedQuery<HospitalOrganization> query = entityManager.createQuery("SELECT e FROM "
                + HospitalOrganization.class.getSimpleName() + " e ORDER BY e.name", HospitalOrganization.class);
        List<HospitalOrganization> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.error("Empty table " + HospitalOrganization.class.getSimpleName() + " " + e);
        } catch (PersistenceException pe) {
            LOG.error("Persistence exception " + HospitalOrganization.class.getSimpleName() + " " + pe);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<HospitalOrganization> findByProperty(final String propertyName, final Object value,
            final String fieldOrder) {
        LOG.debug("searching for hospital organization(s) with property {} = {}", propertyName, value);
        TypedQuery<HospitalOrganization> query = entityManager.createQuery("SELECT e FROM "
                + HospitalOrganization.class.getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + " = :value" + " ORDER BY e." + fieldOrder,
                HospitalOrganization.class);
        query.setParameter("value", value);
        List<HospitalOrganization> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No hospital organization found with property {}, {}", propertyName, value, e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<HospitalOrganization> findByProperty(final String propertyName, final String value) {
        LOG.debug("searching for hospital organization(s) with property {} = {}", propertyName, value);
        TypedQuery<HospitalOrganization> query = entityManager.createQuery("SELECT e FROM "
                + HospitalOrganization.class.getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + " = :value", HospitalOrganization.class);
        query.setParameter("value", value);
        List<HospitalOrganization> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No hospital organization found with property {}, {}", propertyName, value, e);
        }
        return result;
    }

    @Override
    public List<Region> getRegions() {
        LOG.debug("listing regions for hospital organizations");
        TypedQuery<Region> query = entityManager.createQuery("SELECT DISTINCT(e.region) FROM "
                + HospitalOrganization.class.getSimpleName()
                + " e ", Region.class);
        List<Region> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No region found ion hospital organization", e);
        }
        return result;
    }

    @Override
    public HospitalOrganization get(final Long id) {
        LOG.debug("get hospital organization by id: " + id);
        TypedQuery<HospitalOrganization> query = entityManager.createQuery("SELECT e FROM "
                + HospitalOrganization.class.getSimpleName() + " e " + "WHERE " + "e.id= :value",
                HospitalOrganization.class);
        query.setParameter("value", id);
        HospitalOrganization result = null;
        try {
            result = query.getSingleResult();
        } catch (NoResultException e) {
            LOG.debug("No hospital organization found with property {}, {}", "id", id, e);
        }
        return result;
    }

    @Override
    @Transactional
    public void delete(HospitalOrganization hospitalOrganization) {
        LOG.debug("removing hospital organization: {}, id {}", hospitalOrganization.getName(), hospitalOrganization.
                getId());
//        Query query = entityManager.
//                createQuery("DELETE FROM " + HospitalOrganization.class.getSimpleName() + " h WHERE h.id = :ho_id");
//        query.setParameter("ho_id", hospitalOrganization.getId()).executeUpdate();
        entityManager.remove(this.get(hospitalOrganization.getId()));
//        entityManager.remove(hospitalOrganization);
    }

    @Override
    @Transactional
    public int deleteByProperty(final String propertyName, final Object value) {
        LOG.debug("deleting hospital organization by property {} with value {} from database", propertyName, value);
//        TypedQuery<User> query = entityManager.createQuery("delete " + User.class.getSimpleName()
//                + " as model where model." + propertyName + "= " + value, User.class);
//        return query.getResultList().size();
        int removed = 0;
        List<HospitalOrganization> foundByProp = findByProperty(propertyName, value, "name");
        if (foundByProp.size() > 1) {
            LOG.warn("Deleting more than one hospital ward!");
            for (HospitalOrganization hospitalOrganization : findByProperty(propertyName, value, "name")) {
                LOG.debug("removing hospital ward: {}", hospitalOrganization.getName());
                entityManager.remove(hospitalOrganization);
                removed++;
            }
        } else if (foundByProp.isEmpty()) {
            LOG.warn("empty result, there are no hospital organizations to delete");
        } else {
            LOG.debug("removing the only hospital organization in list: {}", foundByProp.get(0).getName());
            entityManager.remove(foundByProp.get(0));
            removed = 1;
        }
        return removed;
    }
}
