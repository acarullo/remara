package net.tirasa.remara.core.dataprovider;

import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import net.tirasa.remara.core.clients.PersistenceClient;
import net.tirasa.remara.persistence.data.Education;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import net.tirasa.remara.persistence.data.HospitalWard;
import net.tirasa.remara.persistence.data.Illness;
import net.tirasa.remara.persistence.data.MedicineCase;
import net.tirasa.remara.persistence.data.Municipality;
import net.tirasa.remara.persistence.data.Nation;
import net.tirasa.remara.persistence.data.Occupation;
import net.tirasa.remara.persistence.data.Patient;
import net.tirasa.remara.persistence.data.Province;
import net.tirasa.remara.persistence.data.Region;
import net.tirasa.remara.persistence.utilities.JasyptMethods;
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
@Scope("request")
public class CaseDataProvider extends SortableDataProvider<MedicineCase> {

    private static final long serialVersionUID = 7043939916493397907L;

    private static final Logger LOG = LoggerFactory.getLogger(CaseDataProvider.class);

    @Autowired
    private PersistenceClient persistenceClient;

    private String owner;

    private String referent;

    private String code;

    private MedicineCase medicineCase;

    private boolean orSql = false;

    private String startYear;

    private String endYear;

    private String startYearMC;

    private String endYearMC;

    private int searchSize;

    private final JasyptMethods jasyptMethods = JasyptMethods.getJasyptMethods();

    private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    public CaseDataProvider() {
        searchSize = 0;
        setSort("surname", true);
    }

    public void setMedicineCase(final MedicineCase medicineCase) {
        this.medicineCase = medicineCase;
    }

    public void setOr(final boolean orSql) {
        this.orSql = orSql;
    }

    public void setCode(final String code) {
        this.code = code;
    }

    public int getSearchSize() {
        return searchSize;
    }

    public void setOwner(final String username) {
        this.owner = username;
    }

    public String getReferent() {
        return referent;
    }

    public void setReferent(final String referent) {
        this.referent = referent;
    }

    public void setStartYear(final String selectedStartYear) {
        this.startYear = selectedStartYear;
    }

    public void setEndYear(final String selectedEndYear) {
        this.endYear = selectedEndYear;
    }

    public void setStartYearMC(final String selectedStartYearMC) {
        this.startYearMC = selectedStartYearMC;
    }

    public void setEndYearMC(final String selectedEndYearMC) {
        this.endYearMC = selectedEndYearMC;
    }

