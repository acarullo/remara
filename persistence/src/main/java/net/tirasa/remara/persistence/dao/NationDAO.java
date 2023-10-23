package net.tirasa.remara.persistence.dao;

import java.util.List;
import net.tirasa.remara.persistence.data.Nation;

public interface NationDAO {

    public Nation saveOrUpdate(Nation nation);

    public List<Nation> findAll(String fieldOrder);

    public Nation get(Long id);
}
