package net.tirasa.remara.persistence.dao;

import static net.tirasa.remara.persistence.dao.AbstractDAOTest.LOG;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class NationDAOTest extends AbstractDAOTest {

    @Autowired
    private NationDAO nationDAO;

    @Test
    public void isNotNull() {
        Assert.assertNotNull(nationDAO);
    }

    @Test
    public void findTest() {
        Assert.assertNotNull(nationDAO.findAll("descriptionEn"));
        Assert.assertEquals(1, nationDAO.findAll("descriptionEn").size());
        LOG.debug("NAZIONE CERCATA: {}", nationDAO.findAll("descriptionEn").get(0).getInitials());
        Assert.assertNotNull(nationDAO.get(1L));
        LOG.debug("NAZIONE CERCATA CON GET: {}", nationDAO.get(1L).getInitials());
    }
}
