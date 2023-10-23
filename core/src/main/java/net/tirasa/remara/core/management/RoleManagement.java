package net.tirasa.remara.core.management;

import java.util.List;
import net.tirasa.remara.core.clients.PersistenceClient;
import net.tirasa.remara.persistence.data.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class RoleManagement {

    @Autowired
    private PersistenceClient persistenceClient;

    public List<Role> getRolesList() {
        return persistenceClient.findAllRoles();
    }
}
