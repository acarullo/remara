package net.tirasa.remara.persistence.dao;

import static net.tirasa.remara.persistence.dao.AbstractDAOTest.LOG;
import static org.junit.Assert.*;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class RegionDAOTest extends AbstractDAOTest {

    @Autowired
    private RegionDAO regionDAO;

    @Test
    public void isNotNull() {
        assertNotNull(regionDAO);
    }

    @Test
    public void findTest() {
        assertNotNull(regionDAO.findAll());
        assertEquals(1, regionDAO.findAll().size());
        assertNotNull(regionDAO.get(1L));
        LOG.debug("REGIONE CERCATA: {}", regionDAO.findAll().get(0).getDescription());
        LOG.debug("REGIONE CERCATA CON GET: {}", regionDAO.get(1L).getDescription());
    }
}
