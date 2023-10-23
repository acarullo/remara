package net.tirasa.remara.persistence.dao;

import static net.tirasa.remara.persistence.dao.AbstractDAOTest.LOG;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import net.tirasa.remara.persistence.data.MedicineCase;
import net.tirasa.remara.persistence.data.Patient;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class MedicineCaseDAOTest extends AbstractDAOTest {

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
        MedicineCase test = new MedicineCase();
        test.setOwner("pippo");
        test.setIllness(illnessDAO.get(1L));
        test.setNation(nationDAO.get(1L));
        test.setExactlyIllness("exactIllness");
        test.setDiagnosisDateIllness(f.parse(f.format(new Date())));
        test.setInsertDate(f.parse(f.format(new Date())));
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
        test.setPatient(patientDAO.findByProperty("foreigner", "PIPPO").get(0));
        test.setForeigner("foreigner NEL POPULATE");
        medicineCaseDAO.saveOrUpdate(test);
    }

    @Test
    public void isNotNull() {
        assertNotNull(medicineCaseDAO);
    }

    @Test
    public void saveTest() throws ParseException {
        // create medicine case
        MedicineCase test = new MedicineCase();
        test.setMedicineDescription("medicine case test 3");
        test.setExactlyIllness("exactIllness");
        test.setPatient(patientDAO.findByProperty("foreigner", "PIPPO").get(0));
        test.setDiagnosisDateIllness(f.parse(f.format(new Date())));
        test.setForeigner("foreigner NEL SAVE");
        test.setInsertDate(f.parse(f.format(new Date())));
        test.setIllness(illnessDAO.get(1L));
        assertNotNull(medicineCaseDAO.saveOrUpdate(test));
        assertEquals(2, medicineCaseDAO.findAll().size());
        LOG.debug("MEDICINE CASE CREATO: {}", medicineCaseDAO.findAll().get(1));
    }

    @Test
    public void findTest() {
        assertNotNull(medicineCaseDAO.findAll());
        LOG.debug("MEDICINE CASE TOTALI: {}", medicineCaseDAO.findAll().size());
    }

    @Test
    public void deleteTest() {
        int deleted = medicineCaseDAO.deleteByProperty("owner", "pippo");
        assertEquals(1, deleted);
        LOG.debug("MEDICINE CASE CANCELLATI: {}", deleted);
    }
}
