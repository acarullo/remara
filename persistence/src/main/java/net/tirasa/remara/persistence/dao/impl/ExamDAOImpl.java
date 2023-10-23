package net.tirasa.remara.persistence.dao.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.ExamDAO;
import net.tirasa.remara.persistence.data.Exam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class ExamDAOImpl extends DAOImpl implements ExamDAO {

    private static final Logger LOG = LoggerFactory.getLogger(ExamDAOImpl.class);

    @Override
    @Transactional
    public Exam saveOrUpdate(final Exam exam) {
        LOG.debug("saving exam on ReMaRa database: {}", exam.getDescription());
        return entityManager.merge(exam);
    }

    @Override
    public Exam get(final Long id) {
        LOG.debug("get exam by id: " + id);
//        return entityManager.find(Exam.class, id);
        TypedQuery<Exam> query = entityManager.createQuery("SELECT e FROM " + Exam.class.getSimpleName()
                + " e " + "WHERE " + "e.id= :value", Exam.class);
        query.setParameter("value", id);
        Exam result = null;
        try {
            result = query.getSingleResult();
        } catch (NoResultException e) {
            LOG.error("No exam found with property {}= {}", "id", id, e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Exam> findByProperty(final String propertyName, final String value) {
        LOG.debug("searching for exam(s) with property {} = {}", propertyName, value);
        TypedQuery<Exam> query = entityManager.createQuery("SELECT e FROM " + Exam.class.getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + "= :value", Exam.class);
        query.setParameter("value", value);
        List<Exam> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.error("No exam found with property {}, {}", propertyName, value, e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Exam> findByProperty(final String propertyName, final Object value) {
        LOG.debug("searching for file exam(s) with property {} = {}", propertyName, value);
        TypedQuery<Exam> query = entityManager.createQuery("SELECT e FROM " + Exam.class.getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + " = :value", Exam.class);
        query.setParameter("value", value);
        List<Exam> result = new ArrayList<>();
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.error("No exam found with property {}, {}", propertyName, value, e);
        }
        return result;
    }

    @Override
    @Transactional
    public int deleteByProperty(final String propertyName, final Object value) {
        LOG.debug("deleting exam by property {} with value {} from database", propertyName, value);
//        TypedQuery<FileCase> query = entityManager.createQuery("delete " + FileCase.class.getSimpleName()
//                + " as model where model." + propertyName + "= " + value, FileCase.class);
//        return query.getResultList().size();
        int removed = 0;
        List<Exam> foundByProp = findByProperty(propertyName, value);
        if (foundByProp.size() > 1) {
            LOG.warn("Deleting more than one file exam!");
            for (Exam exam : findByProperty(propertyName, value)) {
                LOG.debug("removing exam: {}", exam.getId());
                entityManager.remove(exam);
                removed++;
            }
        } else if (foundByProp.isEmpty()) {
            LOG.warn("empty result, there are no exams to delete");
        } else {
            LOG.debug("removing the only exam in list: {}", foundByProp.get(0).getId());
            entityManager.remove(foundByProp.get(0));
            removed = 1;
        }
        return removed;
    }
}
