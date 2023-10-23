package net.tirasa.remara.persistence.dao.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.IllnessDAO;
import net.tirasa.remara.persistence.data.Illness;
import net.tirasa.remara.persistence.data.User;
import org.apache.openjpa.persistence.PersistenceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class IllnessDAOImpl extends DAOImpl implements IllnessDAO {

    private static final Logger LOG = LoggerFactory.getLogger(IllnessDAOImpl.class);

    @Override
    public Illness get(final Long illnessId) {
        LOG.debug("searching for illness {}", illnessId);
        return entityManager.find(Illness.class, illnessId);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Illness> findAll() {
        LOG.debug("searching for all illnesses on ReMaRa database");
        TypedQuery<Illness> query = entityManager.createQuery("SELECT e FROM " + Illness.class.getSimpleName() + " e ",
                Illness.class);
        List<Illness> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.error("Empty table " + User.class.getSimpleName() + " " + e);
        } catch (PersistenceException pe) {
            LOG.error("Persistence exception " + User.class.getSimpleName() + " " + pe.getCause().getCause());
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Illness> findByProperty(final String propertyName, final String value) {
        LOG.debug("searching for illness(es) with property {} = {}", propertyName, value);
        TypedQuery<Illness> query = entityManager.createQuery("SELECT e FROM " + Illness.class.getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + "= :value", Illness.class);
        query.setParameter("value", value);
        List<Illness> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No user found with property {}, {}", propertyName, value, e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Illness> findByProperty(final String propertyName, final Object value) {
        LOG.debug("searching for illness(es) with property {} = {}", propertyName, value);
        TypedQuery<Illness> query = entityManager.createQuery("SELECT e FROM " + Illness.class.getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + " = :value", Illness.class);
        query.setParameter("value", value);
        List<Illness> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No illness found with property {}, {}", propertyName, value, e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Illness> findByCode(final String code, final int maxResults) {
        LOG.debug("searching for illness(es) with code = {}, max results {}", code, maxResults);
        TypedQuery<Illness> query = entityManager.createQuery("SELECT e FROM " + Illness.class.getSimpleName()
                + " e " + "WHERE " + "(UPPER(e.code) like" + " :value1" + " OR UPPER(e.description) like" + " :value2"
                + " OR UPPER(e.exempt) like" + " :value3" + ") ORDER BY e.code", Illness.class);
        query.setParameter("value1", code.toUpperCase() + "%");
        query.setParameter("value2", code.toUpperCase() + "%");
        query.setParameter("value3", code.toUpperCase() + "%");
        query.setMaxResults(maxResults);
        List<Illness> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No illness found with code {}, max results {}", code, maxResults, e);
        }
        return result;
    }

    @Override
    @Transactional
    public int deleteByProperty(final String propertyName, final Object value) {
        LOG.debug("deleting illness by property {} with value {} from database", propertyName, value);
//        TypedQuery<Illness> query = entityManager.createQuery("delete " + Illness.class.getSimpleName()
//                + " as model where model." + propertyName + "= " + value, Illness.class);
//        return query.getResultList().size();
        int removed = 0;
        List<Illness> foundByProp = findByProperty(propertyName, value);
        if (foundByProp.size() > 1) {
            LOG.warn("Deleting more than one user!");
            for (Illness illness : findByProperty(propertyName, value)) {
                LOG.debug("removing user: {}", illness.getId());
                entityManager.remove(illness);
                removed++;
            }
        } else if (foundByProp.isEmpty()) {
            LOG.warn("empty result, there are no illnesses to delete");
        } else {
            LOG.debug("removing the only illness in list: {}", foundByProp.get(0).getId());
            entityManager.remove(foundByProp.get(0));
            removed = 1;
        }
        return removed;
    }

    @Override
    @Transactional
    public Illness saveOrUpdate(final Illness illness) {
        LOG.debug("saving illness on ReMaRa database: {}", illness.getId());
        return entityManager.merge(illness);
    }

    @Override
    public TypedQuery<Integer> createCountQuery(String sql) {
        LOG.debug("creating count query for illness from sql: {}", sql);
        return entityManager.createQuery(sql, Integer.class);
    }

    @Override
    public List<Illness> executeQuery(TypedQuery<Illness> query) {
        LOG.debug("executing query: {} and returning list of illnesses", query.toString());
        return query.getResultList();
    }

    @Override
    public Object executeQueryUnique(TypedQuery<Integer> query) {
        LOG.debug("executing unique (single) query: {}", query.toString());
        return query.getSingleResult();
    }

    @Override
    public TypedQuery<Illness> createQuery(String sql) {
        LOG.debug("creating query for illness from sql: {}", sql);
        return entityManager.createQuery(sql, Illness.class);
    }

    @Override
    public List<Long> executeQueryIllnessId(TypedQuery<Long> query) {
        LOG.debug("executing query: {} and returning iterator", query.toString());
        return query.getResultList();
    }

    @Override
    public TypedQuery<Long> createQueryIllnessId(String sql) {
        LOG.debug("creating query for medicine case from sql: {}", sql);
        return entityManager.createQuery(sql, Long.class);
    }
}
