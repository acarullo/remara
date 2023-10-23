package net.tirasa.remara.core.management;

import com.opensymphony.workflow.InvalidActionException;
import com.opensymphony.workflow.WorkflowException;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.core.clients.PersistenceClient;
import net.tirasa.remara.core.workflow.WorkflowManager;
import net.tirasa.remara.persistence.data.Education;
import net.tirasa.remara.persistence.data.Exam;
import net.tirasa.remara.persistence.data.FileCase;
import net.tirasa.remara.persistence.data.MedicineCase;
import net.tirasa.remara.persistence.data.Municipality;
import net.tirasa.remara.persistence.data.Nation;
import net.tirasa.remara.persistence.data.Occupation;
import net.tirasa.remara.persistence.data.Patient;
import net.tirasa.remara.persistence.data.Province;
import net.tirasa.remara.persistence.data.Region;
import net.tirasa.remara.persistence.data.User;
import net.tirasa.remara.persistence.data.JPACurrentStep;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CaseManagement {

    private static final Logger LOG = LoggerFactory.getLogger(CaseManagement.class);

    @Autowired
    private PersistenceClient persistenceClient;

    @Autowired
    private WorkflowManager workflowManager;

    private static final int YEARS = 18;

    public void insert(final MedicineCase medicineCase) throws DBException {
        toUtf(medicineCase);
        List<MedicineCase> list = persistenceClient.findByPatientAndIllnessMC(medicineCase.getPatient().getTaxCode(),
                medicineCase.getIllness().getId());
        if (list != null && list.size() > 0) {
            throw new DBException(DBException.ELEMENT_EXIST);
        }
        try {
            medicineCase.setInsertDate(new Date());
            Patient patient = persistenceClient.getPatient(medicineCase.getPatient().getId());
            medicineCase.setPatient(patient);

            workflowManager.setCaller(medicineCase.getOwner());
            workflowManager.initialize();
            workflowManager.doAction(WorkflowManager.ACTION_SAVE);

            medicineCase.setWorkflow(workflowManager.getIdWorkflow());
            medicineCase.setStatusWorkflow(WorkflowManager.STATUS_UNDERWAY);
            persistenceClient.saveOrUpdateMC(medicineCase);
        } catch (InvalidActionException e) {
            LOG.error("Error inserting case", e);
            throw new DBException(DBException.SAVE);
        } catch (WorkflowException e) {
            LOG.error("Error inserting case", e);
            throw new DBException(DBException.SAVE);
        }
    }

    public void update(final List<MedicineCase> medicineCases) throws DBException {
        try {
            MedicineCase medicineCase;
            String referent;
            for (MedicineCase m : medicineCases) {
                referent = m.getReferent();
                if (referent != null && !referent.isEmpty()) {
                    medicineCase = persistenceClient.getMC(m.getId());
                    if (medicineCase.getReferent() == null || !medicineCase.getReferent().equals(referent)) {
                        medicineCase.setReferent(referent);
                        toUtf(medicineCase);
                        persistenceClient.saveOrUpdateMC(medicineCase);
                    }
                }
            }
        } catch (Exception e) {
            LOG.error("Error updating case", e);
            throw new DBException(DBException.SAVE);
        }

    }

    public void deleteFile(final FileCase file) {
        persistenceClient.deleteFileCase(file);
    }

    public void update(MedicineCase medicineCase) throws DBException {
        toUtf(medicineCase);
        try {
            medicineCase.setPatient(persistenceClient.getPatient(medicineCase.getPatient().getId()));
            persistenceClient.saveOrUpdateMC(medicineCase);
        } catch (Exception e) {
            LOG.error("Error updating case", e);
            throw new DBException(DBException.SAVE);
        }
    }

    public List<Nation> getNations() {
        return persistenceClient.findAllNations("descriptionIt");
    }

    public List<Region> getRegions() {
        return persistenceClient.findAllRegions("description");
    }

    public List<Province> getProvince(final Region region) {
        List<Province> listProvince;
        if (region != null && region.getId() != null) {
            listProvince = persistenceClient.findByPropertyProvince("region.id", region.getId(), "description");
        } else {
            listProvince = new ArrayList<Province>();
        }
        return listProvince;
    }

    public List<Municipality> getMunicipality(final Province province) {
        List<Municipality> listMunicipality;
        if (province != null && province.getId() != null) {
            listMunicipality = persistenceClient.findByPropertyMunicipality("province.id", province.getId(),
                    "description");
        } else {
            listMunicipality = new ArrayList<Municipality>();
        }
        return listMunicipality;
    }

    public List<Education> getEducations() {
        return persistenceClient.findAllEducations("descriptionIt");
    }

    public List<Occupation> getOccupations() {
        return persistenceClient.findAllOccupations("descriptionIt");
    }

    public void delete(final MedicineCase medicineCase) throws DBException {
        try {

            Long entry = medicineCase.getWorkflow();
            persistenceClient.deleteByPropertyHistoryStep("jPAWorkflowEntry.id", entry);
            persistenceClient.deleteByPropertyCurrentStep("jPAWorkflowEntry.id", entry);
            persistenceClient.deleteByPropertyWorkflowEntry("id", entry);
            persistenceClient.deleteByPropertyMC("id", medicineCase.getId());
        } catch (Exception e) {
            LOG.error("Error deleting case", e);
            throw new DBException(DBException.DELETE);
        }
    }

    public List<Exam> getExamsOfMC(final Long medicineCaseId) {
        return persistenceClient.findByPropertyExams("medicineCase.id", medicineCaseId);
    }

    public List<FileCase> getFiles(final Long examId) {
        return persistenceClient.findByPropertyFileCase("exam.id", examId);
    }

    public List<MedicineCase> getForConfirm(final String username) {
        workflowManager.setCaller(username);
        List<Long> list = null;
        try {
            list = workflowManager.findWfByStatusOwner(WorkflowManager.STATUS_UNDERWAY);
        } catch (WorkflowException ex) {
            LOG.error("Error deleting case", ex);
        }
        return getCaseByLong(list);
    }

    private List<MedicineCase> getCaseByLong(final List<Long> list) {
        final List<MedicineCase> listCase = new ArrayList<MedicineCase>();
        if (list == null) {
            return listCase;
        }

        List<MedicineCase> tempList;
        for (Long i : list) {
            tempList = persistenceClient.findByPropertyMC("workflow", i);
            if (tempList != null && tempList.size() > 0) {
                listCase.add(tempList.get(0));
            }
        }
        return listCase;
    }

    public void confirm(final MedicineCase medicineCase, final String username, final long role) throws
            DBException {
        if (getExamsOfMC(medicineCase.getId()).isEmpty()) {
            throw new DBException(DBException.CASE_WITHOUT_EXAMS);
        }
        try {
            workflowManager.setCaller(username);
            workflowManager.setIdWorkflow(medicineCase.getWorkflow());
            workflowManager.doAction(WorkflowManager.ACTION_CONFIRM);

            String status = WorkflowManager.STATUS_QUEUED;
            final MedicineCase m = persistenceClient.getMC(medicineCase.getId());
            if (role == 2) {
                Map map = new HashMap();
                map.put("wfOwner", username);
                m.setReferent(username);
                workflowManager.doAction(WorkflowManager.ACTION_ASSIGN, map);
                workflowManager.doAction(WorkflowManager.ACTION_APPROVE, map);
                status = WorkflowManager.STATUS_APPROVED;
            } else {
                Date birthDate = medicineCase.getPatient().getBirthDate();
                GregorianCalendar gc = new GregorianCalendar();
                gc.setTime(new Date());
                gc.add(GregorianCalendar.YEAR, -YEARS);
                if (birthDate.after(gc.getTime())) {
                    List<User> list = persistenceClient.findByPropertyUsers("pediatrician", true);
                    if (list != null && list.size() > 0) {
                        User u = list.get(0);
                        m.setReferent(u.getUsername());
                        Map map = new HashMap();
                        map.put("wfOwner", m.getReferent());
                        workflowManager.doAction(WorkflowManager.ACTION_ASSIGN, map);
                        status = WorkflowManager.STATUS_ASSIGNED;
                    }
                }
            }

            m.setStatusWorkflow(status);
            persistenceClient.saveOrUpdateMC(m);

        } catch (Exception e) {
            if (e instanceof InvalidActionException) {
                LOG.error("Error confirming case: operation not allowed", e);
                throw new DBException(DBException.WFOP_NOT_ALLOWED);
            } else {
                LOG.error("Error confirming case", e);
                throw new DBException(DBException.SAVE);
            }
        }
    }

    public List<MedicineCase> getCaseAssigned() {
        return persistenceClient.getCaseAssignedMC();
    }

    public List<MedicineCase> findAssignedByCode(final String code) {
        final List<MedicineCase> list = getCaseAssigned();

        final List<MedicineCase> returnedList = new ArrayList<MedicineCase>();
        if (code == null) {
            return list;
        }

        final Iterator it = list.iterator();
        MedicineCase mc;

        while (it.hasNext()) {
            mc = (MedicineCase) it.next();
            if (code.equalsIgnoreCase(mc.getPatient().getSurname())) {
                returnedList.add(mc);
            } else if (code.equalsIgnoreCase(mc.getPatient().getTaxCode())) {
                returnedList.add(mc);
            }
        }
        return returnedList;
    }

    public List<MedicineCase> getAllCases(final String owner, final String referent) {
        List<MedicineCase> list = persistenceClient.findAllMC();

        if ("XOWNERX".equals(owner) && "XREFERENTX".equals(referent)) {
            return list;
        }

        final List<MedicineCase> returnedList = new ArrayList<MedicineCase>();

        Iterator it = list.iterator();
        MedicineCase mc;
        while (it.hasNext()) {
            mc = (MedicineCase) it.next();
            if (!"XOWNERX".equals(owner) && owner.equalsIgnoreCase(mc.getOwner())) {
                returnedList.add(mc);
            } else if (!"XREFERENT".equals(referent) && referent.equalsIgnoreCase(mc.getReferent())) {
                returnedList.add(mc);
            }
        }
        return returnedList;
    }

    public List<MedicineCase> findByCode(final String code, final String owner, final String referent) {
        if (code == null && "XOWNERX".equals(owner) && "XREFERENTX".equals(referent)) {
            return persistenceClient.findAllMC();
        }
        return persistenceClient.findBySurnameOrTcMC(code, owner, referent);
    }

    public List<MedicineCase> findByYearInterval(final String start, final String end) {
        return persistenceClient.findByYearIntervalMC(start, end);
    }

    public List<MedicineCase> getForWaitConfirm(String username) {
        return persistenceClient.getForWaitConfirmMC(username);
    }

    public List<MedicineCase> getForAssignReferent(final String username) {
        workflowManager.setCaller(username);
        List<Long> list = null;
        try {
            list = workflowManager.findWfByStatus(WorkflowManager.STATUS_QUEUED);
        } catch (WorkflowException ex) {
            LOG.error("Error deleting case", ex);
        }
        return getCaseByLong(list);
    }

    public List<MedicineCase> findForAssignedReferentByCode(final String code, final String username) {
        workflowManager.setCaller(username);
        List<Long> list = null;
        try {
            list = workflowManager.findWfByStatus(WorkflowManager.STATUS_QUEUED);
        } catch (WorkflowException ex) {
            LOG.error("Error deleting case", ex);
        }

        List<MedicineCase> mcList = getCaseByLong(list);

        Iterator it = mcList.iterator();
        MedicineCase mc;

        List<MedicineCase> returnedList = new ArrayList<MedicineCase>();
        if (code == null) {
            return mcList;
        }

        while (it.hasNext()) {
            mc = (MedicineCase) it.next();
            if (code.equalsIgnoreCase(mc.getPatient().getSurname())) {
                returnedList.add(mc);
            } else if (code.equalsIgnoreCase(mc.getPatient().getTaxCode())) {
                returnedList.add(mc);
            }
        }
        return returnedList;
    }

    public void assign(final MedicineCase medicineCase, final String username) throws DBException {
        if (medicineCase.getReferent() == null || medicineCase.getReferent().isEmpty()) {
            throw new DBException(DBException.ASSIGN);
        }
        try {

            workflowManager.setCaller(username);
            workflowManager.setIdWorkflow(medicineCase.getWorkflow());
            final Map map = new HashMap();
            map.put("wfOwner", medicineCase.getReferent());
            workflowManager.doAction(medicineCase.getWorkflow(), WorkflowManager.ACTION_ASSIGN, map);

            final MedicineCase m = persistenceClient.getMC(medicineCase.getId());
            m.setStatusWorkflow(WorkflowManager.STATUS_ASSIGNED);
            m.setReferent(medicineCase.getReferent());
            persistenceClient.saveOrUpdateMC(m);

        } catch (WorkflowException e) {
            LOG.error("Error deleting case", e);
            throw new DBException(DBException.CONFIRM);
        }
    }

    public List<MedicineCase> getRequestModifier(final String username) {
        return persistenceClient.getRequestModifierMC(username);
    }

    public List<MedicineCase> getForApprove(final String username) {
        workflowManager.setCaller(username);
        List<Long> list = null;
        try {
            list = workflowManager.findWfByStatusOwner(WorkflowManager.STATUS_ASSIGNED);
        } catch (WorkflowException ex) {
            LOG.error("Error deleting case", ex);
        }
        return getCaseByLong(list);
    }

    public void approve(MedicineCase medicineCase, String username)
            throws DBException {
        try {

            workflowManager.setCaller(medicineCase.getOwner());
            workflowManager.setIdWorkflow(medicineCase.getWorkflow());
            Map map = new HashMap();
            map.put("wfOwner", medicineCase.getOwner());
            workflowManager.doAction(WorkflowManager.ACTION_APPROVE, map);

            final MedicineCase m = persistenceClient.getMC(medicineCase.getId());
            m.setStatusWorkflow(WorkflowManager.STATUS_APPROVED);
            persistenceClient.saveOrUpdateMC(m);

        } catch (WorkflowException e) {
            LOG.error("Error deleting case", e);
            throw new DBException(DBException.SAVE);
        }
    }

    public void requestModifie(
            final MedicineCase medicineCase, final String username, final String reason) throws DBException {
        try {
            final MedicineCase m = persistenceClient.getMC(medicineCase.getId());
            m.setReason(reason);
            m.setStatusWorkflow(WorkflowManager.STATUS_UNDERWAY);
            persistenceClient.saveOrUpdateMC(m);

            workflowManager.setCaller(username);
            workflowManager.setIdWorkflow(medicineCase.getWorkflow());
            final Map map = new HashMap();
            map.put("wfOwner", medicineCase.getOwner());
            workflowManager.doAction(WorkflowManager.ACTION_REQUEST_MODIFIE, map);
        } catch (final WorkflowException e) {
            throw new DBException(DBException.SAVE);
        }
    }

    public void reject(final MedicineCase medicineCase, final String username, final String reason) throws DBException {
        try {
            final MedicineCase m = persistenceClient.getMC(medicineCase.getId());
            m.setStatusWorkflow(WorkflowManager.STATUS_REJECTED);
            m.setReason(reason);
            persistenceClient.saveOrUpdateMC(m);

            workflowManager.setCaller(username);
            workflowManager.setIdWorkflow(medicineCase.getWorkflow());
            final Map map = new HashMap();
            map.put("wfOwner", medicineCase.getOwner());
            workflowManager.doAction(WorkflowManager.ACTION_REJECT, map);
        } catch (final WorkflowException e) {
            throw new DBException(DBException.SAVE);
        }
    }

    public Date getLastActionForMC(final Long entryId) {
        LOG.debug("Search last action of entry {}", entryId);
        List<JPACurrentStep> list = persistenceClient.findCurrentStepForWorkflowEntry(entryId);
        if (list != null && list.size() > 0) {
            return list.get(0).getStartDate();
        }
        return null;
    }

    public void deleteExam(final Exam exam) {
        persistenceClient.deleteByPropertyExam("id", exam.getId());
    }

    private void toUtf(final MedicineCase medicineCase) {
        if (medicineCase.getMedicineDescription() != null) {
            medicineCase.setMedicineDescription(
                    Encoder.toUtf(medicineCase.getMedicineDescription()));
        }
        if (medicineCase.getReferent() != null) {
            medicineCase.setReferent(Encoder.toUtf(medicineCase.getReferent()));
        }

    }

    public int countCases() {
        return persistenceClient.countCases();
    }

    public int countStatusCases(final String status) {
        return persistenceClient.countStatusCases(status);
    }

    public void toExPP(final MedicineCase medicineCase) {
        persistenceClient.toExPP(medicineCase);
    }

    public List<MedicineCase> findExPP() {
        return persistenceClient.findExPP();
    }

    public List<MedicineCase> findAll() {
        return persistenceClient.findAllMC();
    }

    public int countExPP() {
        return persistenceClient.countExPP();
    }

    public Education findEducation(Long id) {
        return persistenceClient.findByIdEducation(id);
    }

    public Occupation findOccupation(long id) {
        return persistenceClient.findByIdOccupation(id);
    }

    public Municipality findMunicipality(long id) {
        return persistenceClient.findByIdMunicipality(id);
    }
}
