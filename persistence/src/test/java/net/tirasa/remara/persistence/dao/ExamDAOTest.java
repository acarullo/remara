package net.tirasa.remara.persistence.dao;

import static net.tirasa.remara.persistence.dao.AbstractDAOTest.LOG;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import net.tirasa.remara.persistence.data.Exam;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import net.tirasa.remara.persistence.data.HospitalWard;
import net.tirasa.remara.persistence.data.MedicineCase;
import net.tirasa.remara.persistence.data.Patient;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class ExamDAOTest extends AbstractDAOTest {

    @Autowired
    ExamDAO examDAO;

    @Autowired
    private MedicineCaseDAO medicineCaseDAO;

    @Autowired
    IllnessDAO illnessDAO;

    @Autowired
    NationDAO nationDAO;

    @Autowired
    HospitalOrganizationDAO hospitalOrganizationDAO;

    @Autowired
    HospitalWardDAO hospitalWardDAO;

    @Autowired
    RegionDAO regionDAO;

    @Autowired
    PatientDAO patientDAO;

    @Autowired
    EducationDAO educationDAO;

    @Autowired
    ProvinceDAO provinceDAO;

    @Autowired
    OccupationDAO occupationDAO;

    @Autowired
    MunicipalityDAO municipalityDAO;

    SimpleDateFormat f = new SimpleDateFormat("dd-MMM-yyyy");

    @Before
    public void populateDb() throws ParseException {
        MedicineCase medicineCaseTest = new MedicineCase();
        medicineCaseTest.setOwner("pippo");
        medicineCaseTest.setIllness(illnessDAO.get(1L));
        medicineCaseTest.setNation(nationDAO.get(1L));
        medicineCaseTest.setExactlyIllness("exactIllness");
        medicineCaseTest.setDiagnosisDateIllness(f.parse(f.format(new Date())));
        medicineCaseTest.setInsertDate(f.parse(f.format(new Date())));
        HospitalOrganization hospitalOrganization = new HospitalOrganization();
        hospitalOrganization.setName("hospital organization 3");
        hospitalOrganization.setRegion(regionDAO.get(1L));
        hospitalOrganization.setCode("code 3");
        Set<HospitalWard> hwset = new HashSet<>();
        hospitalOrganization.setHospitalWards(hwset);
        hospitalOrganizationDAO.saveOrUpdate(hospitalOrganization);
        Patient patient = new Patient();
        patient.setName("pippo");
        patient.setTaxCode("PIPPO");
        patient.setSurname("pippo");
        patient.setForeigner("PIPPO");
        patient.setFatherEducation(educationDAO.get(1L));
        patient.setMotherOccupation(occupationDAO.get(1L));
        patient.setBirthMunicipality(municipalityDAO.get(1L));
        patient.setBirthNation(nationDAO.get(1L));
        patient.setBirthProvince(provinceDAO.get("PE"));
        patientDAO.saveOrUpdate(patient);
        medicineCaseTest.
                setHospitalOrganization(hospitalOrganizationDAO.findByProperty("code", "code 3", "code").get(0));
        medicineCaseTest.setPatient(patientDAO.findByProperty("foreigner", "PIPPO").get(0));
        medicineCaseTest.setForeigner("foreigner NEL POPULATE");

        Exam examTest = new Exam();
        Exam examTest2 = new Exam();
        examTest.setDescription("exam 1");
        examTest.setMedicineCase(medicineCaseTest);
        examTest2.setDescription("exam 2");
        examTest2.setMedicineCase(medicineCaseTest);
        List<Exam> exams = new ArrayList<>();
        exams.add(examTest);
        exams.add(examTest2);
        medicineCaseTest.setExams(exams);
        medicineCaseTest.setExPp(false);
        medicineCaseDAO.saveOrUpdate(medicineCaseTest);
    }

    @Test
    public void isNotNull() {
        assertNotNull(examDAO);
    }

    @Test
    public void findTest() {
        assertNotNull(examDAO.findByProperty("description", "exam 1"));
        LOG.debug("EXAM CERCATO: {}", examDAO.findByProperty("description", "exam 2").get(0).getId());
    }

    @Test
    public void deleteTest() {
        int deleted = examDAO.deleteByProperty("description", "exam 1");
        assertEquals(1, deleted);
        LOG.debug("EXAM CANCELLATI: {}", deleted);
    }
}
