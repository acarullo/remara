package net.tirasa.remara.core.management;

import java.util.List;
import net.tirasa.remara.core.clients.PersistenceClient;
import net.tirasa.remara.persistence.data.Region;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class RegionsManagement {

    @Autowired
    private PersistenceClient persistenceClient;

    public List<Region> getRegionsList() {
        return persistenceClient.findAllRegions();
    }
}
