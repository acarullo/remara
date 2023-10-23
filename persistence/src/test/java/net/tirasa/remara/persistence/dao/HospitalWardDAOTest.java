package net.tirasa.remara.persistence.dao;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;
import net.tirasa.remara.persistence.data.HospitalWard;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class HospitalWardDAOTest extends AbstractDAOTest {

    @Autowired
    HospitalWardDAO hospitalWardDAO;

    @Test
    public void isNotNull() {
        assertNotNull(hospitalWardDAO);
    }

    @Test
    @Ignore
    public void findTest() {
        HospitalWard test = new HospitalWard();
        HospitalWard test2 = new HospitalWard();
        test.setName("hospital ward 1");
        test2.setName("hospital ward 2");
        hospitalWardDAO.saveOrUpdate(test);
        hospitalWardDAO.saveOrUpdate(test2);
        List<HospitalWard> list = hospitalWardDAO.findAll();
        assertTrue(!list.isEmpty());
        assertNotNull(hospitalWardDAO.findByProperty("name", "hospital ward 1", "name").get(0).getName());
        LOG.debug("HOSPITAL WARD TOTALI: {}", hospitalWardDAO.findAll().size());
        LOG.debug("HOSPITAL WARD CERCATO: {}", hospitalWardDAO.findByProperty("name", "hospital ward 1", "name").get(0).
                getName());
    }
}
