package net.tirasa.remara.core.clients;

import java.io.Serializable;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import net.tirasa.remara.persistence.dao.CurrentStepDAO;
import net.tirasa.remara.persistence.dao.EducationDAO;
import net.tirasa.remara.persistence.dao.ExamDAO;
import net.tirasa.remara.persistence.dao.ExportDAO;
import net.tirasa.remara.persistence.dao.FileCaseDAO;
import net.tirasa.remara.persistence.dao.HistoryStepDAO;
import net.tirasa.remara.persistence.dao.HospitalOrganizationDAO;
import net.tirasa.remara.persistence.dao.HospitalWardDAO;
import net.tirasa.remara.persistence.dao.IllnessDAO;
import net.tirasa.remara.persistence.dao.JPAWorkflowEntryDAO;
import net.tirasa.remara.persistence.dao.MedicineCaseDAO;
import net.tirasa.remara.persistence.dao.MunicipalityDAO;
import net.tirasa.remara.persistence.dao.NationDAO;
import net.tirasa.remara.persistence.dao.OccupationDAO;
import net.tirasa.remara.persistence.dao.PatientDAO;
import net.tirasa.remara.persistence.dao.ProvinceDAO;
import net.tirasa.remara.persistence.dao.RegionDAO;
import net.tirasa.remara.persistence.dao.RoleDAO;
import net.tirasa.remara.persistence.dao.UserDAO;
import net.tirasa.remara.persistence.data.Education;
import net.tirasa.remara.persistence.data.Exam;
import net.tirasa.remara.persistence.data.Export;
import net.tirasa.remara.persistence.data.FileCase;
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
import net.tirasa.remara.persistence.data.Role;
import net.tirasa.remara.persistence.data.User;
import net.tirasa.remara.persistence.data.JPACurrentStep;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class PersistenceClient implements Serializable {

    private static final long serialVersionUID = -8718202359611389011L;

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private RoleDAO roleDAO;

    @Autowired
    private RegionDAO regionDAO;

    @Autowired
    private PatientDAO patientDAO;

    @Autowired
    private MunicipalityDAO municipalityDAO;

    @Autowired
    private NationDAO nationDAO;

    @Autowired
    private ProvinceDAO provinceDAO;

    @Autowired
    private EducationDAO educationDAO;

    @Autowired
    private OccupationDAO occupationDAO;

    @Autowired
    private IllnessDAO illnessDAO;

    @Autowired
    private HospitalWardDAO hospitalWardDAO;

    @Autowired
    private HospitalOrganizationDAO hospitalOrganizationDAO;

    @Autowired
    private ExportDAO exportDAO;

    @Autowired
    private MedicineCaseDAO medicineCaseDAO;

    @Autowired
    private ExamDAO examDAO;

    @Autowired
    private FileCaseDAO fileCaseDAO;

    @Autowired
    private HistoryStepDAO historyStepDAO;

    @Autowired
    private CurrentStepDAO currentStepDAO;

    @Autowired
    private JPAWorkflowEntryDAO workflowEntryDAO;

    public void saveOrUpdateUser(final User user) {
        userDAO.saveOrUpdate(user);
    }

    public List<User> findAllUsers() {
        return userDAO.findAll();
    }

    public List<User> findByPropertyUsers(final String propertyName, final Object value) {
        return userDAO.findByProperty(propertyName, value);
    }

    public List<User> findByPropertyUsers(final String propertyName, final String value) {
        return userDAO.findByProperty(propertyName, value);
    }

    public User getSUser(final String username) {
        return userDAO.getS(username);
    }

    public int deleteByPropertyUser(final String propertyName, final Object value) {
        return userDAO.deleteByProperty(propertyName, value);
    }

    public Role getRole(final Long id) {
        return roleDAO.get(id);
    }

    public List<Role> findAllRoles() {
        return roleDAO.findAll();
    }

    public void saveOrUpdatePatient(final Patient patient) {
        patientDAO.saveOrUpdate(patient);
    }

    public Patient getPatient(final Long id) {
        return patientDAO.get(id);
    }

    public Municipality getMunicipality(final Long id) {
        return municipalityDAO.get(id);
    }

    public Nation getNation(final Long id) {
        return nationDAO.get(id);
    }

    public Province getProvince(final String id) {
        return provinceDAO.get(id);
    }

    public Region getRegion(final Long id) {
        return regionDAO.get(id);
    }

    public List<Region> findAllRegions() {
        return regionDAO.findAll();
    }

    public Education getEducation(final Long id) {
        return educationDAO.get(id);
    }

    public Occupation getOccupation(final Long id) {
        return occupationDAO.get(id);
    }

    public int deleteByPropertyPatient(final String propertyName, final Object value) {
        return patientDAO.deleteByProperty(propertyName, value);
    }

    public List<Patient> findAllPatients() {
        return patientDAO.findAll();
    }

    public List<Illness> findByPropertyIllnesses(final String propertyName, final String value) {
        return illnessDAO.findByProperty(propertyName, value);
    }

    public void saveOrUpdateIllness(final Illness illness) {
        illnessDAO.saveOrUpdate(illness);
    }

    public Illness getIllness(final Long id) {
        return illnessDAO.get(id);
    }

    public List<Illness> findAllIllnesses() {
        return illnessDAO.findAll();
    }

    public int deleteByPropertyIllness(final String propertyName, final Object value) {
        return illnessDAO.deleteByProperty(propertyName, value);
    }

    public List<Illness> findByCodeIllness(final String code, final int MAX_ROWS) {
        return illnessDAO.findByCode(code, MAX_ROWS);
    }

    public List<HospitalWard> findByPropertyHWards(final String hospitalOrganizationid, final Long idHospital) {
        return hospitalWardDAO.findByProperty(hospitalOrganizationid, idHospital);
    }

    public HospitalOrganization getHospital(final Long idHospital) {
        return hospitalOrganizationDAO.get(idHospital);
    }

    public void saveOrUpdateHWard(final HospitalWard hospitalWard) {
        hospitalWardDAO.saveOrUpdate(hospitalWard);
    }

    public List<HospitalOrganization> findByPropertyHospitals(final String propertyName, final String value) {
        return hospitalOrganizationDAO.findByProperty(propertyName, value);
    }

    public void saveOrUpdateHospital(final HospitalOrganization hospitalOrganization) {
        hospitalOrganizationDAO.saveOrUpdate(hospitalOrganization);
    }

    public HospitalWard getHWard(final Long id) {
        return hospitalWardDAO.get(id);
    }

    public void deleteHWard(final HospitalWard hospitalWard) {
        hospitalWardDAO.delete(hospitalWard);
    }

    public List<HospitalOrganization> findAllHospitals() {
        return hospitalOrganizationDAO.findAll();
    }

    public List<HospitalWard> findAllHWards() {
        return hospitalWardDAO.findAll();
    }

    public int deleteByPropertyHWard(final String propertyName, final Object value) {
        return hospitalWardDAO.deleteByProperty(propertyName, value);
    }

    public void deleteHospital(final HospitalOrganization hospital) {
        hospitalOrganizationDAO.delete(hospital);
    }

    public int deleteByPropertyHospital(final String propertyName, final Object value) {
        return hospitalOrganizationDAO.deleteByProperty(propertyName, value);
    }

    public List<Region> findAllRegions(final String fieldOrder) {
        return regionDAO.findAll(fieldOrder);
    }

    public List<HospitalOrganization> findByPropertyHospitals(final String propertyName, final Object value,
                                                              final String fieldOrder) {
        return hospitalOrganizationDAO.findByProperty(propertyName, value, fieldOrder);
    }

    public List<HospitalWard> findHWByProperty(final String propertyName, final Object value, final String fieldOrder) {
        return hospitalWardDAO.findHWByProperty(propertyName, value, fieldOrder);
    }

    public List<HospitalWard> findByPropertyHWards(final String propertyName, final Object value,
                                                   final String fieldOrder) {
        return hospitalWardDAO.findByProperty(propertyName, value, fieldOrder);
    }

    public List<Export> findAllExports() {
        return exportDAO.findAll();
    }

    public void saveOrUpdateExport(final Export export) {
        exportDAO.saveOrUpdate(export);
    }

    public void deleteExport(final Export export) {
        exportDAO.delete(export);
    }

    public List<MedicineCase> findForExportMC(final Date from, final Date to) {
        return medicineCaseDAO.findForExport(from, to);
    }

    public void saveOrUpdateMC(final MedicineCase medicineCase) {
        medicineCaseDAO.saveOrUpdate(medicineCase);
    }

    public List<MedicineCase> findByPatientAndIllnessMC(final String propertyName, final Long illnessId) {
        return medicineCaseDAO.findByPatientAndIllness(propertyName, illnessId);
    }

    public void saveOrUpdateExam(final Exam exam) {
        examDAO.saveOrUpdate(exam);
    }

    public MedicineCase getMC(final Long id) {
        return medicineCaseDAO.get(id);
    }

    public Exam getExam(final Long id) {
        return examDAO.get(id);
    }

    public void deleteFileCase(final FileCase fileCase) {
        fileCaseDAO.delete(fileCase);
    }

    public List<FileCase> findByPropertyFileCase(final String propertyName, final Object value) {
        return fileCaseDAO.findByProperty(propertyName, value);
    }

    public void deleteByPropertyExam(final String propertyName, final Object value) {
        examDAO.deleteByProperty(propertyName, value);
    }

    public List<Nation> findAllNations(final String descriptionIt) {
        return nationDAO.findAll(descriptionIt);
    }

    public List<Province> findByPropertyProvince(final String propertyName, final Object value, String fieldOrder) {
        return provinceDAO.findByProperty(propertyName, value, fieldOrder);
    }

    public List<Municipality> findByPropertyMunicipality(final String propertyName, final Object value,
                                                         final String fieldOrder) {
        return municipalityDAO.findByProperty(propertyName, value, fieldOrder);
    }

    public List<Education> findAllEducations(final String fieldOrder) {
        return educationDAO.findAll(fieldOrder);
    }

    public List<Occupation> findAllOccupations(final String fieldOrder) {
        return occupationDAO.findAll(fieldOrder);
    }

    public List<Exam> findByPropertyExams(final String propertyName, final Object value) {
        return examDAO.findByProperty(propertyName, value);
    }

    public void deleteByPropertyMC(final String propertyName, final Object value) {
        medicineCaseDAO.deleteByProperty(propertyName, value);
    }

    public List<MedicineCase> findByPropertyMC(final String workflow, final Object value) {
        JPACurrentStep jpacs = currentStepDAO.find((Long) value);

        return medicineCaseDAO.findByProperty(workflow, jpacs.getEntryId());
    }

    public List<MedicineCase> getCaseAssignedMC() {
        return medicineCaseDAO.getCaseAssigned();
    }

    public List<MedicineCase> findAllMC() {
        return medicineCaseDAO.findAll();
    }

    public List<MedicineCase> getForWaitConfirmMC(final String username) {
        return medicineCaseDAO.getForWaitConfirm(username);
    }

    public List<MedicineCase> getRequestModifierMC(final String username) {
        return medicineCaseDAO.getRequestModifier(username);
    }

    public int deleteByPropertyHistoryStep(final String propertyName, final Object value) {
        return historyStepDAO.deleteByProperty(propertyName, value);
    }

    public int deleteByPropertyCurrentStep(final String propertyName, final Long value) {
        return currentStepDAO.deleteByProperty(propertyName, value);
    }

    public int deleteByPropertyWorkflowEntry(final String propertyName, final Object value) {
        return workflowEntryDAO.deleteByProperty(propertyName, value);
    }

    public List<JPACurrentStep> findByPropertyCurrentStep(final String propertyName, final Long value) {
        return currentStepDAO.findByProperty(propertyName, value);
    }

    public List<JPACurrentStep> findCurrentStepForWorkflowEntry(final Long entryId) {
        return currentStepDAO.findForWorkflowEntry(entryId);
    }

    public List<JPACurrentStep> findUnderwayEntryOfOwner(final String username) {
        return currentStepDAO.findUnderwayEntryOfOwner(username);
    }

    public TypedQuery<Patient> createQueryPatient(final String sql) {
        return patientDAO.createQuery(sql);
    }

    public Iterator<? extends Patient> executeQueryPatient(TypedQuery<Patient> query) {
        return patientDAO.executeQuery(query);
    }

    public TypedQuery<MedicineCase> createQueryMC(final String sql) {
        return medicineCaseDAO.createQuery(sql);
    }

    public Iterator<? extends MedicineCase> executeQueryMC(TypedQuery<MedicineCase> query) {
        return medicineCaseDAO.executeQuery(query);
    }

    public Object executeQueryUniquePatient(final Query query) {
        return patientDAO.executeQueryUnique(query);
    }

    public Object executeQueryUniqueMC(final TypedQuery<Integer> query) {
        return medicineCaseDAO.executeQueryUnique(query);
    }

    public Query createCountQueryPatient(String sql) {
        return patientDAO.createCountQuery(sql);
    }

    public TypedQuery<Integer> createCountQueryMC(String sql) {
        return medicineCaseDAO.createCountQuery(sql);
    }

    public List<Long> executeQueryMCId(TypedQuery query) {
        return medicineCaseDAO.executeQueryMCId(query);
    }

    public TypedQuery<Long> createQueryMCId(String sql) {
        return medicineCaseDAO.createQueryMCId(sql);
    }

    public List<Patient> findPatientsByCFOrSurname(final String code) {
        return patientDAO.findByCfOrSurname(code);
    }

    public List<Patient> findPatientsByYearInterval(final String startYear, final String endYear) {
        return patientDAO.findByYearInterval(startYear, endYear);
    }

    public int countCases() {
        return medicineCaseDAO.count();
    }

    public int countPatients() {
        return patientDAO.count();
    }

    public int countStatusCases(final String status) {
        return medicineCaseDAO.countWithStatus(status);
    }

    public void toExPP(final MedicineCase medicineCase) {
        medicineCaseDAO.saveOrUpdate(medicineCase);
    }

    public List<MedicineCase> findExPP() {
        return medicineCaseDAO.findExPP();
    }

    public int countExPP() {
        return medicineCaseDAO.countExPP();
    }

    public Education findByIdEducation(Long id) {
        return educationDAO.get(id);
    }

    public Occupation findByIdOccupation(long id) {
        return occupationDAO.get(id);
    }

    public Municipality findByIdMunicipality(long id) {
        return municipalityDAO.get(id);
    }

    public List<Illness> executeQueryIllness(final TypedQuery<Illness> query) {
        return illnessDAO.executeQuery(query);
    }

    public Object executeQueryUniqueIllness(final TypedQuery<Integer> query) {
        return illnessDAO.executeQueryUnique(query);
    }

    public TypedQuery<Integer> createCountQueryIllness(final String sql) {
        return illnessDAO.createCountQuery(sql);
    }

    public List<Long> executeQueryIllnessId(final TypedQuery<Long> query) {
        return illnessDAO.executeQueryIllnessId(query);
    }

    public TypedQuery<Long> createQueryIllnessId(final String sql) {
        return illnessDAO.createQueryIllnessId(sql);
    }

    public TypedQuery<Illness> createQueryIllness(final String sql) {
        return illnessDAO.createQuery(sql);
    }

    public List<MedicineCase> findBySurnameOrTcMC(final String code, final String owner, final String referent) {
        return medicineCaseDAO.findByCfOrSurname(code, owner, referent);
    }

    public List<MedicineCase> findByReferentOrOwnerMC(final String owner, final String referent) {
        return medicineCaseDAO.findByReferentOrOwner(owner, referent);
    }

    public List<MedicineCase> findByYearIntervalMC(final String startYear, final String endYear) {
        return medicineCaseDAO.findByYearInterval(startYear, endYear);
    }

    public List<Patient> findByPropertyPatients(final String property, final String value) {
        return patientDAO.findByProperty(property, value);
    }

    public List<Patient> findAdultPatients() {
        return patientDAO.findAdultPatients();
    }

    public List<Patient> findMinorPatients() {
        return patientDAO.findMinorPatients();
    }

    public List<Patient> findByNameAndSurname(final String name, final String surname) {
        return patientDAO.findByNameAndSurname(name, surname);
    }

    public void saveOrUpdateMunicipality(final Municipality municipality) {
        municipalityDAO.saveOrUpdate(municipality);
    }

    public void deleteByPropertyMunicipality(final Long id) {
        municipalityDAO.deleteById(id);
    }
}
