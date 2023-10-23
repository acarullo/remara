package net.tirasa.remara.persistence.dao;

import java.util.List;
import net.tirasa.remara.persistence.data.Export;

public interface ExportDAO {

    public Export saveOrUpdate(Export export);

    public Export find(long id);

    public List<Export> findAll();

    public void delete(Export export);
}
