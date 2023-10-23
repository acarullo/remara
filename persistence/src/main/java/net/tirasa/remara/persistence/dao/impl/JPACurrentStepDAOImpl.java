package net.tirasa.remara.persistence.dao.impl;

import java.util.List;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.JPACurrentStepDAO;
import net.tirasa.remara.persistence.data.JPACurrentStep;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class JPACurrentStepDAOImpl extends DAOImpl implements JPACurrentStepDAO {

    @Override
    @Transactional
    public JPACurrentStep save(JPACurrentStep jPACurrentStep) {
        return entityManager.merge(jPACurrentStep);
    }

    @Override
    public JPACurrentStep find(long id) {
        return entityManager.find(JPACurrentStep.class, id);
    }

    @Override
    public List<JPACurrentStep> findByEntryId(long entryId) {
        TypedQuery<JPACurrentStep> query = entityManager.createQuery("SELECT e FROM "
                + JPACurrentStep.class.getSimpleName() + " e " + "WHERE " + "e.jPAWorkflowEntry.id= :value",
                JPACurrentStep.class);
        query.setParameter("value", entryId);
        return query.getResultList();
    }

}
