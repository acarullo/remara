package net.tirasa.remara.persistence.dao.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.OccupationDAO;
import net.tirasa.remara.persistence.data.Occupation;
import org.apache.openjpa.persistence.PersistenceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class OccupationDAOImpl extends DAOImpl implements OccupationDAO {

    private static final Logger LOG = LoggerFactory.getLogger(OccupationDAOImpl.class);

    @SuppressWarnings("unchecked")
    @Override
    public List<Occupation> findAll(final String fieldOrder) {
        LOG.debug("searching for all occupations on ReMaRa database ordered by {}", fieldOrder);
        TypedQuery<Occupation> query = entityManager.createQuery("SELECT e FROM " + Occupation.class.getSimpleName()
                + " e ORDER BY e." + fieldOrder, Occupation.class);
        List<Occupation> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.error("Empty table " + Occupation.class.getSimpleName() + " " + e);
        } catch (PersistenceException pe) {
            LOG.error("Persistence exception " + Occupation.class.getSimpleName() + " " + pe);
        }
        return result;
    }

    @Override
    public Occupation get(final Long id) {
        LOG.debug("searching for occupation by id {}", id);
        return entityManager.find(Occupation.class, id);
    }

    @Override
    @Transactional
    public Occupation saveOrUpdate(final Occupation occupation) {
        LOG.debug("saving occupation on ReMaRa database: {}", occupation.getId());
        return entityManager.merge(occupation);
    }
}
