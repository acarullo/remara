package net.tirasa.remara.persistence.dao.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.HistoryStepDAO;
import net.tirasa.remara.persistence.data.JPAHistoryStep;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class HistoryStepDAOImpl extends DAOImpl implements HistoryStepDAO {

    private static final Logger LOG = LoggerFactory.getLogger(HistoryStepDAOImpl.class);

    @SuppressWarnings("unchecked")
    public List<JPAHistoryStep> findByProperty(final String propertyName, final Object value) {
        LOG.debug("searching for history step(s) with property {} = {}", propertyName, value);
        TypedQuery<JPAHistoryStep> query = entityManager.createQuery("SELECT e FROM " + JPAHistoryStep.class.
                getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + " = :value", JPAHistoryStep.class);
        query.setParameter("value", value);
        List<JPAHistoryStep> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No history step found with property {}, {}", propertyName, value, e);
        }
        return result;
    }

    @Override
    @Transactional
    public int deleteByProperty(final String propertyName, final Object value) {
        LOG.debug("deleting history step by property {} with value {} from database", propertyName, value);
//        TypedQuery<User> query = entityManager.createQuery("delete " + User.class.getSimpleName()
//                + " as model where model." + propertyName + "= " + value, User.class);
//        return query.getResultList().size();
        int removed = 0;
        List<JPAHistoryStep> foundByProp = findByProperty(propertyName, value);
        if (foundByProp.size() > 1) {
            LOG.warn("Deleting more than one history step!");
            for (JPAHistoryStep historyStep : findByProperty(propertyName, value)) {
                LOG.debug("removing current step: {}", historyStep.getId());
                entityManager.remove(historyStep);
                removed++;
            }
        } else if (foundByProp.isEmpty()) {
            LOG.warn("empty result, there are no history steps to delete");
        } else {
            LOG.debug("removing the only history step in list: {}", foundByProp.get(0).getId());
            entityManager.remove(foundByProp.get(0));
            removed = 1;
        }
        return removed;
    }
}
