package net.tirasa.remara.persistence.utilities;

import java.io.IOException;
import net.tirasa.remara.persistence.dao.AbstractDAOTest;
import net.tirasa.remara.persistence.dao.RoleDAO;
import net.tirasa.remara.persistence.dao.UserDAO;
import net.tirasa.remara.persistence.data.Role;
import net.tirasa.remara.persistence.data.User;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class EncryptionTest extends AbstractDAOTest {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private RoleDAO roleDAO;

    private final JasyptMethods jasyptMethods = JasyptMethods.getJasyptMethods();

    @Test
    public void notNullJasyptMethods() {
        Assert.assertNotNull(jasyptMethods);
    }

    @Test
    public void EncDecTest() throws IOException {
        String encrypted = jasyptMethods.encrypt("PIPPO");
        Assert.assertEquals("PIPPO", jasyptMethods.decrypt(encrypted));
        User user = new User();
        user.setUsername("PIPPO");
        user.setPassword("password");
        user.setRole(roleDAO.saveOrUpdate(new Role()));
        userDAO.saveOrUpdate(user);
        Assert.assertEquals("password", userDAO.getS("PIPPO").getPassword());
        userDAO.deleteByProperty("username", "PIPPO");
    }

    @Test
    public void sameEncryptString() {
        String encrypted_old = jasyptMethods.encrypt("PIPPO");
        String encrypted_new = "";
        for (int i = 0; i < 1000; i++) {
            encrypted_new = jasyptMethods.encrypt("PIPPO");
            Assert.assertEquals(encrypted_old, encrypted_new);
        }
        String old = jasyptMethods.decrypt(encrypted_old);
        String news = jasyptMethods.decrypt(encrypted_new);
        Assert.assertEquals(old, news);
    }
}
