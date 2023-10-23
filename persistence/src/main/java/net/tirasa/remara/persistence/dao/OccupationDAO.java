package net.tirasa.remara.persistence.dao;

import java.util.List;
import net.tirasa.remara.persistence.data.Occupation;

public interface OccupationDAO {

    public Occupation saveOrUpdate(Occupation occupation);

    public List<Occupation> findAll(String fieldOrder);

    public Occupation get(Long id);
}
