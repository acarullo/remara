package net.tirasa.remara.core.dataprovider;

import java.lang.reflect.InvocationTargetException;
import net.tirasa.remara.core.management.Encoder;
import java.util.Iterator;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import net.tirasa.remara.core.clients.PersistenceClient;
import net.tirasa.remara.persistence.data.Education;
import net.tirasa.remara.persistence.data.Municipality;
import net.tirasa.remara.persistence.data.Nation;
import net.tirasa.remara.persistence.data.Occupation;
import net.tirasa.remara.persistence.data.Patient;
import net.tirasa.remara.persistence.data.Province;
import net.tirasa.remara.persistence.data.Region;
import org.apache.commons.beanutils.PropertyUtils;
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
public class PatientDataProvider extends SortableDataProvider<Patient> {

    private static final long serialVersionUID = 8715403519773446050L;

    private static final Logger LOG = LoggerFactory.getLogger(PatientDataProvider.class);

    @Autowired
    private PersistenceClient persistenceClient;

    private String code;

    private Patient patient;

    private boolean orSql = false;

    public final void setPatient(final Patient patient) {
        this.patient = patient;
    }

    public final void setOr(final boolean orSql) {
        this.orSql = orSql;
    }

    public final void setCode(final String code) {
        this.code = code;
    }

    protected final void setParameter(final Query query) {
        if (orSql) {
            if (!code.isEmpty()) {
                query.setParameter("name", "%" + code.toUpperCase() + "%");
                query.setParameter("surname", "%" + code.toUpperCase() + "%");
                query.setParameter("taxCode", "%" + code.toUpperCase() + "%");
            }
        } else {
            setOpPatient(query, "name", "LIKE");
            setOpPatient(query, "surname", "LIKE");
            setOpPatient(query, "sex", "=");
            setOpPatient(query, "taxCode", "LIKE");
            setOpPatient(query, "birthDate", "=");
            setOpPatient(query, "deathDate", "=");
            setOpPatient(query, "foreigner", "=");
            setOpPatient(query, "birthCap", "LIKE");
            setOpPatient(query, "birthForeignInformation", "LIKE");
            setOpPatient(query, "livingCap", "LIKE");
            setOpPatient(query, "livingAddress", "LIKE");
            setOpPatient(query, "birthRegion", "r");
            setOpPatient(query, "livingRegion", "r");
            setOpPatient(query, "birthNation", "n");
            setOpPatient(query, "livingNation", "n");
            setOpPatient(query, "birthProvince", "p");
            setOpPatient(query, "livingProvince", "p");
            setOpPatient(query, "birthMunicipality", "m");
            setOpPatient(query, "livingMunicipality", "m");
            setOpPatient(query, "personalEducation", "e");
            setOpPatient(query, "motherEducation", "e");
            setOpPatient(query, "fatherEducation", "e");
            setOpPatient(query, "personalOccupation", "o");
            setOpPatient(query, "exactlyOccupation", "LIKE");
            setOpPatient(query, "motherOccupation", "o");
            setOpPatient(query, "fatherOccupation", "o");
        }
    }

    protected final String createSql() {
        final StringBuffer sql = new StringBuffer(100);
        sql.append(" FROM ").append(Patient.class.getSimpleName()).
                append(" m ");
        if (code == null) {
            code = "";
        }
        if (orSql) {
            if (!code.isEmpty()) {
                LOG.debug("CODE TO ENCODE: " + code);
                code = Encoder.encString(code);
                LOG.debug("CODE ENCODED: " + code);
                sql.append(" AND ( upper(m.name) LIKE :name OR upper(m.surname)"
                        + "LIKE :surname OR upper(m.taxCode) = :taxCode ) ");
            }
        } else {
            sql.append(sqlOpPatient("name", "LIKE"));
            sql.append(sqlOpPatient("surname", "LIKE"));
            sql.append(sqlOpPatient("sex", "="));
            sql.append(sqlOpPatient("taxCode", "LIKE"));
            sql.append(sqlOpPatient("birthDate", "="));
            sql.append(sqlOpPatient("deathDate", "="));
            sql.append(sqlOpPatient("foreigner", "="));
            sql.append(sqlOpPatient("birthCap", "LIKE"));
            sql.append(sqlOpPatient("birthForeignInformation", "LIKE"));
            sql.append(sqlOpPatient("livingCap", "LIKE"));
            sql.append(sqlOpPatient("livingAddress", "LIKE"));
            sql.append(sqlOpPatient("birthRegion", "r"));
            sql.append(sqlOpPatient("livingRegion", "r"));
            sql.append(sqlOpPatient("birthNation", "n"));
            sql.append(sqlOpPatient("livingNation", "n"));
            sql.append(sqlOpPatient("birthProvince", "p"));
            sql.append(sqlOpPatient("livingProvince", "p"));
            sql.append(sqlOpPatient("birthMunicipality", "m"));
            sql.append(sqlOpPatient("livingMunicipality", "m"));
            sql.append(sqlOpPatient("personalEducation", "e"));
            sql.append(sqlOpPatient("motherEducation", "e"));
            sql.append(sqlOpPatient("fatherEducation", "e"));
            sql.append(sqlOpPatient("personalOccupation", "o"));
            sql.append(sqlOpPatient("exactlyOccupation", "LIKE"));
            sql.append(sqlOpPatient("motherOccupation", "o"));
            sql.append(sqlOpPatient("fatherOccupation", "o"));
        }

        return sql.toString();
    }

