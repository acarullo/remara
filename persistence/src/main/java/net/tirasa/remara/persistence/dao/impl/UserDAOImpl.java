package net.tirasa.remara.persistence.dao.impl;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.UserDAO;
import net.tirasa.remara.persistence.data.User;
import org.apache.openjpa.persistence.PersistenceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class UserDAOImpl extends DAOImpl implements UserDAO {

    private static final Logger LOG = LoggerFactory.getLogger(UserDAOImpl.class);

    @Override
    @Transactional
    public User saveOrUpdate(final User user) {
        LOG.debug("saving user on ReMaRa database: {}", user.getUsername());
        return entityManager.merge(user);
    }

    @Override
    public User getS(final String username) {
        LOG.debug("searching for user on ReMaRa database: {}", username);
        TypedQuery<User> query = entityManager.createQuery("SELECT e FROM " + User.class.getSimpleName()
                + " e " + "WHERE " + "(UPPER(e.username) like :username OR LOWER(e.username) like :username)",
                User.class);
        query.setParameter("username", username);
        User result = null;
        try {
            result = query.getSingleResult();
        } catch (NoResultException e) {
            LOG.debug("No user found with username {}", username, e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<User> findByProperty(final String propertyName, final String value) {
        LOG.debug("searching for user(s) with property {} = {}", propertyName, value);
        TypedQuery<User> query = entityManager.createQuery("SELECT e FROM " + User.class.getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + " = :value", User.class);
        query.setParameter("value", value);
        List<User> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No user found with property {}, {}", propertyName, value, e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<User> findByProperty(final String propertyName, final Object value) {
        LOG.debug("searching for user(s) with property {} = {}", propertyName, value);
        TypedQuery<User> query = entityManager.createQuery("SELECT e FROM " + User.class.getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + " = :value", User.class);
        query.setParameter("value", value);
        List<User> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No user found with property {}, {}", propertyName, value, e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<User> findAll() {
        LOG.debug("searching for all users on ReMaRa database");
        TypedQuery<User> query = entityManager.createQuery("SELECT e FROM " + User.class.getSimpleName() + " e ",
                User.class);
        List<User> result = new ArrayList<>();
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
        LOG.debug("deleting user by property {} with value {} from database", propertyName, value);
//        TypedQuery<User> query = entityManager.createQuery("delete " + User.class.getSimpleName()
//                + " as model where model." + propertyName + "= " + value, User.class);
//        return query.getResultList().size();
        int removed = 0;
        List<User> foundByProp = findByProperty(propertyName, value);
        if (foundByProp.size() > 1) {
            LOG.warn("Deleting more than one user!");
            for (User user : findByProperty(propertyName, value)) {
                LOG.debug("removing user: {}", user.getUsername());
                entityManager.remove(user);
                removed++;
            }
        } else if (foundByProp.isEmpty()) {
            LOG.warn("empty result, there are no users to delete");
        } else {
            LOG.debug("removing the only user in list: {}", foundByProp.get(0).getUsername());
            entityManager.remove(foundByProp.get(0));
            removed = 1;
        }
        return removed;
    }
}
