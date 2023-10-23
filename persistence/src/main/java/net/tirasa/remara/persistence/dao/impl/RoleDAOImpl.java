package net.tirasa.remara.persistence.dao.impl;

import java.util.ArrayList;
import java.util.Collections;
import net.tirasa.remara.persistence.dao.RoleDAO;
import net.tirasa.remara.persistence.data.Role;
import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import org.apache.openjpa.persistence.PersistenceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class RoleDAOImpl extends DAOImpl implements RoleDAO {

    private static final Logger LOG = LoggerFactory.getLogger(RoleDAOImpl.class);

    @Override
    @Transactional
    public Role saveOrUpdate(final Role role) {
        LOG.debug("saving role on database: {}", role.getId());
        return entityManager.merge(role);
    }

    @Override
    public Role get(final Long roleId) {
        LOG.debug("get role by id: " + roleId);
//        return entityManager.find(Role.class, roleId);
        TypedQuery<Role> query = entityManager.createQuery("SELECT e FROM " + Role.class.getSimpleName()
                + " e " + "WHERE " + "e.id= :value", Role.class);
        query.setParameter("value", roleId);
        Role result = null;
        try {
            result = query.getSingleResult();
        } catch (NoResultException e) {
            LOG.error("No role found with property {}= {}", "id", roleId, e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Role> findAll() {
        LOG.debug("searching for all roles on ReMaRa database");
        TypedQuery<Role> query = entityManager.createQuery("SELECT e FROM " + Role.class.getSimpleName() + " e ",
                Role.class);
        List<Role> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.error("Empty table " + Role.class.getSimpleName() + " " + e);
        } catch (PersistenceException pe) {
            LOG.error("Persistence exception " + Role.class.getSimpleName() + " " + pe);
        }
        return result;
    }
}
