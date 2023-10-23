package net.tirasa.remara.core.management;

import net.tirasa.remara.core.exception.DBException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import net.tirasa.remara.core.clients.PersistenceClient;
import net.tirasa.remara.persistence.data.Role;
import net.tirasa.remara.persistence.data.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class UserManagement {

    @Autowired
    private PersistenceClient persistenceClient;

    private static final Logger LOG = LoggerFactory.getLogger(UserManagement.class);

    public User getUser(final String username) {
        User user = null;
        List<User> list = persistenceClient.findByPropertyUsers("username", username);
        if (list != null && list.size() > 0) {
            user = list.get(0);
        }
        return user;
    }

    public List<User> getAllUsers() {
        return persistenceClient.findAllUsers();
    }
    
    public List<String> getReferents() {
        final List<User> list = persistenceClient.findByPropertyUsers("role.id", 2);
        final List<String> result = new ArrayList<String>();
        for (User u : list) {
            result.add(u.getUsername());
        }
        return result;
    }

    public void insert(User user) throws DBException {
        toUtf(user);
        user.setUsername(user.getUsername().toUpperCase());
        List<User> list = persistenceClient.findByPropertyUsers("username", user.getUsername());
        if (list != null && list.size() > 0) {
            throw new DBException(DBException.ELEMENT_EXIST);
        }
        if (user.getPediatrician()) {
            list = persistenceClient.findByPropertyUsers("pediatrician", true);
            if (list != null && list.size() > 0) {
                throw new DBException(DBException.USER_PEDIATRICIAN_EXIST);
            }
        }
        user.setPassword(createPassword());
        user.setUsername(user.getUsername().toUpperCase());
        user.setName(user.getName().toUpperCase());
        user.setSurname(user.getSurname().toUpperCase());
        user.setEmail(user.getEmail().toUpperCase());
        user.setPediatrician(user.getPediatrician());
        if (user.getHospitalOrganization() != null) {
            user.setHospitalOrganization(user.getHospitalOrganization().toUpperCase());
        }
        if (user.getHospitalWard() != null) {
            user.setHospitalWard(user.getHospitalWard().toUpperCase());
        }
        if (user.getAddress() != null) {
            user.setAddress(user.getAddress().toUpperCase());
        }
        user.setUsername(user.getUsername().toUpperCase());
        persistenceClient.saveOrUpdateUser(user);
    }

    public void update(final User user) throws DBException {
        toUtf(user);
        List<User> list;
        if (user.getPediatrician()) {
            list = persistenceClient.findByPropertyUsers("pediatrician", true);
            for (User u : list) {
                if (!u.getUsername().equals(user.getUsername())) {
                    throw new DBException(DBException.USER_PEDIATRICIAN_EXIST);
                }
            }
        }
        final Long roleId = user.getRole().getId();
        final User u = persistenceClient.getSUser(user.getUsername());
        final Role role = persistenceClient.getRole(roleId);
        u.setName(user.getName().toUpperCase());
        u.setSurname(user.getSurname().toUpperCase());
        u.setRole(role);
        u.setEmail(user.getEmail().toUpperCase());
        if (user.getPediatrician() != null) {
            u.setPediatrician(user.getPediatrician());
        }
        if (user.getHospitalOrganization() != null) {
            u.setHospitalOrganization(user.getHospitalOrganization().toUpperCase());
        }
        if (user.getHospitalWard() != null) {
            u.setHospitalWard(user.getHospitalWard().toUpperCase());
        }
        if (user.getAddress() != null) {
            u.setAddress(user.getAddress().toUpperCase());
        }
        if (!user.getPassword().equals(u.getPassword())) {
            LOG.debug("Updating user password! for user {}", user.getUsername());
            u.setPassword(user.getPassword());
        }
        persistenceClient.saveOrUpdateUser(u);
    }

    public void delete(final User user) {
        persistenceClient.deleteByPropertyUser("username", user.getUsername());

    }

    public String resetPassword(final User user) {
        String password = createPassword();
        User u = persistenceClient.getSUser(user.getUsername());
        u.setPassword(password);
        persistenceClient.saveOrUpdateUser(u);
        return password;
    }

    static final String ALFANUMERICS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    static final int LEN_PASSWORD = 8;

    public String createPassword() {
        final Random r = new Random();
        StringBuilder sb = new StringBuilder();
        Integer n;
        for (int i = 0; i < LEN_PASSWORD; i++) {
            n = r.nextInt(ALFANUMERICS.length());
            sb.append(ALFANUMERICS.charAt(n));
        }
        return sb.toString();
    }

    private void toUtf(final User user) {
        if (user.getAddress() != null) {
            user.setAddress(Encoder.toUtf(user.getAddress()));
        }
        user.setName(Encoder.toUtf(user.getName()));
        user.setSurname(Encoder.toUtf(user.getSurname()));
    }
}
