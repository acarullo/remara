/*
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *  under the License.
 */
package net.tirasa.remara.persistence.dao.impl;

import java.util.List;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import org.springframework.stereotype.Repository;
import net.tirasa.remara.persistence.data.JPAPropertySetItem;
import net.tirasa.remara.persistence.dao.JPAPropertySetItemDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class JPAPropertySetItemDAOImpl extends DAOImpl
        implements JPAPropertySetItemDAO {

    private static final Logger LOG = LoggerFactory.getLogger(JPAPropertySetItemDAOImpl.class);

    @Override
    public JPAPropertySetItem find(final Long id) {
        return entityManager.find(JPAPropertySetItem.class, id);
    }

    @Override
    public JPAPropertySetItem find(final Long workflowEntryId,
            final String propertyKey) {

        Query query = entityManager.createQuery(
                "SELECT e FROM JPAPropertySetItem e "
                + "WHERE e.workflowEntryId=:workflowEntryId "
                + "AND e.propertyKey=:propertyKey");
        query.setParameter("workflowEntryId", workflowEntryId);
        query.setParameter("propertyKey", propertyKey);

        JPAPropertySetItem result = null;
        try {
            result = (JPAPropertySetItem) query.getSingleResult();
        } catch (NoResultException e) {
        } catch (Throwable t) {
            LOG.error("Unexpected exception", t);
        }

        return result;
    }

    @Override
    public List<JPAPropertySetItem> findAll() {
        Query query = entityManager.createQuery(
                "SELECT e FROM JPAPropertySetItem e");
        return query.getResultList();
    }

    @Override
    public List<JPAPropertySetItem> findAll(final Long workflowEntryId) {
        Query query = entityManager.createQuery(
                "SELECT e FROM JPAPropertySetItem e "
                + "WHERE e.workflowEntryId=:workflowEntryId");
        query.setParameter("workflowEntryId", workflowEntryId);
        return query.getResultList();
    }

    @Override
    @Transactional
    public JPAPropertySetItem save(final JPAPropertySetItem property) {
        return entityManager.merge(property);
    }

    @Override
    @Transactional
    public void delete(final Long id) {
        JPAPropertySetItem osWorkflowProperty = find(id);
        if (osWorkflowProperty == null) {
            return;
        }

        entityManager.remove(osWorkflowProperty);
    }

    @Override
    @Transactional
    public void delete(final Long workflowEntryId, final String propertyKey) {
        JPAPropertySetItem osWorkflowProperty = find(workflowEntryId, propertyKey);
        if (osWorkflowProperty == null) {
            return;
        }

        entityManager.remove(osWorkflowProperty);
    }
}
