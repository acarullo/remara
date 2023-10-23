package net.tirasa.remara.persistence.dao.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.EducationDAO;
import net.tirasa.remara.persistence.data.Education;
import org.apache.openjpa.persistence.PersistenceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class EducationDAOImpl extends DAOImpl implements EducationDAO {

    private static final Logger LOG = LoggerFactory.getLogger(EducationDAOImpl.class);

    @SuppressWarnings("unchecked")
    @Override
    public List<Education> findAll(final String fieldOrder) {
        LOG.debug("searching for all educations on ReMaRa database ordered by {}", fieldOrder);
        TypedQuery<Education> query = entityManager.createQuery("SELECT e FROM " + Education.class.getSimpleName()
                + " e ORDER BY e." + fieldOrder, Education.class);
        List<Education> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.error("Empty table " + Education.class.getSimpleName() + " " + e);
        } catch (PersistenceException pe) {
            LOG.error("Persistence exception " + Education.class.getSimpleName() + " " + pe);
        }
        return result;
    }

    @Override
    public Education get(final Long id) {
        return entityManager.find(Education.class, id);
    }

    @Override
    @Transactional
    public Education saveOrUpdate(final Education education) {
        LOG.debug("saving education on ReMaRa database: {}", education.getId());
        return entityManager.merge(education);
    }
}
