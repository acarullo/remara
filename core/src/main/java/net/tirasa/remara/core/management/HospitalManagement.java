package net.tirasa.remara.core.management;

import net.tirasa.remara.core.exception.DBException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import net.tirasa.remara.core.clients.PersistenceClient;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import net.tirasa.remara.persistence.data.HospitalWard;
import net.tirasa.remara.persistence.data.Region;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class HospitalManagement {

    private static final Logger LOG = LoggerFactory.getLogger(HospitalManagement.class);

    @Autowired
    private PersistenceClient persistenceClient;

    public HospitalWard insertWard(final HospitalOrganization ho, final String nameWard) throws DBException {
        toUtf(ho);
        final Long idHospital = ho.getId();

        final List<HospitalWard> list = persistenceClient.findByPropertyHWards("hospitalOrganization.id", idHospital);
        if (list != null && list.size() > 0) {
            for (HospitalWard w : list) {
                if (w.getName().equals(nameWard)) {
                    throw new DBException(DBException.ELEMENT_EXIST);
                }
            }
        }

        final HospitalOrganization hospital = persistenceClient.getHospital(idHospital);
        final HospitalWard hospitalWard = new HospitalWard();
        hospitalWard.setHospitalOrganization(hospital);
        hospitalWard.setName(nameWard);

        try {
            persistenceClient.saveOrUpdateHWard(hospitalWard);
        } catch (Exception e) {
            throw new DBException(DBException.SAVE);
        }
        return hospitalWard;
    }

    public void insert(final HospitalOrganization hospitalOrganization) throws DBException {
        toUtf(hospitalOrganization);

        /*
         * TODO fix del controllo: bisogna verificare l'esistenza rispetto alla regione
         */
        final List<HospitalOrganization> list = persistenceClient.findByPropertyHospitals("code", hospitalOrganization.
                getCode());
        if (list != null && list.size() > 0) {
            throw new DBException(DBException.ELEMENT_EXIST);
        }
        persistenceClient.saveOrUpdateHospital(hospitalOrganization);
    }

    public void update(final HospitalWard hospitalWard) {
        toUtf(hospitalWard);
        final HospitalWard newWard = persistenceClient.getHWard(hospitalWard.getId());
        newWard.setName(hospitalWard.getName());
        persistenceClient.saveOrUpdateHWard(newWard);
    }

    public void update(final HospitalOrganization hospitalOrganization) throws DBException {
        toUtf(hospitalOrganization);
        final Set<HospitalWard> wardsHashSet = new HashSet<HospitalWard>();

        try {
            HospitalWard hospitalWardDb;

            //Delete wards selected
            try {
                for (HospitalWard hospitalWard : hospitalOrganization.getHospitalWardsToDelete()) {
                    hospitalWardDb = persistenceClient.getHWard(hospitalWard.getId());
                    persistenceClient.deleteHWard(hospitalWardDb);
                }
            } catch (Exception e) {
                if (e.getCause() != null && e.getCause().getCause() != null && e.getCause().getCause().getMessage().
                        contains("violates foreign key constraint")) {
                    LOG.error("Error during update of an hospital (hospital ward elimination): {}", e.getCause().
                            getCause().getMessage());
                    throw new DBException("error.wardDelete");
                }
                LOG.error("Error during update of an hospital (hospital ward elimination): {}, {}", e.getMessage());
                throw new DBException("error.delete");
            }

            hospitalOrganization.getHospitalWardsToDelete().clear();

            hospitalWardDb = null;

            //Update wards
            for (HospitalWard hospitalWard : hospitalOrganization.getHospitalWards()) {

                if (hospitalWard.getId() != null) {
                    hospitalWardDb = persistenceClient.getHWard(hospitalWard.getId());
                    hospitalWardDb.setName(hospitalWard.getName());
                    wardsHashSet.add(hospitalWardDb);
                } else {
                    wardsHashSet.add(hospitalWard);
                }
            }

            HospitalOrganization hospitalOrganizationDb = persistenceClient.getHospital(hospitalOrganization.getId());
            hospitalOrganizationDb.setCode(hospitalOrganization.getCode());
            hospitalOrganizationDb.setName(hospitalOrganization.getName());
            hospitalOrganizationDb.setRegion(hospitalOrganization.getRegion());

            hospitalOrganizationDb.setHospitalWards(wardsHashSet);
            persistenceClient.saveOrUpdateHospital(hospitalOrganizationDb);
        } catch (Exception e) {
            if (e.getMessage().contains("error.wardDelete")) {
                LOG.error("error updating ho {}", hospitalOrganization.getName(), e);
                throw new DBException("error.wardDelete");
            }
            LOG.error("error updating ho {}", hospitalOrganization.getName(), e);
            throw new DBException(DBException.SAVE);
        }
    }

    public List<HospitalOrganization> getAllHospitals() {
        return persistenceClient.findAllHospitals();
    }

    public List<HospitalWard> getAllHospitalWards() {
        return persistenceClient.findAllHWards();
    }

    public void delete(final HospitalWard hospitalWard) throws DBException {
        try {
            persistenceClient.deleteByPropertyHWard("id", hospitalWard.getId());
        } catch (Exception e) {
            if (e.getCause() != null && e.getCause().getCause() != null && e.getCause().getCause().getMessage().
                    contains("violates foreign key constraint")) {
                LOG.error("Error during elimination of hospital ward by id: {}, {}", hospitalWard.getId(), e.getCause().
                        getCause().getMessage());
                throw new DBException("error.wardDelete");
            }
            LOG.error("Error during elimination of hospital ward by id: {}, {}", hospitalWard.getId(), e.getMessage());
            throw new DBException("error.delete");
        }
    }

    public void delete(final HospitalOrganization hospitalOrganization) throws DBException {
        try {
            persistenceClient.deleteByPropertyHospital("id", hospitalOrganization.getId());
        } catch (Exception e) {
            if (e.getCause() != null && e.getCause().getCause() != null && e.getCause().getCause().getMessage().
                    contains("violates foreign key constraint")) {
                LOG.error("Error during elimination of hospital organization {}", e.getCause().
                        getCause().getMessage());
                throw new DBException("error.hospitalDelete");
            }
            throw new DBException("error.delete");
        }
    }

    public List<Region> getRegions() {
        return persistenceClient.findAllRegions("description");
    }

    public List<HospitalOrganization> findByRegion(final Region region) {
        List<HospitalOrganization> list = new ArrayList<HospitalOrganization>();
        if (region == null) {
            return list;
        }
        return persistenceClient.findByPropertyHospitals("region.id", region.getId(), "name");
    }

    public List<HospitalOrganization> findByRegionId(final Integer id) {
        List<HospitalOrganization> list = new ArrayList<HospitalOrganization>();
        if (id == null) {
            return list;
        }
        return persistenceClient.findByPropertyHospitals("region.id", id, "name");
    }

    public List<HospitalWard> findHWByRegionId(final Integer id) {
        List<HospitalWard> list = new ArrayList<HospitalWard>();
        if (id == null) {
            return list;
        }
        return persistenceClient.findHWByProperty("region.id", id, "name");
    }

    public List<HospitalOrganization> findByCode(String code) {
        List<HospitalOrganization> list = new ArrayList<HospitalOrganization>();
        if (code == null) {
            return list;
        }
        return persistenceClient.findByPropertyHospitals("code", code, "name");
    }

    public List<HospitalOrganization> findByNameAndRegion(final String code, final Region region) {
        List<HospitalOrganization> list = findByRegion(region);
        List<HospitalOrganization> rList = new ArrayList<HospitalOrganization>();
        if (code == null) {
            return list;
        }
        for (HospitalOrganization ho : list) {
            if (ho.getName().toLowerCase().contains(code.toLowerCase())) {
                rList.add(ho);
            }
        }
        return rList;
    }

    public List<HospitalWard> getHospitalWard(final HospitalOrganization hospitalOrganization) {
        if (hospitalOrganization != null
                && hospitalOrganization.getId() != null) {
            return persistenceClient.findByPropertyHWards("hospitalOrganization.id", hospitalOrganization.getId(),
                    "name");
        } else {
            return new ArrayList<HospitalWard>();
        }
    }

    private void toUtf(final HospitalOrganization ho) {
        ho.setCode(Encoder.toUtf(ho.getCode().toUpperCase()));
        String name = ho.getName();
        ho.setName(Encoder.toUtf(name.replaceAll("\"", "").toUpperCase()));
    }

    private void toUtf(final HospitalWard hospitalWard) {
        hospitalWard.setName(Encoder.toUtf(hospitalWard.getName().toUpperCase()));
    }
}
