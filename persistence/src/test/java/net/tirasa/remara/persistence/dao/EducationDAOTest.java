package net.tirasa.remara.persistence.dao;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class EducationDAOTest extends AbstractDAOTest {

    @Autowired
    private EducationDAO educationDAO;

    @Test
    public void isNotNull() {
        Assert.assertNotNull(educationDAO);
    }

    @Test
    public void findTest() {
        Assert.assertNotNull(educationDAO.findAll("descriptionEn"));
        Assert.assertNotNull(educationDAO.findAll("descriptionEn").get(0));
        Assert.assertEquals("first education", educationDAO.findAll("descriptionEn").get(0).getDescriptionEn());
        Assert.assertEquals(2, educationDAO.findAll("descriptionEn").size());
        LOG.debug("EDUCAZIONE CERCATA: {}", educationDAO.findAll("descriptionEn").get(0).getDescriptionIt());
        Assert.assertNotNull(educationDAO.findAll("descriptionEn").get(0));
        LOG.debug("EDUCAZIONE CERCATA CON GET: {}", educationDAO.findAll("descriptionEn").get(0).getDescriptionIt());
    }
}
