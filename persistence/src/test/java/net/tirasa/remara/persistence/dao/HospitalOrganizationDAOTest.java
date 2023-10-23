package net.tirasa.remara.persistence.dao;

import static net.tirasa.remara.persistence.dao.AbstractDAOTest.LOG;
import static org.junit.Assert.assertNotNull;

import java.util.HashSet;
import java.util.Set;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import net.tirasa.remara.persistence.data.HospitalWard;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class HospitalOrganizationDAOTest extends AbstractDAOTest {

    @Autowired
    HospitalOrganizationDAO hospitalOrganizationDAO;

    @Autowired
    HospitalWardDAO hospitalWardDAO;

    @Autowired
    RegionDAO regionDAO;

    @Before
    public void populateDb() {
        HospitalOrganization test = new HospitalOrganization();
        HospitalOrganization test2 = new HospitalOrganization();
//        HospitalWard hospitalWard1 = new HospitalWard();
//        hospitalWard1.setHospitalOrganization(test);
//        hospitalWard1.setName("hw linked");
//        hospitalWardDAO.saveOrUpdate(hospitalWard1);
//        Set<HospitalWard> hwset = new HashSet<>();
//        hwset.add(hospitalWard1);
//        test.setHospitalWards(hwset);
        test.setName("hospital organization 1");
        test.setRegion(regionDAO.get(1L));
        test.setCode("code 1");
        test2.setName("hospital organization 2");
        test2.setRegion(regionDAO.get(1L));
        test2.setCode("code 2");
//        test2.setHospitalWards(hwset);
        hospitalOrganizationDAO.saveOrUpdate(test);
        hospitalOrganizationDAO.saveOrUpdate(test2);
    }

    @Test
    public void isNotNull() {
        assertNotNull(hospitalOrganizationDAO);
    }

    @Test
    public void findTest() {
        assertNotNull(hospitalOrganizationDAO.findAll());
        assertNotNull(hospitalOrganizationDAO.findByProperty("name", "hospital organization 1", "name").get(0).getName());
        assertNotNull(hospitalOrganizationDAO.findByProperty("name", "hospital organization 1", "name").get(0).
                getRegion());
        assertNotNull(hospitalOrganizationDAO.findByProperty("name", "hospital organization 1", "name").get(0).
                getHospitalWards());
        LOG.debug("REGIONE DI HOSPITAL: "
                + hospitalOrganizationDAO.findByProperty("name", "hospital organization 1", "name").get(0).
                getRegion().getDescription());
        assertNotNull(hospitalOrganizationDAO.getRegions());
        LOG.debug("REGIONI TOTALI DI HOSPITAL: " + hospitalOrganizationDAO.getRegions().size());
        LOG.debug("HOSPITAL ORGANIZATION TOTALI: {}", hospitalOrganizationDAO.findAll().size());
        LOG.debug("HOSPITAL ORGANIZATION CERCATO: {}", hospitalOrganizationDAO.findByProperty("name",
                "hospital organization 1", "name").get(0).getName());
    }
}
