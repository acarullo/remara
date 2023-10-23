package net.tirasa.remara.core.management;

import com.lowagie.text.Chapter;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.text.DateFormat;
import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;
import net.tirasa.remara.persistence.data.Exam;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import net.tirasa.remara.persistence.data.MedicineCase;
import net.tirasa.remara.persistence.data.Patient;
import net.tirasa.remara.persistence.data.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class PDFCase {

    private static final Logger LOG = LoggerFactory.getLogger(PDFCase.class);

    @Autowired
    private CaseManagement caseManagement;

    @Autowired
    private UserManagement userManagement;

    private static final int PDF_MARGIN = 60;

    private static final int TABLE_WIDTH_PERC = 90;

    private static final int TABLE_SPACING = 40;

    private static final int LINE_SPACING = 20;

    private static final int PLACE_SPACING = 50;

    private static final int FIRMA_SPACING = 25;

    private static final ResourceBundle titles = ResourceBundle.getBundle(PDFCase.class.getName());

    private static final float[] colsWidth = {2f, 4f};

    private final Locale locale = Locale.ITALY;

    private static final Font fontCapitolo = new Font(Font.HELVETICA, 14, Font.BOLD);

    private static final Font fontSottoCapitolo = new Font(Font.HELVETICA, 12, Font.BOLD);

    private static final Font fontDescrizione = new Font(Font.HELVETICA, 9, Font.NORMAL);

    private static final Font fontKey = new Font(Font.HELVETICA, 11, Font.NORMAL);

    private Paragraph getTextR(final String s, final Font font, final float f) {
        Paragraph paragraph = new Paragraph(titles.getString(s), font);
        paragraph.setAlignment(Paragraph.ALIGN_RIGHT);
        if (f > 0) {
            paragraph.setSpacingBefore(f);
        }
        return paragraph;
    }

    private Paragraph getTextC(final String s, final Font font, final float f) {
        Paragraph paragraph = new Paragraph(titles.getString(s), font);
        paragraph.setAlignment(Paragraph.ALIGN_CENTER);
        if (f > 0) {
            paragraph.setSpacingBefore(f);
        }
        return paragraph;
    }

    private Paragraph getTitle(final String s) {
        return new Paragraph(titles.getString(s), fontKey);
    }

    private Paragraph getValue(final String s) {
        return new Paragraph(s, fontKey);
    }

    private Paragraph getValueC(final String s) {
        Paragraph paragraph = new Paragraph(s, fontKey);
        paragraph.setAlignment(Paragraph.ALIGN_CENTER);
        paragraph.setSpacingBefore(5);
        return paragraph;
    }

    private PdfPTable getPatient(final Patient patient) {
        PdfPTable tab = new PdfPTable(colsWidth);
        tab.getDefaultCell().setBorderColor(Color.WHITE);

        tab.setWidthPercentage(TABLE_WIDTH_PERC);
        tab.setHorizontalAlignment(Element.ALIGN_CENTER);
        tab.setSpacingBefore(TABLE_SPACING);

        String name = patient.getName() + " " + patient.getSurname();

        DateFormat df = DateFormat.getDateInstance(DateFormat.MEDIUM, locale);
        String birthDate = df.format(patient.getBirthDate());

        String birthMunicipality = "";
        if (patient.getForeigner().equals("Italia")) {
            if (patient.getBirthMunicipality() != null) {
                birthMunicipality = patient.getBirthMunicipality().getDescription();
            }
        } else {
            if (patient.getBirthForeignInformation() != null && !"null".equals(patient.getBirthForeignInformation())) {
                birthMunicipality = patient.getBirthForeignInformation();
            }
            if (patient.getBirthNation() != null) {
                birthMunicipality += " (" + patient.getBirthNation().getInitials() + ")";
            }
        }

        String address = "";
        if (patient.getLivingAddress() != null && !"null".equals(patient.getLivingAddress())) {
            address = patient.getLivingAddress();
        }
        if (patient.getLivingMunicipality() != null) {
            if (!address.isEmpty()) {
                address += ", ";
            }
            address += patient.getLivingMunicipality().getDescription();
        }

        String province = "";
        if (patient.getLivingProvince() != null && !"null".equals(patient.getLivingProvince())) {
            province = patient.getLivingProvince().getDescription();
        }

        tab.addCell(getTitle("name"));
        tab.addCell(getValue(name));

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("birthDate"));
        tab.addCell(getValue(birthDate));

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("birthMunicipality"));
        tab.addCell(getValue(birthMunicipality));

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("address"));
        tab.addCell(getValue(address));

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("Cap"));
        tab.addCell(getValue(patient.getLivingCap()));

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("province"));
        tab.addCell(getValue(province));

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("taxCode"));
        tab.addCell(getValue(patient.getTaxCode()));

        tab.addCell("");
        tab.addCell("");

        if (patient.getTelephone() != null) {
            tab.addCell(getTitle("telephone"));
            tab.addCell(getValue(patient.getTelephone().toString()));
        }

        return tab;
    }

    public ByteArrayOutputStream createPDF(final MedicineCase medicineCase) {
        ByteArrayOutputStream out = new ByteArrayOutputStream(1024 * 4);

        try {
            Document document = new Document(PageSize.A4, PDF_MARGIN, PDF_MARGIN, PDF_MARGIN, PDF_MARGIN);
            PdfWriter writer = PdfWriter.getInstance(document, out);
            document.open();

            Chapter capitolo1 = new Chapter(getTextC("title_page", fontCapitolo, 0), 1);
            capitolo1.setNumberDepth(0);

            capitolo1.add(getTextC("sub_title1", fontSottoCapitolo, 10));
            capitolo1.add(getTextC("sub_title2", fontSottoCapitolo, 0));
            capitolo1.add(getTextC("description_1", fontDescrizione, 10));
            capitolo1.add(getTextC("description_2", fontDescrizione, 0));
            capitolo1.add(getTextC("description_3", fontDescrizione, 0));
            capitolo1.add(getTextC("certificate", fontCapitolo, LINE_SPACING));

            capitolo1.add(getPatient(medicineCase.getPatient()));

            capitolo1.add(getTextC("illness", fontCapitolo, TABLE_SPACING));
            capitolo1.add(getTextC("sub_illness", fontDescrizione, 0));
            capitolo1.add(getValueC(medicineCase.getIllness().getDescription()));

            capitolo1.add(getTextC("code", fontCapitolo, LINE_SPACING));
            capitolo1.add(getTextC("sub_code", fontDescrizione, 0));
            capitolo1.add(getValueC(medicineCase.getIllness().getExempt()));

            capitolo1.add(getTextC("place_date", fontKey, PLACE_SPACING));
            capitolo1.add(getTextR("firma", fontKey, FIRMA_SPACING));

            document.add(capitolo1);
            document.close();
        } catch (DocumentException ex) {
            LOG.error("Error during pdf creation", ex);
        }

        return out;
    }

    public ByteArrayOutputStream createPatientPDF(final MedicineCase medicineCase) {
        ByteArrayOutputStream out = new ByteArrayOutputStream(1024 * 4);

        try {
            Document document = new Document(PageSize.A4, PDF_MARGIN, PDF_MARGIN, PDF_MARGIN, PDF_MARGIN);
            PdfWriter writer = PdfWriter.getInstance(document, out);
            document.open();

            Chapter capitolo1 = new Chapter(getTextC("pat_title_page", fontCapitolo, 0), 1);
            capitolo1.setNumberDepth(0);

            capitolo1.add(getTextC("pat_compiler", fontCapitolo, LINE_SPACING));

            capitolo1.add(getOwner(userManagement.getUser(medicineCase.getOwner())));

            capitolo1.add(getTextC("view_case", fontCapitolo, LINE_SPACING));

            capitolo1.add(getPatientTwo(medicineCase.getPatient()));

            capitolo1.add(getIllness(medicineCase));

            document.add(capitolo1);
            document.close();
        } catch (DocumentException ex) {
            LOG.error("Error during patient pdf creation", ex);
        }

        return out;
    }

    private PdfPTable getOwner(final User user) {
        PdfPTable tab = new PdfPTable(colsWidth);
        if (user != null) {
            tab.getDefaultCell().setBorderColor(Color.WHITE);

            tab.setWidthPercentage(TABLE_WIDTH_PERC);
            tab.setHorizontalAlignment(Element.ALIGN_CENTER);
            tab.setSpacingBefore(TABLE_SPACING);

            String name = user.getName() + " " + user.getSurname();
            String mail = user.getEmail();
            String compilerHospital = user.getHospitalOrganization();
            String compilerWard = user.getHospitalWard();
            String address = user.getAddress();
            String phone = user.getPhone();
            String fax = user.getFax();

            tab.addCell(getTitle("name"));
            tab.addCell(getValue(name));

            tab.addCell("");
            tab.addCell("");

            tab.addCell(getTitle("email"));
            tab.addCell(getValue(mail));

            tab.addCell("");
            tab.addCell("");

            tab.addCell(getTitle("compilerHospital"));
            tab.addCell(getValue(compilerHospital));

            tab.addCell("");
            tab.addCell("");

            tab.addCell(getTitle("compilerWard"));
            tab.addCell(getValue(compilerWard));

            tab.addCell("");
            tab.addCell("");

            tab.addCell(getTitle("compilerAddress"));
            tab.addCell(getValue(address));

            tab.addCell("");
            tab.addCell("");

            tab.addCell(getTitle("phone"));
            tab.addCell(getValue(phone));

            tab.addCell("");
            tab.addCell("");

            tab.addCell(getTitle("fax"));
            tab.addCell(getValue(fax));

        } else {
            tab.addCell(getTitle("name"));
            tab.addCell(getValue("Compilatore non più presente in anagrafica"));
        }
        return tab;
    }

    private PdfPTable getPatientTwo(final Patient patient) {
        PdfPTable tab = new PdfPTable(colsWidth);
        tab.getDefaultCell().setBorderColor(Color.WHITE);

        tab.setWidthPercentage(TABLE_WIDTH_PERC);
        tab.setHorizontalAlignment(Element.ALIGN_CENTER);
        tab.setSpacingBefore(TABLE_SPACING);

        String name = patient.getName() + " " + patient.getSurname();

        DateFormat df = DateFormat.getDateInstance(DateFormat.MEDIUM, locale);
        String birthDate = df.format(patient.getBirthDate());

        String birthMunicipality = "";
        if (patient.getForeigner().equals("Italia")) {
            if (patient.getBirthMunicipality() != null) {
                birthMunicipality = patient.getBirthMunicipality().getDescription();
            }
        } else {
            if (patient.getBirthForeignInformation() != null && !"null".equals(patient.getBirthForeignInformation())) {
                birthMunicipality = patient.getBirthForeignInformation();
            }
            if (patient.getBirthNation() != null) {
                birthMunicipality += " (" + patient.getBirthNation().getInitials() + ")";
            }
        }

        String address = "";
        if (patient.getLivingAddress() != null && !"null".equals(patient.getLivingAddress())) {
            address = patient.getLivingAddress();
        }
        if (patient.getLivingMunicipality() != null) {
            if (!address.isEmpty()) {
                address += ", ";
            }
            address += patient.getLivingMunicipality().getDescription();
        }

        String province = "";
        if (patient.getLivingProvince() != null && !"null".equals(patient.getLivingProvince())) {
            province = patient.getLivingProvince().getDescription();
        }

        tab.addCell(getTitle("name"));
        tab.addCell(getValue(name));

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("sex"));
        if (patient.getSex() != null) {
            tab.addCell(getValue(patient.getSex()));
        } else {
            tab.addCell("");
        }

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("taxCode"));
        if (patient.getTaxCode() != null) {
            tab.addCell(getValue(patient.getTaxCode()));
        } else {
            tab.addCell("");
        }

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("telephone"));
        if (patient.getTelephone() != null) {
            tab.addCell(getValue(patient.getTelephone().toString()));
        } else {
            tab.addCell("");
        }

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("birthDate"));
        tab.addCell(getValue(birthDate));

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("deathDate"));
        if (patient.getDeathDate() != null) {
            tab.addCell(getValue(df.format(patient.getDeathDate())));
        } else {
            tab.addCell("");
        }

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("birthMunicipality"));
        tab.addCell(getValue(birthMunicipality));

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("address"));
        tab.addCell(getValue(address));

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("Cap"));
        if (patient.getLivingCap() != null && !"null".equals(patient.getLivingCap())) {
            tab.addCell(getValue(patient.getLivingCap()));
        } else {
            tab.addCell("");
        }

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("province"));
        tab.addCell(getValue(province));

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("personalEducation"));
        if ((patient.getPersonalEducation() != null) && (patient.getPersonalEducation().getDescriptionIt() != null)) {
            tab.addCell(getValue(patient.getPersonalEducation().getDescriptionIt()));
        } else {
            tab.addCell("");
        }

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("motherEducation"));
        if ((patient.getMotherEducation() != null) && (patient.getMotherEducation().getDescriptionIt() != null)) {
            tab.addCell(getValue(patient.getMotherEducation().getDescriptionIt()));
        } else {
            tab.addCell("");
        }

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("fatherEducation"));
        if ((patient.getFatherEducation() != null) && (patient.getFatherEducation().getDescriptionIt() != null)) {
            tab.addCell(getValue(patient.getFatherEducation().getDescriptionIt()));
        } else {
            tab.addCell("");
        }

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("personalOccupation"));
        if ((patient.getPersonalEducation() != null) && (patient.getPersonalEducation().getDescriptionIt() != null)) {
            tab.addCell(getValue(patient.getPersonalOccupation().getDescriptionIt()));
        } else {
            tab.addCell("");
        }

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("motherOccupation"));
        if ((patient.getMotherEducation() != null) && (patient.getMotherEducation().getDescriptionIt() != null)) {
            tab.addCell(getValue(patient.getMotherOccupation().getDescriptionIt()));
        } else {
            tab.addCell("");
        }

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("fatherOccupation"));
        if ((patient.getFatherEducation() != null) && (patient.getFatherEducation().getDescriptionIt() != null)) {
            tab.addCell(getValue(patient.getFatherOccupation().getDescriptionIt()));
        } else {
            tab.addCell("");
        }

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("exactlyOccupation"));
        if (patient.getExactlyOccupation() != null && !"null".equals(patient.getExactlyOccupation())) {
            tab.addCell(getValue(patient.getExactlyOccupation()));
        } else {
            tab.addCell("");
        }

        return tab;
    }

    private PdfPTable getIllness(final MedicineCase medicineCase) {
        PdfPTable tab = new PdfPTable(colsWidth);
        DateFormat df = DateFormat.getDateInstance(DateFormat.MEDIUM, locale);
        tab.getDefaultCell().setBorderColor(Color.WHITE);

        tab.setWidthPercentage(TABLE_WIDTH_PERC);
        tab.setHorizontalAlignment(Element.ALIGN_CENTER);
        tab.setSpacingBefore(TABLE_SPACING);

        tab.addCell(getTitle("illness"));
        tab.addCell(getValue(medicineCase.getIllness().getExempt()
                + " - " + medicineCase.getIllness().getDescription()));

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("exactlyIllness"));
        tab.addCell(getValue(medicineCase.getExactlyIllness()));

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("startingDateIllness"));
        if (medicineCase.getStartingDateIllness() != null) {
            tab.addCell(getValue(df.format(medicineCase.getStartingDateIllness())));
        } else {
            tab.addCell("");
        }

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("diagnosisDateIllness"));
        if (medicineCase.getDiagnosisDateIllness() != null) {
            tab.addCell(getValue(df.format(medicineCase.getDiagnosisDateIllness())));
        } else {
            tab.addCell("");
        }
        tab.addCell("");
        tab.addCell("");

        StringBuilder hospitalOrganization = new StringBuilder();
        if (medicineCase.getHospitalForeigner() != null && !medicineCase.getHospitalForeigner().isEmpty() && !"null".
                equals(medicineCase.getHospitalForeigner())) {
            hospitalOrganization.append(medicineCase.getHospitalForeigner()).append(" (").append(
                    medicineCase.getNation().getDescriptionIt()).append(")");
        } else {
            HospitalOrganization hospital = medicineCase.getHospitalOrganization();
            hospitalOrganization.append(medicineCase.getHospitalWard().getName()).append(" - ").append(hospital.
                    getName()).append(" (").append(hospital.getRegion().getDescription()).append(")");;
        }

        tab.addCell(getTitle("hospitalOrganization"));
        tab.addCell(getValue(hospitalOrganization.toString()));

        String orphanMedicine = "";
        if (medicineCase.getOrphanMedicine() != null) {
            if (medicineCase.getOrphanMedicine()) {
                orphanMedicine = "Si";
            }
            if (!medicineCase.getOrphanMedicine()) {
                orphanMedicine = "No";
            }
        }
        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("orphanMedicine"));
        tab.addCell(getValue(orphanMedicine));

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("medicineDescription"));
        tab.addCell(getValue(medicineCase.getMedicineDescription()));

        String categoryCMedicine = "";
        if (medicineCase.getCategoryCMedicine() != null) {
            if (medicineCase.getCategoryCMedicine()) {
                categoryCMedicine = "Si";
            }
            if (!medicineCase.getCategoryCMedicine()) {
                categoryCMedicine = "No";
            }
        }
        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("categoryCMedicine"));
        tab.addCell(getValue(categoryCMedicine));

        tab.addCell("");
        tab.addCell("");

        tab.addCell(getTitle("categoryCMedicineDescription"));
        tab.addCell(getValue(medicineCase.getCategoryCMedicineDescription()));

        final List<Exam> exams = caseManagement.getExamsOfMC(medicineCase.getId());
        for (Exam exam : exams) {
            tab.addCell("");
            tab.addCell("");

            tab.addCell(getTitle("exam"));
            tab.addCell(getValue(exam.getDescription()));
        }
        return tab;
    }

    public ByteArrayOutputStream createPatientDetailsPDF(final Patient patient) {
        ByteArrayOutputStream out = new ByteArrayOutputStream(1024 * 4);

        try {
            Document document = new Document(PageSize.A4, PDF_MARGIN, PDF_MARGIN, PDF_MARGIN, PDF_MARGIN);
            PdfWriter writer = PdfWriter.getInstance(document, out);
            document.open();

            Chapter capitolo1 = new Chapter(getTextC("det_pat_title_page", fontCapitolo, 0), 1);
            capitolo1.setNumberDepth(0);

            capitolo1.add(getPatientTwo(patient));

            document.add(capitolo1);
            document.close();
        } catch (DocumentException ex) {
            LOG.error("Error during pdf createPatientDetailsPDF", ex);
        }

        return out;
    }
}
