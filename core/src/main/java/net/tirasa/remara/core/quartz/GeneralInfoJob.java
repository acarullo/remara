package net.tirasa.remara.core.quartz;

import com.itextpdf.text.BadElementException;
import com.itextpdf.text.Chapter;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Section;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ResourceBundle;
import net.tirasa.remara.core.management.CaseManagement;
import net.tirasa.remara.core.management.PatientManagement;
import net.tirasa.remara.core.workflow.WorkflowManager;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;

@Component
public class GeneralInfoJob extends QuartzJobBean {

    private static final Logger LOG = LoggerFactory.getLogger(GeneralInfoJob.class);

    @Autowired
    private CaseManagement caseManagement;

    @Autowired
    private PatientManagement patientManagement;

    private static final int PDF_MARGIN = 60;

    private static final ResourceBundle titles = ResourceBundle.getBundle(GeneralInfoJob.class.getName());

    private static final Font fontCapitolo = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD);

    private static final Font fontSottoCapitolo = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);

    private static final Font fontDescrizione = new Font(Font.FontFamily.HELVETICA, 9, Font.BOLDITALIC);

    private static final Font fontValue = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD);

    @Override
    protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
        LOG.debug("GeneralInfoJob: generating file from general info on system ReMaRa");
        String fileName = "/var/tmp/GeneralInfoReMaRa_" + new SimpleDateFormat("dd-MM-yyyy").format(new Date()) + ".pdf";
        try {
            Document document = new Document(PageSize.A4, PDF_MARGIN, PDF_MARGIN, PDF_MARGIN, PDF_MARGIN);

            PdfWriter pdfWriter = PdfWriter.getInstance(document, new FileOutputStream(fileName));
            document.open();

            Chapter capitolo1 = new Chapter(getTextC("gen_info_title_page", fontCapitolo, 0), 1);
            capitolo1.setNumberDepth(0);
            Paragraph paragraph = new Paragraph();
            addEmptyLine(paragraph, 3);
            capitolo1.add(paragraph);
            // add general info table
            createTable(capitolo1);
            document.add(capitolo1);
            document.close();
        } catch (DocumentException e) {
            LOG.error("Error during patient pdf creation", e);
        } catch (FileNotFoundException e) {
            LOG.error("Error during patient pdf creation: file not found", e);
        }
    }

    private void createTable(Section subCatPart)
            throws BadElementException {
        PdfPTable table = new PdfPTable(2);

        PdfPCell c1 = new PdfPCell(new Phrase("Tipologia elemento", fontSottoCapitolo));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        c1.setPaddingBottom(10);
        table.addCell(c1);

        c1 = new PdfPCell(new Phrase("Valore", fontSottoCapitolo));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c1);
        table.setHeaderRows(1);

        table.addCell(new Phrase("Pazienti totali", fontDescrizione));
        table.addCell(getNewCell(String.valueOf(patientManagement.countPatients())));
        table.addCell(new Phrase("Pazienti di sesso Maschile", fontDescrizione));
        table.addCell(getNewCell(String.valueOf(patientManagement.countSexPatients("M"))));
        table.addCell(new Phrase("Pazienti di sesso Femminile", fontDescrizione));
        table.addCell(getNewCell(String.valueOf(patientManagement.countSexPatients("F"))));
        table.addCell(new Phrase("Pazienti Maggiorenni", fontDescrizione));
        table.addCell(getNewCell(String.valueOf(patientManagement.countAdultPatients())));
        table.addCell(new Phrase("Pazienti Minorenni", fontDescrizione));
        table.addCell(getNewCell(String.valueOf(patientManagement.countMinorPatients())));
        table.addCell(new Phrase("Casi totali", fontDescrizione));
        table.addCell(getNewCell(String.valueOf(caseManagement.countCases())));
        table.addCell(new Phrase("Casi Approvati", fontDescrizione));
        table.addCell(getNewCell(String.valueOf(caseManagement.countStatusCases(WorkflowManager.STATUS_APPROVED))));
        table.addCell(new Phrase("Casi in attesa di conferma", fontDescrizione));
        table.addCell(getNewCell(String.valueOf(caseManagement.countStatusCases(WorkflowManager.STATUS_UNDERWAY))));
        table.addCell(new Phrase("Casi Rigettati", fontDescrizione));
        table.addCell(getNewCell(String.valueOf(caseManagement.countStatusCases(WorkflowManager.STATUS_REJECTED))));
        table.addCell(new Phrase("Casi in Coda", fontDescrizione));
        table.addCell(getNewCell(String.valueOf(caseManagement.countStatusCases(WorkflowManager.STATUS_QUEUED))));
        table.addCell(new Phrase("Casi Assegnati", fontDescrizione));
        table.addCell(getNewCell(String.valueOf(caseManagement.countStatusCases(WorkflowManager.STATUS_ASSIGNED))));
        table.addCell(new Phrase("Casi ex Pubertà Precoce Idiopatica", fontDescrizione));
        table.addCell(getNewCell(String.valueOf(caseManagement.countExPP())));

        subCatPart.add(table);

    }

    private static Paragraph getTextC(final String s, final Font font, final float f) {
        Paragraph paragraph = new Paragraph(titles.getString(s), font);
        paragraph.setAlignment(Paragraph.ALIGN_CENTER);
        if (f > 0) {
            paragraph.setSpacingBefore(f);
        }
        return paragraph;
    }

    private static PdfPCell getNewCell(final String content) {
        PdfPCell newCell = new PdfPCell(new Phrase(content, fontValue));
        newCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        return newCell;
    }

    private static void addEmptyLine(Paragraph paragraph, final int number) {
        for (int i = 0; i < number; i++) {
            paragraph.add(new Paragraph(" "));
        }
    }
}
