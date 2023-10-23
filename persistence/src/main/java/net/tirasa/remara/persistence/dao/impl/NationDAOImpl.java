package net.tirasa.remara.persistence.dao.impl;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.NationDAO;
import net.tirasa.remara.persistence.data.Nation;
import org.apache.openjpa.persistence.PersistenceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class NationDAOImpl extends DAOImpl implements NationDAO {

    private static final Logger LOG = LoggerFactory.getLogger(NationDAOImpl.class);

    @SuppressWarnings("unchecked")
    @Override
    public List<Nation> findAll(final String fieldOrder) {
        LOG.debug("searching for all nations on ReMaRa database ordered by {}", fieldOrder);
        TypedQuery<Nation> query = entityManager.createQuery("SELECT e FROM " + Nation.class.getSimpleName()
                + " e ORDER BY e." + fieldOrder, Nation.class);
        List<Nation> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.error("Empty table " + Nation.class.getSimpleName() + " " + e);
        } catch (PersistenceException pe) {
            LOG.error("Persistence exception " + Nation.class.getSimpleName() + " " + pe);
        }
        return result;
    }

    @Override
    public Nation get(final Long id) {
        LOG.debug("searching for nation by id {}", id);
        return entityManager.find(Nation.class, id);
    }

    @Override
    @Transactional
    public Nation saveOrUpdate(final Nation nation) {
        LOG.debug("saving nation on ReMaRa database: {}", nation.getId());
        return entityManager.merge(nation);
    }
        }
