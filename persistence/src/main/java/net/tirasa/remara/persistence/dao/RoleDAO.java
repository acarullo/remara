package net.tirasa.remara.persistence.dao;

import java.util.List;
import net.tirasa.remara.persistence.data.Role;

public interface RoleDAO {

    public Role saveOrUpdate(Role role);

    public List<Role> findAll();

    public Role get(Long id);
}
