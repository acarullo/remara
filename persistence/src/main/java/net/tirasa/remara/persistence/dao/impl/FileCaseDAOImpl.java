package net.tirasa.remara.persistence.dao.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.FileCaseDAO;
import net.tirasa.remara.persistence.data.FileCase;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class FileCaseDAOImpl extends DAOImpl implements FileCaseDAO {

    private static final Logger LOG = LoggerFactory.getLogger(FileCaseDAOImpl.class);

    @Override
    @Transactional
    public FileCase saveOrUpdate(final FileCase fileCase) {
        LOG.debug("saving file case on ReMaRa database: {}", fileCase.getName());
        return entityManager.merge(fileCase);
    }

    @Override
    public FileCase get(final Long id) {
        LOG.debug("get file case by id: " + id);
        TypedQuery<FileCase> query = entityManager.createQuery("SELECT e FROM " + FileCase.class.getSimpleName()
                + " e " + "WHERE " + "e.id= :value", FileCase.class);
        query.setParameter("value", id);
        FileCase result = null;
        try {
            result = query.getSingleResult();
        } catch (NoResultException e) {
            LOG.error("No file case found with property {}, {}", "id", id, e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<FileCase> findByProperty(final String propertyName, final String value) {
        LOG.debug("searching for file case(s) with property {} = {}", propertyName, value);
        TypedQuery<FileCase> query = entityManager.createQuery("SELECT e FROM " + FileCase.class.getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + "= :value", FileCase.class);
        query.setParameter("value", value);
        List<FileCase> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.error("No file case found with property {}, {}", propertyName, value, e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<FileCase> findByProperty(final String propertyName, final Object value) {
        LOG.debug("searching for file case(s) with property {} = {}", propertyName, value);
        TypedQuery<FileCase> query = entityManager.createQuery("SELECT e FROM " + FileCase.class.getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + " = :value", FileCase.class);
        query.setParameter("value", value);
        List<FileCase> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.error("No file case found with property {}, {}", propertyName, value, e);
        }
        return result;
    }

    @Override
    @Transactional
    public int deleteByProperty(final String propertyName, final Object value) {
        LOG.debug("deleting file case by property {} with value {} from database", propertyName, value);
        int removed = 0;
        List<FileCase> foundByProp = findByProperty(propertyName, value);
        if (foundByProp.size() > 1) {
            LOG.warn("Deleting more than one file case!");
            for (FileCase fileCase : findByProperty(propertyName, value)) {
                LOG.debug("removing file case: {}", fileCase.getName());
                entityManager.remove(fileCase);
                removed++;
            }
        } else if (foundByProp.isEmpty()) {
            LOG.warn("empty result, there are no file cases to delete");
        } else {
            LOG.debug("removing the only file case in list: {}", foundByProp.get(0).getName());
            entityManager.remove(foundByProp.get(0));
            removed = 1;
        }
        return removed;
    }

    @Override
    @Transactional
    public void delete(final FileCase fileCase) {
        LOG.debug("deleting file case from database: {}", fileCase.getName());
        entityManager.remove(entityManager.find(FileCase.class, fileCase.getId()));
    }
}
