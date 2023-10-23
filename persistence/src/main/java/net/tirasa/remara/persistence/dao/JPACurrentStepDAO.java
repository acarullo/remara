package net.tirasa.remara.persistence.dao;

import java.util.List;
import net.tirasa.remara.persistence.data.JPACurrentStep;

public interface JPACurrentStepDAO {

    JPACurrentStep save(JPACurrentStep jPACurrentStep);

    JPACurrentStep find(long id);

    List<JPACurrentStep> findByEntryId(long entryId);

}
