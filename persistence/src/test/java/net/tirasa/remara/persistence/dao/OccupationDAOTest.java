package net.tirasa.remara.persistence.dao;

import static net.tirasa.remara.persistence.dao.AbstractDAOTest.LOG;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class OccupationDAOTest extends AbstractDAOTest {

    @Autowired
    private OccupationDAO occupationDAO;

    @Test
    public void isNotNull() {
        Assert.assertNotNull(occupationDAO);
    }

    @Test
    public void findTest() {
        Assert.assertNotNull(occupationDAO.findAll("descriptionEn"));
        Assert.assertNotNull(occupationDAO.get(1L));
        Assert.assertEquals("first occupation", occupationDAO.get(1L).getDescriptionEn());
        Assert.assertEquals(1, occupationDAO.findAll("descriptionEn").size());
        LOG.debug("OCCUPAZIONE CERCATA: {}", occupationDAO.findAll("descriptionEn").get(0).getDescriptionIt());
        Assert.assertNotNull(occupationDAO.get(1L));
        LOG.debug("OCCUPAZIONE CERCATA CON GET: {}", occupationDAO.get(1L).getDescriptionIt());
    }
}
