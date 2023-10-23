package net.tirasa.remara.persistence.dao;

import static org.junit.Assert.assertNotNull;

import net.tirasa.remara.persistence.data.Role;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class RoleDAOTest extends AbstractDAOTest {

    @Autowired
    private RoleDAO roleDAO;

    @Before
    public void populateDb() {
        Role role = new Role();
        role.setDescription("ciao");
        roleDAO.saveOrUpdate(role);
    }

    @Test
    public void isNotNull() {
        assertNotNull(roleDAO);
    }

    @Test
    public void saveTest() {
        Role role = new Role();
        role.setDescription("ciao");
        assertNotNull(roleDAO.saveOrUpdate(role));
        LOG.debug("RUOLO SALVATO: {}", roleDAO.findAll().get(0).getDescription());
    }

    @Test
    public void findTest() {
        assertNotNull(roleDAO.findAll().get(0));
        LOG.debug("RUOLO CERCATO: {}", roleDAO.findAll().get(0).getDescription());
    }
}
