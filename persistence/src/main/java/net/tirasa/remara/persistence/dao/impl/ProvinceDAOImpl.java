package net.tirasa.remara.persistence.dao.impl;

import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.ProvinceDAO;
import net.tirasa.remara.persistence.data.Province;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class ProvinceDAOImpl extends DAOImpl implements ProvinceDAO {

    private static final Logger LOG = LoggerFactory.getLogger(ProvinceDAOImpl.class);

    @Override
    public List<Province> findByProperty(final String propertyName, final Object value, final String fieldOrder) {
        LOG.debug("searching for province(s) with property {} = {} ordered by {}", propertyName, value, fieldOrder);
        TypedQuery<Province> query = entityManager.createQuery("SELECT e FROM " + Province.class.getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + "= :value" + " ORDER BY e." + fieldOrder, Province.class);
        query.setParameter("value", value);
        List<Province> result = null;
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No province found with property {}, {}, ordered by {}", propertyName, value, fieldOrder, e);
        }
        return result;
    }

    @Override
    public Province get(final String id) {
        return entityManager.find(Province.class, id);
    }

    @Override
    @Transactional
    public Province saveOrUpdate(final Province province) {
        LOG.debug("saving province on ReMaRa database: {}", province.getId());
        return entityManager.merge(province);
    }
}
