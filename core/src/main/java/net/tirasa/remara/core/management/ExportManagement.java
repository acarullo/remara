package net.tirasa.remara.core.management;

import net.tirasa.remara.core.resource.ExportCSV;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.ResourceBundle;
import net.tirasa.remara.core.clients.PersistenceClient;
import net.tirasa.remara.persistence.data.Education;
import net.tirasa.remara.persistence.data.Export;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import net.tirasa.remara.persistence.data.Illness;
import net.tirasa.remara.persistence.data.MedicineCase;
import net.tirasa.remara.persistence.data.Municipality;
import net.tirasa.remara.persistence.data.Occupation;
import net.tirasa.remara.persistence.data.Patient;
import net.tirasa.remara.persistence.data.Province;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ExportManagement {

    private static final Logger LOG = LoggerFactory.getLogger(ExportManagement.class);

    @Autowired
    private PersistenceClient persistenceClient;

    private final static ResourceBundle titles = ResourceBundle.getBundle(ExportManagement.class.getName());

    private final ExportCSV e = new ExportCSV();

    private Date from;

    private Date to;

    private Date sped;

    private String code;

    private HospitalOrganization hospitalOrganization;

    private static final int SURNAME_LEN = 30;

    private static final int NAME_LEN = 30;

    private static final int REGION_LEN = 21;

    private static final int HOSPITAL_LEN = 150;

    private static final int YEARS = 18;

    private static final int CODE_PATIENT = 50;

    private static final String CARRIAGE_RETURN = "\r\n";

    public List<Export> findAllExport() {
        return persistenceClient.findAllExports();
    }

    public void insert(final Export export) {
        persistenceClient.saveOrUpdateExport(export);
    }

    public void delete(final Export export) {
        persistenceClient.deleteExport(export);
    }

    public void setFrom(final Date from) {
        this.from = from;
    }

    public void setTo(final Date to) {
        this.to = to;
    }

    public void setCode(final String code) {
        this.code = code;
    }

    public void setSped(final Date sped) {
        this.sped = sped;
    }

    public void setHospitalOrganization(final HospitalOrganization hospitalOrganization) {
        this.hospitalOrganization = hospitalOrganization;
    }

    public ExportManagement() {
    }

    public ExportManagement(final String code, final Date sped, final Date from,
            final Date to, final HospitalOrganization hospitalOrg) {
        this.code = code;
        this.sped = sped;
        this.from = from;
        this.to = to;
        this.hospitalOrganization = hospitalOrg;
    }

    private StringBuffer recordA1() {
        final StringBuffer sb = new StringBuffer();
        sb.append("A");
        sb.append("ISSMR-A1");
        sb.append(e.getAN(code, 15));
        sb.append(e.getDT(sped));
        return sb;
    }

    private StringBuffer recordA2() {
        StringBuffer sb = new StringBuffer();
        sb.append("A");
        sb.append("ISSMR-P1");
        sb.append(e.getAN(code, 15));
        sb.append(e.getDT(sped));
        return sb;
    }

    private StringBuffer recordB(final Patient patient) {
        StringBuffer sb = new StringBuffer();
        sb.append(CARRIAGE_RETURN);
        sb.append("B");
        sb.append(e.getAN(code, 15));
        sb.append(e.getAN(String.valueOf(patient.getId()), CODE_PATIENT));
        sb.append(e.getAN(patient.getTaxCode(), 16));
        sb.append(e.getAN(patient.getSurname(), SURNAME_LEN));
        sb.append(e.getAN(patient.getName(), NAME_LEN));

        GregorianCalendar gc = new GregorianCalendar();
        gc.setTime(patient.getBirthDate());
        sb.append(gc.get(GregorianCalendar.YEAR));

        Province province = patient.getLivingProvince();
        String sProv = "";
        if (province != null) {
            sProv = province.getId();
        }
        sb.append(e.getAN(sProv, 2));

        Municipality municipality = patient.getLivingMunicipality();

        String sMun = "";
        if (municipality != null) {
            sMun = municipality.getCadastre();
        }
        sb.append(e.getAN(sMun, 4));

        GregorianCalendar gcTemp = new GregorianCalendar();
        gcTemp.setTime(new Date());
        gcTemp.add(GregorianCalendar.YEAR, -YEARS);
        Education education;
        Occupation occupation;
        if (patient.getBirthDate().after(gc.getTime())) {
            education = patient.getFatherEducation();
            occupation = patient.getFatherOccupation();
            if (education == null) {
                education = patient.getMotherEducation();
                occupation = patient.getMotherOccupation();
            }
        } else {
            education = patient.getPersonalEducation();
            occupation = patient.getPersonalOccupation();
        }
        String sEdu = "";
        if (education != null) {
            sEdu = education.getCode();
        }
        sb.append(e.getAN(sEdu, 2));

        String sOcc = "";
        if (occupation != null) {
            sOcc = occupation.getCode();
        }
        sb.append(e.getAN(sOcc, 2));
        sb.append(e.getDT(patient.getDeathDate()));

        return sb;
    }

    public String export1() throws Exception {
        final StringBuilder sb = new StringBuilder(recordA1());

        int nB = 0;
        final List<MedicineCase> list = persistenceClient.findForExportMC(from, to);
        Long idPatient = (long) 0;
        for (MedicineCase m : list) {
            if (m.getPatient().getId() != idPatient) {
                sb.append(recordB(m.getPatient()));
                nB++;
                idPatient = m.getPatient().getId();
            }
        }
        sb.append(recordZ(nB++));

        return sb.toString().toUpperCase();
    }

    public void termite() {
        List<MedicineCase> list = persistenceClient.findForExportMC(from, to);
        for (MedicineCase m : list) {
            m.setSpedDate(new Date());
            persistenceClient.saveOrUpdateMC(m);
        }
    }

    public String export2()
            throws Exception {
        StringBuilder sb = new StringBuilder();
        sb.append(recordA2());

        int nC = 0;
        List<MedicineCase> list = persistenceClient.findForExportMC(from, to);
        try {
            for (MedicineCase m : list) {
                sb.append(recordC(m));
                nC++;
            }
        } catch (Exception ex) {
            throw (ex);
        }
        sb.append(recordZ(nC++));

        return sb.toString().toUpperCase();
    }

    private StringBuffer recordC(final MedicineCase m) {
        Illness illness = m.getIllness();
        HospitalOrganization hospital = m.getHospitalOrganization();
        String foreigner = m.getForeigner();
        StringBuffer sb = new StringBuffer();
        sb.append(CARRIAGE_RETURN);
        sb.append("C");
        sb.append(e.getAN(code, 15));
        sb.append(e.getAN(String.valueOf(m.getPatient().getId()), CODE_PATIENT));
        sb.append(e.getAN(illness.getCode(), 10));
        sb.append(e.getAN(illness.getDescription(), 100));

        if (foreigner.equals(titles.getString("foreign1"))) {
            sb.append(e.getAN(hospital.getRegion().getDescription(), REGION_LEN));
            sb.append(e.getAN(hospital.getCode() + ":", HOSPITAL_LEN));
        } else {
            sb.append(e.getAN("Estero", REGION_LEN));
            sb.append(e.getAN("NNN:*** NON CONOSCIUTO ***", HOSPITAL_LEN));
        }
        sb.append(e.getDT(m.getStartingDateIllness()));
        sb.append(e.getDT(m.getDiagnosisDateIllness()));
        sb.append(e.getFG(m.getOrphanMedicine()));
        sb.append(e.getAN(hospitalOrganization.getCode() + ":", HOSPITAL_LEN));

        return sb;
    }

    private StringBuffer recordZ(final int n) {
        StringBuffer sb = new StringBuffer();
        sb.append(CARRIAGE_RETURN);
        sb.append("Z");
        sb.append(e.getAN(code, 15));
        sb.append(e.getNU(n, 5));
        sb.append(CARRIAGE_RETURN);
        return sb;
    }
}
