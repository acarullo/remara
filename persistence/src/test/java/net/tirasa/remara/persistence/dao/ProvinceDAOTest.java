package net.tirasa.remara.persistence.dao;

import static net.tirasa.remara.persistence.dao.AbstractDAOTest.LOG;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class ProvinceDAOTest extends AbstractDAOTest {

    @Autowired
    private ProvinceDAO provinceDAO;

    @Test
    public void isNotNull() {
        assertNotNull(provinceDAO);
    }

    @Test
    public void findTest() {
        assertNotNull(provinceDAO.findByProperty("id", "PE", "description"));
        assertEquals(1, provinceDAO.findByProperty("id", "PE", "description").size());
        assertEquals(1, provinceDAO.findByProperty("numMunicipalities", 4, "description").size());
        LOG.debug("PROVINCIA CERCATA: {}", provinceDAO.findByProperty("numMunicipalities", 4, "description").get(0).
                getDescription());
        LOG.debug("PROVINCIA CERCATA: {}", provinceDAO.findByProperty("id", "PE", "description").get(0).
                getDescription());
        assertNotNull(provinceDAO.get("PE"));
        LOG.debug("PROVINCIA CERCATA CON GET: {}", provinceDAO.get("PE").getDescription());
    }
}
