package net.tirasa.remara.persistence.dao.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.RegionDAO;
import net.tirasa.remara.persistence.data.Region;
import org.apache.openjpa.persistence.PersistenceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class RegionDAOImpl extends DAOImpl implements RegionDAO {

    private static final Logger LOG = LoggerFactory.getLogger(RegionDAOImpl.class);

    @SuppressWarnings("unchecked")
    @Override
    public List<Region> findAll() {
        LOG.debug("searching for all regions on ReMaRa database");
        TypedQuery<Region> query = entityManager.createQuery("SELECT e FROM " + Region.class.getSimpleName() + " e ",
                Region.class);
        List<Region> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.error("Empty table " + Region.class.getSimpleName() + " " + e);
        } catch (PersistenceException pe) {
            LOG.error("Persistence exception " + Region.class.getSimpleName() + " " + pe);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Region> findAll(final String fieldOrder) {
        LOG.debug("searching for all regions on ReMaRa database");
        TypedQuery<Region> query = entityManager.createQuery("SELECT e FROM " + Region.class.getSimpleName()
                + " e ORDER BY e." + fieldOrder, Region.class);
        List<Region> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.error("Empty table " + Region.class.getSimpleName() + " " + e);
        } catch (PersistenceException pe) {
            LOG.error("Persistence exception " + Region.class.getSimpleName() + " " + pe);
        }
        return result;
    }

    @Override
    public Region get(final Long id) {
        LOG.debug("get region by id on ReMaRa database: {}", id);
        return entityManager.find(Region.class, id);
    }

    @Override
    @Transactional
    public Region saveOrUpdate(final Region region) {
        LOG.debug("saving region on ReMaRa database: {}", region.getId());
        return entityManager.merge(region);
    }
}
