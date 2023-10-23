package net.tirasa.remara.core.management;

import net.tirasa.remara.core.exception.DBException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import net.tirasa.remara.core.clients.PersistenceClient;
import net.tirasa.remara.persistence.data.Patient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class PatientManagement {

    private static final Logger LOG = LoggerFactory.getLogger(PatientManagement.class);

    @Autowired
    private PersistenceClient persistenceClient;

    public void insert(final Patient patient) throws DBException {
        toUtf(patient);
        final List<Patient> list = findByCF(patient.getTaxCode());
        if (list != null && list.size() > 0) {
            throw new DBException(DBException.ELEMENT_EXIST);
        }
        // codice per il settaggio a null dei parametri in base alla nazionalità inserita in patient
        if (patient.getBirthCap() != null) {
            patient.setBirthCap(patient.getBirthCap().toUpperCase());
        }
        if (patient.getExactlyOccupation() != null) {
            patient.setExactlyOccupation(patient.getExactlyOccupation().toUpperCase());
        }
        if (patient.getBirthNation() != null) {
            patient.setBirthNation(persistenceClient.getNation(patient.getBirthNation().getId()));
            if (patient.getBirthForeignInformation() != null && !patient.getBirthForeignInformation().isEmpty()) {
                patient.setBirthForeignInformation(patient.getBirthForeignInformation().toUpperCase());
            }
        }
        patient.setLivingAddress(patient.getLivingAddress().toUpperCase());
        patient.setLivingCap(patient.getLivingCap().toUpperCase());
        patient.setName(patient.getName().toUpperCase());
        patient.setSex(patient.getSex().toUpperCase());
        patient.setSurname(patient.getSurname().toUpperCase());
        patient.setTaxCode(patient.getTaxCode().toUpperCase());
        patient.setTelephone(patient.getTelephone());
        persistenceClient.saveOrUpdatePatient(patient);
    }

    public void update(final Patient patient) {
        toUtf(patient);
        Patient newPatient = persistenceClient.getPatient(patient.getId());
        // codice per il settaggio a null dei parametri in base alla nazionalità inserita in patient
        if (patient.getBirthCap() != null) {
            newPatient.setBirthCap(patient.getBirthCap().toUpperCase());
        }
        if (patient.getExactlyOccupation() != null) {
            newPatient.setExactlyOccupation(patient.getExactlyOccupation().toUpperCase());
        }
        newPatient.setLivingAddress(patient.getLivingAddress().toUpperCase());
        newPatient.setLivingCap(patient.getLivingCap().toUpperCase());
        newPatient.setName(patient.getName().toUpperCase());
        newPatient.setSex(patient.getSex().toUpperCase());
        newPatient.setSurname(patient.getSurname().toUpperCase());
        newPatient.setTaxCode(patient.getTaxCode().toUpperCase());
        newPatient.setTelephone(patient.getTelephone());
        newPatient.setBirthDate(patient.getBirthDate());
        newPatient.setDeathDate(patient.getDeathDate());
        newPatient.setForeigner(patient.getForeigner());
        if (patient.getBirthMunicipality() != null) {
            newPatient.setBirthMunicipality(persistenceClient.
                    getMunicipality(patient.getBirthMunicipality().getId()));
        }
        if (patient.getBirthNation() != null) {
            newPatient.setBirthNation(persistenceClient.getNation(patient.getBirthNation().getId()));
            if (patient.getBirthForeignInformation() != null && !patient.getBirthForeignInformation().isEmpty()) {
                newPatient.setBirthForeignInformation(patient.getBirthForeignInformation());
            }
        }
        if (patient.getBirthProvince() != null) {
            newPatient.setBirthProvince(persistenceClient.getProvince(patient.getBirthProvince().getId()));
        }
        if (patient.getBirthRegion() != null) {
            newPatient.setBirthRegion(persistenceClient.getRegion(patient.getBirthRegion().getId()));
        }
        if (patient.getFatherEducation() != null) {
            newPatient.setFatherEducation(persistenceClient.getEducation(patient.getFatherEducation().getId()));
        }
        if (patient.getFatherOccupation() != null) {
            newPatient.setFatherOccupation(persistenceClient.getOccupation(patient.getFatherOccupation().getId()));
        }
        if (patient.getLivingNation() != null) {
            newPatient.setLivingNation(persistenceClient.getNation(patient.getLivingNation().getId()));
        }
        if (patient.getLivingMunicipality() != null) {
            newPatient.setLivingMunicipality(persistenceClient.getMunicipality(patient.getLivingMunicipality().getId()));
        }
        if (patient.getLivingProvince() != null) {
            newPatient.setLivingProvince(persistenceClient.getProvince(patient.getLivingProvince().getId()));
        }
        if (patient.getLivingRegion() != null) {
            newPatient.setLivingRegion(persistenceClient.getRegion(patient.getLivingRegion().getId()));
        }
        if (patient.getMotherEducation() != null) {
            newPatient.setMotherEducation(persistenceClient.getEducation(patient.getMotherEducation().getId()));
        }
        if (patient.getMotherOccupation() != null) {
            newPatient.setMotherOccupation(persistenceClient.getOccupation(patient.getMotherOccupation().getId()));
        }
        if (patient.getPersonalEducation() != null) {
            newPatient.setPersonalEducation(persistenceClient.getEducation(patient.getPersonalEducation().getId()));
        }
        if (patient.getPersonalOccupation() != null) {
            newPatient.setPersonalOccupation(persistenceClient.getOccupation(patient.getPersonalOccupation().getId()));
        }
        persistenceClient.saveOrUpdatePatient(newPatient);
    }

    public void delete(final Patient patient) throws DBException {
        Long patientId = patient.getId();
        try {
            persistenceClient.deleteByPropertyPatient("id", patientId);
        } catch (Exception e) {
            if (e.getCause() != null && e.getCause().getCause() != null && e.getCause().getCause().getMessage().
                    contains("violates foreign key constraint")) {
                LOG.error("Error during delete of patient: {}, {}", patient.getId(), e.getCause().getCause().
                        getMessage());
                throw new DBException("error.patientDelete");
            }
            LOG.error("Error during delete of patient: {}, {}", patient.getId(), e.getMessage());
            throw new DBException("error.delete");
        }
    }

    public Patient getById(final Long id) {
        Patient patient = null;
        if (id != null || id != 0) {
            patient = persistenceClient.getPatient(id);
        }
        return patient;
    }

    public List<Patient> findByCF(final String cf) {
        final List<Patient> list = persistenceClient.findAllPatients();
        final List<Patient> returnedList = new ArrayList<Patient>();
        if (cf == null) {
            return list;
        }

        Iterator it = list.iterator();
        Patient p;

        while (it.hasNext()) {
            p = (Patient) it.next();
            if (cf.equalsIgnoreCase(p.getTaxCode())) {
                returnedList.add(p);
            }
        }
        return returnedList;
    }

    public List<Patient> findByCode(final String code) {
        return persistenceClient.findPatientsByCFOrSurname(code);
    }

    public List<Patient> findByNameAndSurname(final String name, final String surname) {
        return persistenceClient.findByNameAndSurname(name, surname);
    }

    public List<Patient> findAllPatient() {
        return persistenceClient.findAllPatients();
    }

    public List<String> getListForAutoComplete(final String cf) {
        if (cf == null || cf.isEmpty()) {
            return new ArrayList<String>();
        }
        final List<Patient> list = findAllPatient();
        final List<String> surnames = new ArrayList<String>();
        if (list == null) {
            return surnames;
        }
        for (Patient patient : list) {
            if (patient.getTaxCode().toLowerCase().startsWith(cf.toLowerCase())) {
                surnames.add(patient.getTaxCode());
            }
        }
        return surnames;
    }

    private void toUtf(final Patient patient) {
        if (patient.getExactlyOccupation() != null) {
            patient.setExactlyOccupation(
                    Encoder.toUtf(patient.getExactlyOccupation()));
        }
        if (patient.getLivingAddress() != null) {
            patient.setLivingAddress(Encoder.toUtf(patient.getLivingAddress()));
        }
        patient.setName(Encoder.toUtf(patient.getName()));
        patient.setSurname(Encoder.toUtf(patient.getSurname()));
    }

    public Object countPatients() {
        return persistenceClient.countPatients();
    }

    public int countSexPatients(String sex) {
        return persistenceClient.findByPropertyPatients("sex", sex).size();
    }

    public int countAdultPatients() {
        return persistenceClient.findAdultPatients().size();
    }

    public int countMinorPatients() {
        return persistenceClient.findMinorPatients().size();
    }
}
