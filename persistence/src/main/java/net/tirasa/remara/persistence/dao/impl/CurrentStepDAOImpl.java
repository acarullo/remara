package net.tirasa.remara.persistence.dao.impl;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.CurrentStepDAO;
import net.tirasa.remara.persistence.data.JPACurrentStep;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class CurrentStepDAOImpl extends DAOImpl implements CurrentStepDAO {

    private static final Logger LOG = LoggerFactory.getLogger(CurrentStepDAOImpl.class);

    @Override
    public JPACurrentStep find(long id) {
        return entityManager.find(JPACurrentStep.class, id);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<JPACurrentStep> findByProperty(final String propertyName, final Long value) {
        LOG.debug("searching for current step(s) with property {} = {}", propertyName, value);
        TypedQuery<JPACurrentStep> query = entityManager.createQuery("SELECT e FROM " + JPACurrentStep.class.
                getSimpleName() + " e " + "WHERE " + "e." + propertyName + " = :value", JPACurrentStep.class);
        query.setParameter("value", value);
        List<JPACurrentStep> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No current step found with property {}, {}", propertyName, value, e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<JPACurrentStep> findForWorkflowEntry(final Long entryId) {
        LOG.debug("searching for current step(s) of entryId {}", entryId);
        TypedQuery<JPACurrentStep> query = entityManager.createQuery("SELECT e FROM " + JPACurrentStep.class.
                getSimpleName() + " e " + "WHERE " + "e.jPAWorkflowEntry.id=:value", JPACurrentStep.class);
        query.setParameter("value", entryId);
        List<JPACurrentStep> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No current step found with entryId{}", entryId, e);
        }
        return result;
    }

    @Override
    @Transactional
    public int deleteByProperty(final String propertyName, final Long value) {
        LOG.debug("deleting curent step by property {} with value {} from database", propertyName, value);
//        TypedQuery<User> query = entityManager.createQuery("delete " + User.class.getSimpleName()
//                + " as model where model." + propertyName + "= " + value, User.class);
//        return query.getResultList().size();
        int removed = 0;
        List<JPACurrentStep> foundByProp = findByProperty(propertyName, value);
        if (foundByProp.size() > 1) {
            LOG.warn("Deleting more than one current step!");
            for (JPACurrentStep currentStep : findByProperty(propertyName, value)) {
                LOG.debug("removing current step: {}", currentStep.getId());
                entityManager.remove(currentStep);
                removed++;
            }
        } else if (foundByProp.isEmpty()) {
            LOG.warn("empty result, there are no current steps to delete");
        } else {
            LOG.debug("removing the only current step in list: {}", foundByProp.get(0).getId());
            entityManager.remove(foundByProp.get(0));
            removed = 1;
        }
        return removed;
    }

    @Override
    public List<JPACurrentStep> findUnderwayEntryOfOwner(final String username) {
        LOG.debug("searching for current step in underway status of owner {}", username);
        TypedQuery<JPACurrentStep> query = entityManager.createQuery("SELECT e FROM " + JPACurrentStep.class.
                getSimpleName() + " e WHERE e.status=:status AND e.owner=:owner", JPACurrentStep.class);
        query.setParameter("status", "Underway");
        query.setParameter("owner", username);
        List<JPACurrentStep> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No current step underway found for owner {}", username, e);
        }
        return result;
    }
}
