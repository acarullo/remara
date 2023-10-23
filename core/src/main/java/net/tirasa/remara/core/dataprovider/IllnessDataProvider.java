package net.tirasa.remara.core.dataprovider;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import net.tirasa.remara.core.clients.PersistenceClient;
import net.tirasa.remara.persistence.data.Illness;
import org.apache.wicket.extensions.markup.html.repeater.util.SortableDataProvider;
import org.apache.wicket.model.CompoundPropertyModel;
import org.apache.wicket.model.IModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component
@Scope("session")
public class IllnessDataProvider extends SortableDataProvider<Illness> {

    private static final long serialVersionUID = -7795313332616817174L;

    private static final Logger LOG = LoggerFactory.getLogger(IllnessDataProvider.class);

    private String code;

    private String description;

    private String exempt;

    private boolean orCriteria = false;

    @Autowired
    PersistenceClient persistenceClient;

    protected String countProperty;

    CriteriaBuilder criteriaBuilder;

    public IllnessDataProvider() {
        this("id");
    }

    public IllnessDataProvider(final String countProperty) {
        this.countProperty = countProperty;
    }

    public void setOrCriteria(final boolean orCriteria) {
        this.orCriteria = orCriteria;
    }

    public void setCode(final String code) {
        this.code = code;
    }

    public void setDescription(final String description) {
        this.description = description;
    }

    public void setExempt(final String exempt) {
        this.exempt = exempt;
    }

    protected final String createSql() {
        final StringBuffer sql = new StringBuffer(100);
        sql.append("select i.id FROM ").append(Illness.class.getSimpleName()).
                append(" i WHERE 1=1 ");
        if (code == null) {
            code = "";
        }
        if (description == null) {
            description = "";
        }
        if (exempt == null) {
            exempt = "";
        }

        if (orCriteria && !code.isEmpty()) {
            sql.append("AND (i.code LIKE '%").append(code.toUpperCase()).append("%' OR i.description LIKE '%").append(code.
                    toUpperCase()).append(
                    "%' OR i.exempt LIKE '%").append(code.toUpperCase()).append("%')");
        } else {
            if (!code.isEmpty()) {
                sql.append(" AND i.code LIKE '%").append(code.toUpperCase()).append("%'");
            }

            if (!description.isEmpty()) {
                sql.append(" AND ");
                sql.append(" i.description LIKE '%").append(description.toUpperCase()).append("%'");
            }

            if (!exempt.isEmpty()) {
                sql.append(" AND ");
                sql.append(" i.exempt LIKE '%").append(exempt.toUpperCase()).append("%'");
            }
        }
        return sql.toString();
    }

    public int size() {
        String sql = " select count( i ) from " + Illness.class.getSimpleName() + " i where i.id in :list";
        TypedQuery<Integer> query = persistenceClient.createCountQueryIllness(sql);
        TypedQuery<Long> innerQuery = persistenceClient.createQueryIllnessId(createSql());
        List<Long> result = persistenceClient.executeQueryIllnessId(innerQuery);
        if (!result.isEmpty()) {
            query.setParameter("list", result);
        } else {
            return 0;
        }
        return ((Number) persistenceClient.executeQueryUniqueIllness(query)).intValue();
    }

    public Iterator<? extends Illness> iterator(final int first, final int count) {
        String sql = " select i from " + Illness.class.getSimpleName() + " i where i.id in :list" + addOrders();
        TypedQuery<Illness> query = persistenceClient.createQueryIllness(sql);
        TypedQuery<Long> innerQuery = persistenceClient.createQueryIllnessId(createSql());
        List<Long> result = persistenceClient.executeQueryIllnessId(innerQuery);
        if (!result.isEmpty()) {
            query.setParameter("list", result);
        } else {
            return new ArrayList<Illness>().iterator();
        }
        query.setFirstResult(first);
        query.setMaxResults(count);
        return persistenceClient.executeQueryIllness(query).iterator();
    }

    private String addOrders() {
        final StringBuilder orders = new StringBuilder();
        if (getSort() != null) {
            orders.append(" ORDER BY i.").append(getSort().getProperty());
            if (getSort().isAscending()) {
                orders.append(" ASC ");
            } else {
                orders.append(" DESC ");
            }
        }
        return orders.toString();
    }

    public IModel<Illness> model(final Illness illnessObject) {
        return new CompoundPropertyModel<Illness>(illnessObject);
    }
}
