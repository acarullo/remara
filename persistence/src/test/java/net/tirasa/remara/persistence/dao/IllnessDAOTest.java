package net.tirasa.remara.persistence.dao;

import static net.tirasa.remara.persistence.dao.AbstractDAOTest.LOG;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class IllnessDAOTest extends AbstractDAOTest {

    @Autowired
    private IllnessDAO illnessDAO;

    @Test
    public void isNotNull() {
        assertNotNull(illnessDAO);
    }

    @Test
    public void findTest() {
        assertNotNull(illnessDAO.findByProperty("id", 1));
        assertNotNull(illnessDAO.findByProperty("marche", true));
        assertNotNull(illnessDAO.findByProperty("description", "illness test"));
        assertNotNull(illnessDAO.findByCode("illness test 2", 5));
        LOG.debug("MALATTIA CERCATA: {}", illnessDAO.findByCode("illness test 2", 5).get(0).getId());
        LOG.debug("MALATTIA CERCATA: {}", illnessDAO.findByProperty("id", 1).get(0).getId());
        LOG.debug("MALATTIA CERCATA: {}", illnessDAO.findByProperty("marche", true).get(0).getId());
        LOG.debug("MALATTIA CERCATA: {}", illnessDAO.findByProperty("description", "illness test").get(0).getId());
        assertNotNull(illnessDAO.get(1L));
        LOG.debug("MALATTIA CERCATA CON GET: {}", illnessDAO.get(1L).getDescription());
        assertNotNull(illnessDAO.findAll());
        assertEquals(2, illnessDAO.findAll().size());
    }

    @Test
    public void deleteTest() {
        int deleted = illnessDAO.deleteByProperty("id", 1);
//        int deleted = illnessDAO.deleteByProperty("marche", true);
//        int deleted = illnessDAO.deleteByProperty("description", "illness test");
        assertEquals(1, deleted);
        LOG.debug("MALATTIE CANCELLATE: {}", deleted);
    }
}
