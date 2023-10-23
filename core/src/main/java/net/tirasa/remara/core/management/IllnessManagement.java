package net.tirasa.remara.core.management;

import net.tirasa.remara.core.exception.DBException;
import java.util.ArrayList;
import java.util.List;
import net.tirasa.remara.core.clients.PersistenceClient;
import net.tirasa.remara.persistence.data.Illness;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class IllnessManagement {

    private static final Logger LOG = LoggerFactory.getLogger(IllnessManagement.class);

    @Autowired
    private PersistenceClient persistenceClient;

    private static final int MAX_ROWS = 25;

    public void insert(final Illness illness, final String username) throws DBException {
        toUtf(illness);
        List<Illness> list = persistenceClient.findByPropertyIllnesses("code", illness.getCode());
        if (list != null && list.size() > 0) {
            throw new DBException(DBException.ELEMENT_EXIST);
        }
        list = persistenceClient.findByPropertyIllnesses("description", illness.getDescription());
        if (list != null && list.size() > 0) {
            throw new DBException(DBException.DESCRIPTION_EXIST);
        }
        Illness illnessNew = new Illness();
        illnessNew.setId(illness.getId());
        illnessNew.setCode(illness.getCode());
        illnessNew.setDescription(illness.getDescription());
        illnessNew.setExempt(illness.getExempt());
        illnessNew.setMarche(illness.getMarche());
        persistenceClient.saveOrUpdateIllness(illnessNew);
    }

    public void update(final Illness illness) throws DBException {
        toUtf(illness);
        illness.setExempt(Encoder.toUtf(illness.getExempt()));
        List<Illness> list = persistenceClient.findByPropertyIllnesses("description", illness.getDescription());
        if (list != null && list.size() > 0 && !list.get(0).getCode().equals(illness.getCode())) {
            throw new DBException(DBException.DESCRIPTION_EXIST);
        }
        Illness newIllness = persistenceClient.getIllness(illness.getId());
        newIllness.setDescription(illness.getDescription());
        newIllness.setExempt(illness.getExempt());
        newIllness.setMarche(illness.getMarche());

        Illness newIllnessMem = persistenceClient.getIllness(illness.getId());
        newIllnessMem.setDescription(illness.getDescription());
        newIllnessMem.setExempt(illness.getExempt());
        newIllnessMem.setMarche(illness.getMarche());

        persistenceClient.saveOrUpdateIllness(newIllnessMem);
        persistenceClient.saveOrUpdateIllness(newIllness);
    }

    public List<Illness> getList() {
        return persistenceClient.findAllIllnesses();
    }

    public void delete(Illness illness)
            throws DBException {
        try {
            persistenceClient.deleteByPropertyIllness("id", illness.getId());
        } catch (Exception e) {
            if (e.getCause() != null && e.getCause().getCause() != null && e.getCause().getCause().getMessage().
                    contains("violates foreign key constraint")) {
                LOG.error("Error during elimination of illness {}", e.getCause().
                        getCause().getMessage());
                throw new DBException("error.illnessDelete");
            }
            LOG.error("Error deleting illness", e);
            throw new DBException(DBException.DELETE);
        }
    }

    public List<String> getListForAutoComplete(final String code) {
        if (code == null || code.isEmpty()) {
            return new ArrayList<String>();
        }
        List<Illness> list = persistenceClient.findByCodeIllness(code, MAX_ROWS);
        List<String> descriptions = new ArrayList<String>();
        if (list == null) {
            return descriptions;
        }
        for (Illness illness : list) {
            descriptions.add(illness.getDescription());
        }
        return descriptions;
    }

    public Illness getByCode(final String code) {
        Illness illness = null;
        if (code == null || code.isEmpty()) {
            return illness;
        }
        List<Illness> list = persistenceClient.findByPropertyIllnesses("code", code);

        if (list != null && list.size() > 0) {
            Illness illnessMem = list.get(0);
            illness = persistenceClient.getIllness(illnessMem.getId());
        }
        return illness;
    }

    public Illness getByDescription(final String description) {
        Illness illness = null;
        if (description == null || description.isEmpty()) {
            return illness;
        }
        List<Illness> list = persistenceClient.findByPropertyIllnesses("description", description);
        if (list != null && list.size() > 0) {
            Illness illnessMem = list.get(0);
            illness = persistenceClient.getIllness(illnessMem.getId());
        }
        return illness;
    }

    private void toUtf(final Illness illness) {
        illness.setDescription(
                Encoder.toUtf(illness.getDescription().toUpperCase()));
        illness.setCode(Encoder.toUtf(illness.getCode().toUpperCase()));
        illness.setExempt(Encoder.toUtf(illness.getExempt().toUpperCase()));
    }
}
