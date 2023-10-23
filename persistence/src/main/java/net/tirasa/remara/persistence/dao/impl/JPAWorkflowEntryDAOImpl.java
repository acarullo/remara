package net.tirasa.remara.persistence.dao.impl;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.JPAPropertySetItemDAO;
import net.tirasa.remara.persistence.dao.JPAWorkflowEntryDAO;
import net.tirasa.remara.persistence.data.JPACurrentStep;
import net.tirasa.remara.persistence.data.JPAPropertySetItem;
import net.tirasa.remara.persistence.data.JPAWorkflowEntry;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class JPAWorkflowEntryDAOImpl extends DAOImpl implements JPAWorkflowEntryDAO {

    private static final Logger LOG = LoggerFactory.getLogger(JPAWorkflowEntryDAOImpl.class);

    @Autowired
    private JPAPropertySetItemDAO propertySetItemDAO;

    @Override
    public JPAWorkflowEntry find(final Long id) {
        return entityManager.find(JPAWorkflowEntry.class, id);
    }

    @Override
    public List<JPAWorkflowEntry> findAll() {
        Query query = entityManager.createQuery("SELECT e FROM JPAWorkflowEntry e");
        return query.getResultList();
    }

    @Override
    @Transactional
    public JPAWorkflowEntry save(final JPAWorkflowEntry entry) {
        LOG.debug("Saving entry {}", entry.getState());
        return entityManager.merge(entry);
    }

    @Override
    @Transactional
    public void delete(final Long id) {
        JPAWorkflowEntry entry = find(id);
        if (entry == null) {
            return;
        }

        List<JPAPropertySetItem> properties = propertySetItemDAO.findAll(entry.getId());
        if (properties != null) {
            for (JPAPropertySetItem property : properties) {
                propertySetItemDAO.delete(property.getId());
            }
        }

        entityManager.remove(entry);
    }

    @Override
    @Transactional
    public void deleteCurrentStep(final Long stepId) {
        JPACurrentStep step = entityManager.find(JPACurrentStep.class, stepId);
        if (step != null) {
            entityManager.remove(step);
        }
    }

    @SuppressWarnings("unchecked")
    public List<JPAWorkflowEntry> findByProperty(final String propertyName, final Object value) {
        LOG.debug("searching for workflow entry(ies) with property {} = {}", propertyName, value);
        TypedQuery<JPAWorkflowEntry> query = entityManager.createQuery("SELECT e FROM " + JPAWorkflowEntry.class.
                getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + " = :value", JPAWorkflowEntry.class);
        query.setParameter("value", value);
        List<JPAWorkflowEntry> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No workflow entry found with property {}, {}", propertyName, value, e);
        }
        return result;
    }

    @Override
    @Transactional
    public int deleteByProperty(final String propertyName, final Object value) {
        LOG.debug("deleting workflow entry by property {} with value {} from database", propertyName, value);
//        TypedQuery<User> query = entityManager.createQuery("delete " + User.class.getSimpleName()
//                + " as model where model." + propertyName + "= " + value, User.class);
//        return query.getResultList().size();
        int removed = 0;
        List<JPAWorkflowEntry> foundByProp = findByProperty(propertyName, value);
        if (foundByProp.size() > 1) {
            LOG.warn("Deleting more than one history step!");
            for (JPAWorkflowEntry workflowEntry : findByProperty(propertyName, value)) {
                LOG.debug("removing workflow entry: {}", workflowEntry.getId());
                entityManager.remove(workflowEntry);
                removed++;
            }
        } else if (foundByProp.isEmpty()) {
            LOG.warn("empty result, there are no workflow entries to delete");
        } else {
            LOG.debug("removing the only workflow entry in list: {}", foundByProp.get(0).getId());
            entityManager.remove(foundByProp.get(0));
            removed = 1;
        }
        return removed;
    }
}
