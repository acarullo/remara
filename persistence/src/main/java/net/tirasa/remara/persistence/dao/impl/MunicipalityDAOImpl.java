package net.tirasa.remara.persistence.dao.impl;

import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.MunicipalityDAO;
import net.tirasa.remara.persistence.data.Municipality;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class MunicipalityDAOImpl extends DAOImpl implements MunicipalityDAO {

    private static final Logger LOG = LoggerFactory.getLogger(MunicipalityDAOImpl.class);

    @Override
    public List<Municipality> findByProperty(final String propertyName, final Object value, final String fieldOrder) {
        LOG.debug("searching for municipality(ies) with property {} = {} ordered by {}", propertyName, value,
                fieldOrder);
        TypedQuery<Municipality> query = entityManager.createQuery("SELECT e FROM " + Municipality.class.getSimpleName()
                + " e " + "WHERE " + "e." + propertyName + "= :value" + " ORDER BY e." + fieldOrder, Municipality.class);
        query.setParameter("value", value);
        List<Municipality> result = null;
        try {
            result = query.getResultList();
        } catch (NoResultException e) {
            LOG.debug("No municipality found with property {}, {}, ordered by {}", propertyName, value, fieldOrder, e);
        }
        return result;
    }

    @Override
    public Municipality get(final Long id) {
        return entityManager.find(Municipality.class, id);
    }

    @Override
    @Transactional
    public Municipality saveOrUpdate(final Municipality municipality) {
        LOG.debug("saving municipality on ReMaRa database: {}", municipality.getId());
        return entityManager.merge(municipality);
    }
}
