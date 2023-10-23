package net.tirasa.remara.persistence.dao;

import static net.tirasa.remara.persistence.dao.AbstractDAOTest.LOG;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import net.tirasa.remara.persistence.data.Exam;
import net.tirasa.remara.persistence.data.FileCase;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import net.tirasa.remara.persistence.data.HospitalWard;
import net.tirasa.remara.persistence.data.MedicineCase;
import net.tirasa.remara.persistence.data.Patient;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class FileCaseDAOTest extends AbstractDAOTest {

    @Autowired
    FileCaseDAO fileCaseDAO;

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
        try {
            File file = File.createTempFile("tmp", ".txt", new File("/tmp"));

            file.deleteOnExit();

            FileInputStream fis = new FileInputStream(file);

            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            byte[] buf = new byte[1024];
            try {
                for (int readNum; (readNum = fis.read(buf)) != -1;) {
                    //Writes to this byte array output stream
                    bos.write(buf, 0, readNum);
                }
            } catch (IOException ex) {
                LOG.error("Error", ex);
            }

            byte[] bytes = bos.toByteArray();

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
            medicineCaseTest.setHospitalOrganization(hospitalOrganizationDAO.findByProperty("code", "code 3", "code").
                    get(0));
            medicineCaseTest.setPatient(patientDAO.findByProperty("foreigner", "PIPPO").get(0));
            medicineCaseTest.setForeigner("foreigner NEL POPULATE");

            FileCase testFileCase = new FileCase();
            FileCase testFileCase2 = new FileCase();
            Exam exam1 = new Exam();
            exam1.setDescription("exam 1");
            exam1.setMedicineCase(medicineCaseTest);
            List<Exam> exams = new ArrayList<>();
            exams.add(exam1);
            medicineCaseTest.setExams(exams);
            medicineCaseTest.setExPp(false);
            medicineCaseDAO.saveOrUpdate(medicineCaseTest);
            testFileCase.setName("file case");
            testFileCase.setFile(bytes);
            testFileCase.setExam(examDAO.findByProperty("description", "exam 1").get(0));
            testFileCase2.setName("file case");
            testFileCase2.setExam(examDAO.findByProperty("description", "exam 1").get(0));
            testFileCase2.setFile(bytes);
            fileCaseDAO.saveOrUpdate(testFileCase);
            fileCaseDAO.saveOrUpdate(testFileCase2);
        } catch (IOException e) {
            LOG.error("ERRORE NELL'ENCRYPT DEL FILE", e);
        }
    }

    @Test
    public void isNotNull() {
        assertNotNull(fileCaseDAO);
    }

    @Test
    public void findTest() {
        assertNotNull(fileCaseDAO.findByProperty("name", "file case").get(0).getExam());
        LOG.debug("ESAME DI FILE CASE: " + fileCaseDAO.findByProperty("name", "file case").get(0).getExam().
                getDescription());
        assertNotNull(fileCaseDAO.findByProperty("name", "file case"));
        LOG.debug("FILE CASE CERCATO: {}", fileCaseDAO.findByProperty("name", "file case").get(0).getName());
    }

    @Test
    public void deleteTest() {
        int deleted = fileCaseDAO.deleteByProperty("name", "file case");
        assertEquals(2, deleted);
        LOG.debug("FILE CASE CANCELLATI: {}", deleted);
    }
}
