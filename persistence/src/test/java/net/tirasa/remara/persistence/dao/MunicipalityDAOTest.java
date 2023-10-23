package net.tirasa.remara.persistence.dao;

import static net.tirasa.remara.persistence.dao.AbstractDAOTest.LOG;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class MunicipalityDAOTest extends AbstractDAOTest {

    @Autowired
    private MunicipalityDAO municipalityDAO;

    @Test
    public void isNotNull() {
        assertNotNull(municipalityDAO);
    }

    @Test
    public void findTest() {
        assertNotNull(municipalityDAO.findByProperty("id", 1, "description"));
        assertEquals(1, municipalityDAO.findByProperty("id", 1, "description").size());
        assertEquals(1, municipalityDAO.findByProperty("cadastre", "PESCARA", "description").size());
        LOG.debug("MUNICIPIO CERCATO: {}", municipalityDAO.findByProperty("cadastre", "PESCARA", "description").get(0).
                getDescription());
        LOG.debug("MUNICIPIO CERCATO: {}", municipalityDAO.findByProperty("id", 1, "description").get(0).
                getDescription());
        assertNotNull(municipalityDAO.get(1L));
        LOG.debug("MUNICIPIO CERCATO CON GET: {}", municipalityDAO.get(1L).getDescription());
    }
}
