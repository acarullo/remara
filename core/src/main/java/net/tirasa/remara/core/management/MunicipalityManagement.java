package net.tirasa.remara.core.management;

import net.tirasa.remara.core.clients.PersistenceClient;
import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.persistence.data.Municipality;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.slf4j.Logger;

import java.util.List;

@Component
public class MunicipalityManagement {

    private static final Logger LOG = LoggerFactory.getLogger(MunicipalityManagement.class);

    @Autowired
    private PersistenceClient persistenceClient;

    public void insert(final Municipality municipality) throws DBException {
        toUtf(municipality);
        List<Municipality> list = persistenceClient.findByPropertyMunicipality("cadastre", municipality.getCadastre(), "cadastre");
        if (list != null && list.size() > 0) {
            throw new DBException(DBException.ELEMENT_EXIST);
        }
        list = persistenceClient.findByPropertyMunicipality("description", municipality.getDescription(), "description");
        if (list != null && list.size() > 0) {
            throw new DBException(DBException.DESCRIPTION_EXIST);
        }
        Municipality municipalityNew = new Municipality();
        municipalityNew.setId(municipality.getId());
        municipalityNew.setCadastre(municipality.getCadastre());
        municipalityNew.setProvince(municipality.getProvince());
        persistenceClient.saveOrUpdateMunicipality(municipalityNew);
    }

    public void delete(Municipality municipality)
            throws DBException {
        try {
            persistenceClient.deleteByPropertyMunicipality(municipality.getId());
        } catch (Exception e) {
            if (e.getCause() != null && e.getCause().getCause() != null && e.getCause().getCause()
                    .getMessage().contains("violates foreign constraint")) {
                LOG.error("Error during elimination of municipality {}", e.getCause().getCause().getMessage());
                throw new DBException("error.municipalityDelete");
            }
            LOG.error("Error deleting municipality", e);
            throw new DBException(DBException.DELETE);
        }
    }


    private void toUtf(final Municipality municipality) {
        municipality.setDescription(Encoder.toUtf(municipality.getDescription().toUpperCase()));
        municipality.setCadastre(Encoder.toUtf(municipality.getCadastre().toUpperCase()));
    }
}
