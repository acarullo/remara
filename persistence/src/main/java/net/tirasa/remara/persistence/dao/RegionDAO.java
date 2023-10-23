package net.tirasa.remara.persistence.dao;

import java.util.List;
import net.tirasa.remara.persistence.data.Region;

public interface RegionDAO {
    
    public Region saveOrUpdate(Region region);

    public List<Region> findAll();
    
    public List<Region> findAll(String fieldOrder);

    public Region get(Long id);
}
