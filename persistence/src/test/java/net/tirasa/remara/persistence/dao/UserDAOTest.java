package net.tirasa.remara.persistence.dao;

import static net.tirasa.remara.persistence.dao.AbstractDAOTest.LOG;
import static org.junit.Assert.*;

import net.tirasa.remara.persistence.data.Role;
import net.tirasa.remara.persistence.data.User;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class UserDAOTest extends AbstractDAOTest {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private RoleDAO roleDAO;

    @Before
    public void populateDb() {
        User test = new User();
        User test2 = new User();
        test.setUsername("pippo");
        test.setPassword("password");
        test2.setPassword("password");
        test.setName("pippo");
        test.setEmail("pippo");
        test.setRole(roleDAO.saveOrUpdate(new Role()));
        test2.setUsername("pluto");
        test2.setName("pippo");
        test2.setEmail("pippo");
        test2.setRole(roleDAO.findAll().get(0));
        userDAO.saveOrUpdate(test);
        userDAO.saveOrUpdate(test2);
    }

    @Test
    public void isNotNull() {
        assertNotNull(userDAO);
    }

    @Test
    public void saveTest() {
        // create user
        User test = new User();
        test.setUsername("test paperino");
        test.setRole(roleDAO.findAll().get(0));
        test.setPassword("password");
        assertNotNull(userDAO.saveOrUpdate(test));
        assertEquals(3, userDAO.findAll().size());

        assertNotNull(userDAO.getS("TEST PAPERINO"));
        LOG.debug("UTENTE CREATO: {}", userDAO.getS("TEST PAPERINO").getUsername());
        // update user
        test = userDAO.getS("TEST PAPERINO");
        test.setName("pluto");
        userDAO.saveOrUpdate(test);
        assertFalse(userDAO.findByProperty("name", "pluto").isEmpty());
    }

    @Test
    public void findTest() {
        assertNotNull(userDAO.findAll());
        assertNotNull(userDAO.findByProperty("username", "pippo").get(0).getRole());
        LOG.debug("RUOLO DI PIPPO: " + userDAO.findByProperty("username", "pippo").get(0).getRole().getDescription());
        LOG.debug("UTENTI TOTALI: {}", userDAO.findAll().size());
        LOG.debug("UTENTE CERCATO: {}", userDAO.findByProperty("username", "pippo").get(0).getUsername());
        LOG.debug("PASSWORD DELL'UTENTE CERCATO: {}", userDAO.findByProperty("username", "pippo").get(0).getPassword());
    }

    @Test
    public void deleteTest() {
        int deleted = userDAO.deleteByProperty("username", "pippo");
        assertEquals(1, deleted);
        LOG.debug("UTENTI CANCELLATI: {}", deleted);
    }
}
