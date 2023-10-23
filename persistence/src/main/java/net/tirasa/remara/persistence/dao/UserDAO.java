package net.tirasa.remara.persistence.dao;

import java.util.List;
import net.tirasa.remara.persistence.data.User;

public interface UserDAO {

    public User saveOrUpdate(User user);

    public User getS(String username);

    public List<User> findByProperty(String propertyName, String value);

    public List<User> findByProperty(String propertyName, Object value);

    public List<User> findAll();

    public int deleteByProperty(String propertyName, Object value);
}
