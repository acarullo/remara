package net.tirasa.remara.persistence.dao;

import java.util.List;
import net.tirasa.remara.persistence.data.JPACurrentStep;

public interface CurrentStepDAO {

    JPACurrentStep find(long id);

    public int deleteByProperty(String propertyName, Long value);

    public List<JPACurrentStep> findByProperty(String propertyName, Long value);

    public List<JPACurrentStep> findForWorkflowEntry(Long entryId);

    public List<JPACurrentStep> findUnderwayEntryOfOwner(String username);
}