    private void setOpPatient(final Query query, final String field, final String operator) {
        try {
            if (patient == null) {
                return;
            }
            final Object value = PropertyUtils.getSimpleProperty(
                    patient, field);
            if (value == null) {
                return;
            }
            if ("r".equals(operator)) {
                final Region region = (Region) value;
                query.setParameter(field, region.getId());
                return;
            }
            if ("n".equals(operator)) {
                final Nation nation = (Nation) value;
                query.setParameter(field, nation.getId());
                return;
            }
            if ("m".equals(operator)) {
                final Municipality municipality = (Municipality) value;
                query.setParameter(field, municipality.getId());
                return;
            }
            if ("p".equals(operator)) {
                final Province province = (Province) value;
                query.setParameter(field, province.getId());
                return;
            }
            if ("e".equals(operator)) {
                final Education education = (Education) value;
                query.setParameter(field, education.getId());
                return;
            }
            if ("o".equals(operator)) {
                final Occupation occupation = (Occupation) value;
                query.setParameter(field, occupation.getId());
                return;
            }
            if ("LIKE".equals(operator)) {
                query.setParameter(field,
                        "%" + value.toString().toUpperCase() + "%");
            } else {
                query.setParameter(field, value);
            }
        } catch (IllegalAccessException ex) {
            LOG.error("errore nel settaggio parametro query: ", ex);
        } catch (InvocationTargetException ex) {
            LOG.error("errore nel settaggio parametro query: ", ex);
        } catch (NoSuchMethodException ex) {
            LOG.error("errore nel settaggio parametro query: ", ex);
        }
    }

    private String sqlOpPatient(final String field, final String operator) {
        try {
            if (patient == null) {
                return "";
            }
            final Object value = PropertyUtils.getSimpleProperty(patient, field);
            if (value == null) {
                return "";
            }

            if ("r".equals(operator)
                    || "m".equals(operator)
                    || "p".equals(operator)
                    || "n".equals(operator)
                    || "e".equals(operator)
                    || "o".equals(operator)) {
                return " AND m." + field + ".id = :" + field;
            }
            if ("LIKE".equals(operator)) {
                return " AND upper(m." + field + ") LIKE :" + field;
            } else {
                return " AND m." + field + " " + operator + " :" + field;
            }
        } catch (IllegalAccessException ex) {
            LOG.error("errore nel settaggio parametro query: ", ex);
        } catch (NoSuchMethodException ex) {
            LOG.error("errore nel settaggio parametro query: ", ex);
        } catch (InvocationTargetException ex) {
            LOG.error("errore nel settaggio parametro query: ", ex);
        }
        return "";
    }

    public Iterator<? extends Patient> iterator(final int first, final int count) {
        final String sql = "select m " + createSql() + addOrders();
        final TypedQuery<Patient> query = persistenceClient.createQueryPatient(sql);
        setParameter(query);
        query.setFirstResult(first);
        query.setMaxResults(count);
        return persistenceClient.executeQueryPatient(query);
    }

    public int size() {
        final String sql = " select count( id ) " + createSql();
        final Query query = persistenceClient.createCountQueryPatient(sql);
        setParameter(query);
        return ((Number) persistenceClient.executeQueryUniquePatient(query)).intValue();
    }

    @Override
    public IModel<Patient> model(final Patient object) {
        return new CompoundPropertyModel<Patient>(object);
    }

    private String addOrders() {
        final StringBuilder orders = new StringBuilder();
        if (getSort() != null) {
            orders.append(" ORDER BY ").append(getSort().getProperty());
            if (getSort().isAscending()) {
                orders.append(" ASC ");
            } else {
                orders.append(" DESC ");
            }
        }
        return orders.toString();
    }
}
