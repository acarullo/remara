package net.tirasa.remara.persistence.dao;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.data.MedicineCase;

public interface MedicineCaseDAO {

    public List<MedicineCase> getCaseAssigned();

    public List<MedicineCase> getRequestModifier(String username);

    public List<MedicineCase> getForWaitConfirm(String username);

    public List<MedicineCase> findForExport(Date from, Date to);

    public List<MedicineCase> findByProperty(String propertyName, Object value);

    public List<MedicineCase> findByProperty(String propertyName, String value);

    public List<MedicineCase> findByPatientAndIllness(String taxCode, Long illnessId);

    public List<MedicineCase> findByCfOrSurname(String value, String owner, String referent);

    public MedicineCase saveOrUpdate(MedicineCase medicineCase);

    public List<MedicineCase> findAll();

    public int deleteByProperty(String propertyName, Object value);

    public MedicineCase get(Long id);

    public TypedQuery<MedicineCase> createQuery(String sql);

    public Iterator<? extends MedicineCase> executeQuery(TypedQuery<MedicineCase> query);

    public Object executeQueryUnique(TypedQuery<Integer> query);

    public TypedQuery<Integer> createCountQuery(String sql);

    public TypedQuery<Long> createQueryMCId(String sql);

    public List<Long> executeQueryMCId(TypedQuery<Long> query);

    public int count();

    public int countWithStatus(String status);

    public List<MedicineCase> findExPP();

    public int countExPP();

    public List<MedicineCase> findByReferentOrOwner(String owner, String referent);

    public List<MedicineCase> findByYearInterval(String startYear, String endYear);
}
