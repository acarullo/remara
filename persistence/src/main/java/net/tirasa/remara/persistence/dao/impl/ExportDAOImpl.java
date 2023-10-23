package net.tirasa.remara.persistence.dao.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.ExportDAO;
import net.tirasa.remara.persistence.data.Export;
import net.tirasa.remara.persistence.data.User;
import org.apache.openjpa.persistence.PersistenceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class ExportDAOImpl extends DAOImpl implements ExportDAO {

    private static final Logger LOG = LoggerFactory.getLogger(ExportDAOImpl.class);

    @Override
    @Transactional
    public Export saveOrUpdate(final Export export) {
        LOG.debug("saving export on ReMaRa database: {}", export.getId());
        return entityManager.merge(export);
    }

    @Override
    public Export find(final long id) {
        LOG.debug("searching for Export with id: {}", id);
        return entityManager.find(Export.class, id);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Export> findAll() {
        LOG.debug("searching for all exports on ReMaRa database");
        TypedQuery<Export> query = entityManager.createQuery("SELECT e FROM " + Export.class.getSimpleName() + " e ",
                Export.class);
        List<Export> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.error("Empty table " + User.class.getSimpleName() + " " + e);
        } catch (PersistenceException pe) {
            LOG.error("Persistence exception " + User.class.getSimpleName() + " " + pe);
        }
        return result;
    }

    @Override
    @Transactional
    public void delete(final Export export) {
        LOG.debug("deleting export from database");
        entityManager.remove(this.find(export.getId()));
    }
}
