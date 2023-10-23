package net.tirasa.remara.persistence.dao;

import static net.tirasa.remara.persistence.dao.AbstractDAOTest.LOG;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import net.tirasa.remara.persistence.data.Patient;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class PatientDAOTest extends AbstractDAOTest {

    @Autowired
    private PatientDAO patientDAO;

    @Autowired
    private EducationDAO educationDAO;

    @Autowired
    private OccupationDAO occupationDAO;

    @Autowired
    private MunicipalityDAO municipalityDAO;

    @Autowired
    private NationDAO nationDAO;

    @Autowired
    private ProvinceDAO provinceDAO;

    private SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");

    @Before
    public void populateDb() throws ParseException {
        Patient test = new Patient();
        Patient test2 = new Patient();
        Patient test4 = new Patient();
        test.setName("pippo");
        test.setTaxCode("PIPPO");
        test.setSurname("pippo");
        test.setForeigner("PIPPO");
        test.setFatherEducation(educationDAO.get(1L));
        test.setMotherOccupation(occupationDAO.get(1L));
        test.setBirthDate(f.parse("1981-01-15"));
        test.setBirthMunicipality(municipalityDAO.get(1L));
        test.setBirthNation(nationDAO.get(1L));
        test.setBirthProvince(provinceDAO.get("PE"));
        test2.setTaxCode("PLUTO");
        test2.setName("pluto");
        test2.setSurname("pluto");
        test2.setForeigner("PLUTO");
        test4.setTaxCode("PLUTO");
        test4.setName("pluto");
        test4.setSurname("pluto");
        test4.setForeigner("PLUTO");
        test4.setBirthDate(f.parse("1984-01-15"));
        patientDAO.saveOrUpdate(test);
        patientDAO.saveOrUpdate(test2);
        patientDAO.saveOrUpdate(test4);
    }

    @Test
    public void isNotNull() {
        assertNotNull(patientDAO);
    }

    @Test
    public void saveTest() {
        // create patient
        Patient test3 = new Patient();
        test3.setName("paperino");
        test3.setSurname("paperino");
        test3.setTaxCode("PAPERINO");
        test3.setForeigner("PAPERINO");
        assertNotNull(patientDAO.saveOrUpdate(test3));
        assertEquals(4, patientDAO.findAll().size());
        LOG.debug("PAZIENTE CREATO: {}", patientDAO.findByProperty("foreigner", "PAPERINO").
                get(0).getName());
        // update patient
        test3 = patientDAO.findByProperty("foreigner", "PAPERINO").get(0);
        test3.setTaxCode("PAPERONE");
        test3.setForeigner("PAPERONE");
        patientDAO.saveOrUpdate(test3);
        assertFalse(patientDAO.findByProperty("foreigner", "PAPERONE").isEmpty());
    }

    @Test
    public void findTest() {
        assertNotNull(patientDAO.findAll());
        Patient pippo = patientDAO.findByProperty("foreigner", "PIPPO").get(0);
        assertNotNull(pippo);
        assertNotNull(pippo.getBirthMunicipality());
        assertNotNull(pippo.getBirthNation());
        assertNotNull(pippo.getBirthProvince());
        assertNotNull(pippo.getFatherEducation());
        assertNotNull(pippo.getMotherOccupation());
        LOG.debug("MUNICIPIO PIPPO: " + pippo.getBirthMunicipality().getDescription());
        LOG.debug("NAZIONE PIPPO: " + pippo.getBirthNation().getInitials());
        LOG.debug("PROVINCIA PIPPO: " + pippo.getBirthProvince().getId());
        LOG.debug("EDUCAZIONE PAPA' PIPPO: " + pippo.getFatherEducation().getDescriptionIt());
        LOG.debug("OCCUPAZIONE MADRE PIPPO: " + pippo.getMotherOccupation().getDescriptionIt());
        LOG.debug("PAZIENTI TOTALI: {}", patientDAO.findAll().size());
        LOG.debug("PAZIENTE CERCATO: {}", patientDAO.findByProperty("foreigner", "PIPPO").get(0).getName());
        List<Patient> list = patientDAO.findByYearInterval("1981", "1985");
        assertNotNull(list);
        assertEquals(2, list.size());
    }

    @Test
    public void deleteTest() {
        int deleted;
        deleted = patientDAO.deleteByProperty("foreigner", "PLUTO");
        assertEquals(2, deleted);
        LOG.debug("PAZIENTI CANCELLATI: {}", deleted);
    }
}