    protected void setParameter(final Query query) throws ParseException {
        if (startYear != null && endYear != null) {
            query.setParameter("startYear", dateFormat.parse(startYear + "-01-01")); // YYYY-MM-DD
            query.setParameter("endYear", dateFormat.parse(endYear + "-12-31")); // YYYY-MM-DD
        }
        if (startYearMC != null && endYearMC != null) {
            query.setParameter("startYearMC", dateFormat.parse(startYearMC + "-01-01")); // YYYY-MM-DD
            query.setParameter("endYearMC", dateFormat.parse(endYearMC + "-12-31")); // YYYY-MM-DD
        }
        if (!owner.isEmpty()) {
            query.setParameter("owner", owner);
        }
        if (!referent.isEmpty()) {
            query.setParameter("referent", referent);
        }
        if (orSql) {
            if (!code.isEmpty()) {
                LOG.debug("orSql true, setting name and surname");
                query.setParameter("name", jasyptMethods.encrypt(code.toUpperCase()));
                query.setParameter("surname", code.toUpperCase().substring(0, 2) + "-" + jasyptMethods.encrypt(code.
                        toUpperCase()));
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
            setOp(query, "diagnosisDateIllness", "=");
            setOp(query, "startingDateIllness", "=");
            setOp(query, "exactlyIllness", "LIKE");
            if (medicineCase.getOrphanMedicine() != null && medicineCase.getOrphanMedicine()) {
                setOp(query, "orphanMedicine", "=");
            }
            setOp(query, "medicineDescription", "LIKE");
            if (medicineCase.getIllness() != null && medicineCase.getIllness().getCode() != null) {
                setOp(query, "illness", "i");
            }
            if (medicineCase.getHospitalOrganization() != null && medicineCase.getHospitalOrganization().getId() != null) {
                setOp(query, "hospitalOrganization", "ho");
            }
            setOp(query, "hospitalWard", "hw");
        }
    }

    protected String createSql() {
        StringBuilder sql = new StringBuilder(100);
        sql.append("select m.id ").append(" FROM ").append(MedicineCase.class.getSimpleName()).append(" m");
        if (owner == null) {
            owner = "";
        }
        if (referent == null) {
            referent = "";
        }
        if (code == null) {
            code = "";
        }
        if (!owner.isEmpty()) {
            LOG.debug("search by owner: {}", owner);
            sql.append(" WHERE 1=1 AND m.owner = :owner ");
        }
        if (!referent.isEmpty()) {
            if (owner.isEmpty()) {
                sql.append(" WHERE 1=1");
            }
            sql.append(" AND m.referent = :referent ");
        }
        if (orSql) {
            if (!code.isEmpty()) {
                if (owner.isEmpty() && referent.isEmpty()) {
                    sql.append(" WHERE 1=1");
                }
                sql.append(" AND ( ");
                sql.append("   m.patient.name LIKE :name ");
                sql.append("   OR m.patient.surname LIKE :surname ");
                sql.append(" ) ");
            }
        } else {
            if (owner.isEmpty() && referent.isEmpty()) {
                sql.append(" WHERE 1=1 ");
            }
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
            sql.append(sqlOp("diagnosisDateIllness", "="));
            sql.append(sqlOp("startingDateIllness", "="));
            sql.append(sqlOp("exactlyIllness", "LIKE"));
            if (medicineCase.getOrphanMedicine() != null && medicineCase.getOrphanMedicine()) {
                sql.append(sqlOp("orphanMedicine", "="));
            }
            sql.append(sqlOp("medicineDescription", "LIKE"));
            if (medicineCase.getIllness() != null && medicineCase.getIllness().getCode() != null) {
                sql.append(sqlOp("illness", "i"));
            }
            if (medicineCase.getHospitalOrganization() != null && medicineCase.getHospitalOrganization().getId()
                    != null) {
                sql.append(sqlOp("hospitalOrganization", "ho"));
            }
            sql.append(sqlOp("hospitalWard", "hw"));
        }

        return sql.toString();
    }

    private void setOp(final Query query, final String field, final String operator) {
        try {
            Object value = PropertyUtils.getSimpleProperty(medicineCase, field);
            if (value == null) {
                return;
            }
            if (operator.equals("i")) {
                Illness r = (Illness) value;
                query.setParameter(field, r.getId());
                return;
            }
            if (operator.equals("ho")) {
                HospitalOrganization r = (HospitalOrganization) value;
                query.setParameter(field, r.getId());
                return;
            }
            if (operator.equals("hw")) {
                HospitalWard r = (HospitalWard) value;
                query.setParameter(field, r.getId());
                return;
            }
            if (operator.equals("LIKE")) {
                query.setParameter(field, "%" + value.toString().toUpperCase() + "%");
            } else {
                query.setParameter(field, value);
            }
        } catch (IllegalAccessException ex) {
            LOG.error("errore nel settaggio parametro query: ", ex);
        } catch (NoSuchMethodException ex) {
            LOG.error("errore nel settaggio parametro query: ", ex);
        } catch (InvocationTargetException ex) {
            LOG.error("errore nel settaggio parametro query: ", ex);
        }
    }

    private void setOpPatient(final Query query, final String field, final String operator) {
        try {
            Patient patient = medicineCase.getPatient();
            if (patient == null) {
                return;
            }
            Object value = PropertyUtils.getSimpleProperty(patient, field);
            if (value == null) {
                return;
            }
            if ("name".equals(field) || "surname".equals(field) || "taxCode".equals(field)) {
                LOG.debug("encrypting field {} with unencrypted value = {}", field, value);
                if ("surname".equals(field)) {
                    LOG.debug("is surname, need special coding");
                    String newValue = (String) value;
                    value = newValue.toUpperCase().substring(0, 2) + "-" + jasyptMethods.encrypt(newValue.toUpperCase());

                } else {
                    String newValue = (String) value;
                    value = jasyptMethods.encrypt(newValue.toUpperCase());
                }
                LOG.debug("encrypted field {} with new encrypted value = {}", field, value);
            }
            if (operator.equals("r")) {
                Region r = (Region) value;
                query.setParameter(field, r.getId());
                return;
            }
            if (operator.equals("n")) {
                Nation r = (Nation) value;
                query.setParameter(field, r.getId());
                return;
            }
            if (operator.equals("m")) {
                Municipality r = (Municipality) value;
                query.setParameter(field, r.getId());
                return;
            }
            if (operator.equals("p")) {
                Province r = (Province) value;
                query.setParameter(field, r.getId());
                return;
            }
            if (operator.equals("e")) {
                Education r = (Education) value;
                query.setParameter(field, r.getId());
                return;
            }
            if (operator.equals("o")) {
                Occupation r = (Occupation) value;
                query.setParameter(field, r.getId());
                return;
            }
            if (operator.equals("LIKE")) {
                LOG.debug("Valore in Upper Case: {}", value.toString().toUpperCase());
                if ("name".equals(field) || "surname".equals(field) || "taxCode".equals(field)) {
                    query.setParameter(field, "%" + value.toString() + "%");
                } else {
                    query.setParameter(field, "%" + value.toString().toUpperCase() + "%");
                }
            } else {
                query.setParameter(field, value);
            }
        } catch (IllegalAccessException ex) {
            LOG.error("errore nel settaggio parametro query: ", ex);
        } catch (NoSuchMethodException ex) {
            LOG.error("errore nel settaggio parametro query: ", ex);
        } catch (InvocationTargetException ex) {
            LOG.error("errore nel settaggio parametro query: ", ex);
        }
    }

    private String sqlOp(final String field, final String operator) {
        try {
            Object value = PropertyUtils.getSimpleProperty(medicineCase, field);
            if (value == null) {
                return "";
            }

            if (operator.equals("i")) {
                return " AND m." + field + ".id = :" + field;
            }
            if (operator.equals("ho")
                    || operator.equals("hw")) {
                return " AND m." + field + ".id = :" + field;
            }
            if (operator.equals("LIKE")) {
                return " AND upper(m." + field + ") LIKE :" + field;
            } else {
                return " AND m." + field + " " + operator + " :" + field;
            }
        } catch (IllegalAccessException ex) {
            LOG.error("errore nel recupero del campo {} di medicine case: ", field, ex);
        } catch (NoSuchMethodException ex) {
            LOG.error("errore nel recupero del campo {} di medicine case: ", field, ex);
        } catch (InvocationTargetException ex) {
            LOG.error("errore nel recupero del campo {} di medicine case: ", field, ex);
        }
        return "";
    }

    private String sqlOpPatient(final String field, final String operator) {
        try {
            Patient patient = medicineCase.getPatient();
            if (patient == null) {
                return "";
            }
            Object value = PropertyUtils.getSimpleProperty(patient, field);
            if (value == null) {
                return "";
            }

            if (operator.equals("r")
                    || operator.equals("m")
                    || operator.equals("p")
                    || operator.equals("n")
                    || operator.equals("e")
                    || operator.equals("o")) {
                return " AND m.patient." + field + ".id = :" + field;
            }
            if (operator.equals("LIKE")) {
                return " AND m.patient." + field + " LIKE :" + field; // upper()
            }
            if ("date_int".equals(operator)) {
                return " AND m.patient." + field + " <= " + value;
            } else {
                return " AND m.patient." + field + " " + operator + " :" + field;
            }
        } catch (IllegalAccessException ex) {
            LOG.error("errore nel recupero del campo {} di medicine case: ", field, ex);
        } catch (InvocationTargetException ex) {
            LOG.error("errore nel recupero del campo {} di medicine case: ", field, ex);
        } catch (NoSuchMethodException ex) {
            LOG.error("errore nel recupero del campo {} di medicine case: ", field, ex);
        }
        return "";
    }

    public Iterator<? extends MedicineCase> iterator(final int first, final int count) {
        String sql = "select m from " + MedicineCase.class.getSimpleName() + " m WHERE m.id IN :mcList";
        TypedQuery<MedicineCase> query = persistenceClient.createQueryMC(sql.concat(addOrders()));
        String innerSql = createSql();
        if (startYear != null && endYear != null) {
            LOG.debug("adding birth date interval {}-{} to SQL query", startYear, endYear);
            innerSql = innerSql.concat(" AND (m.patient.birthDate >= :startYear AND m.patient.birthDate <= :endYear)");
        }
        if (startYearMC != null && endYearMC != null) {
            LOG.debug("adding medicine case insertion interval {}-{} to SQL query", startYearMC, endYearMC);
            innerSql = innerSql.concat(" AND (m.insertDate >= :startYearMC AND m.insertDate <= :endYearMC)");
        }
        TypedQuery<Long> innerQuery = persistenceClient.createQueryMCId(innerSql);
        try {
            setParameter(innerQuery);
        } catch (ParseException e) {
            LOG.debug("error parsing date interval", e);
        }
        List<Long> result = persistenceClient.executeQueryMCId(innerQuery);
        if (!result.isEmpty()) {
            query.setParameter("mcList", result);
        } else {
            // or fill list parameter with select for all users
            return new ArrayList<MedicineCase>().iterator();
        }
        query.setFirstResult(first);
        query.setMaxResults(count);
        return persistenceClient.executeQueryMC(query);
    }

    public int size() {
        String sql = " select count( m ) from " + MedicineCase.class.getSimpleName() + " m where m.id in :list";
        TypedQuery<Integer> query = persistenceClient.createCountQueryMC(sql);
        String innerSql = createSql();
        if (startYear != null && endYear != null) {
            LOG.debug("adding date interval {}-{} to SQL query", startYear, endYear);
            innerSql = innerSql.concat(" AND (m.patient.birthDate >= :startYear AND m.patient.birthDate <= :endYear)");
        }
        if (startYearMC != null && endYearMC != null) {
            LOG.debug("adding medicine case insertion interval {}-{} to SQL query", startYearMC, endYearMC);
            innerSql = innerSql.concat(" AND (m.insertDate >= :startYearMC AND m.insertDate <= :endYearMC)");
        }
        TypedQuery<Long> innerQuery = persistenceClient.createQueryMCId(innerSql);
        try {
            setParameter(innerQuery);
        } catch (ParseException e) {
            LOG.debug("error parsing date interval {}-{}", startYear, endYear, e);
        }
        List<Long> result = persistenceClient.executeQueryMCId(innerQuery);
        if (!result.isEmpty()) {
            query.setParameter("list", result);
        } else {
            // or fill list parameter with select for all users
            return 0;
        }
        searchSize = ((Number) persistenceClient.executeQueryUniqueMC(query)).intValue();
        return searchSize;
    }

    @Override
    public IModel<MedicineCase> model(MedicineCase object) {
        return new CompoundPropertyModel<MedicineCase>(object);
    }

    private String addOrders() {
        String orders = "";
        if (getSort() != null) {
            orders = " ORDER BY m.patient." + getSort().getProperty();
            if (getSort().isAscending()) {
                orders += " ASC ";
            } else {
                orders += " DESC ";
            }
        }
        return orders;
    }
}
