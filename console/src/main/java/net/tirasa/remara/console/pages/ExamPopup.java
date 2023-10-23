package net.tirasa.remara.console.pages;

import net.tirasa.remara.console.utilities.Constants;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import net.tirasa.remara.persistence.data.Exam;
import net.tirasa.remara.persistence.data.FileCase;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.markup.html.form.AjaxButton;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.extensions.ajax.markup.html.modal.ModalWindow;
import org.apache.wicket.extensions.yui.calendar.DatePicker;
import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.RadioChoice;
import org.apache.wicket.markup.html.form.TextArea;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.form.upload.FileUpload;
import org.apache.wicket.markup.html.form.upload.MultiFileUploadField;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.markup.html.list.ListItem;
import org.apache.wicket.markup.html.list.ListView;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.model.CompoundPropertyModel;
import org.apache.wicket.model.IModel;
import org.apache.wicket.model.Model;
import org.apache.wicket.model.PropertyModel;
import org.apache.wicket.util.lang.Bytes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@AuthorizeInstantiation("ADMIN")
public class ExamPopup extends WebPage {

    private static final long serialVersionUID = 6429866496142655971L;

    private static final Logger LOG = LoggerFactory.getLogger(ExamPopup.class);

    private Form form;

    private Exam exam;

    List<FileCase> fileCases;

    private final Collection uploads = new ArrayList();

    private final SimpleDateFormat dateFormat = new SimpleDateFormat(getString("format_date"));

    public ExamPopup(final PageParameters parameters, final WebPage page, final ModalWindow window) {
        super(parameters);
        final NewCase newCasePage = (NewCase) page;
        fileCases = new ArrayList<FileCase>();

        exam = (Exam) parameters.get("exam");

        form = new Form("examForm", new CompoundPropertyModel(exam));

        form.add(new FeedbackPanel("feedback").setOutputMarkupId(true));

        IModel modelLTypeExam = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                String typeExam = exam.getTypeExam();
                if (typeExam == null || typeExam.isEmpty()) {
                    return null;
                }
                return getString(typeExam);
            }

            @Override
            public void setObject(final Serializable object) {
                super.setObject(object);
                exam.setTypeExam(null);
                if (object == null) {
                    return;
                }
                String typeExam = object.toString();
                if (typeExam.equals(getString("hematic"))) {
                    exam.setTypeExam("hematic");
                }
                if (typeExam.equals(getString("instrumental"))) {
                    exam.setTypeExam("instrumental");
                }
                if (typeExam.equals(getString("clinical"))) {
                    exam.setTypeExam("clinical");
                }
            }
        };

        List typeExamList = Arrays.asList(new String[]{
            getString("clinical"),
            getString("instrumental"),
            getString("hematic")
        });
        RadioChoice typeExam = new RadioChoice("typeExam", modelLTypeExam, typeExamList);
        typeExam.setRequired(true);
        form.add(typeExam);

        form.add(new TextArea("description").setRequired(true));
        form.add(new TextArea("report"));
        form.add(new TextArea("criterion"));

        final Model<Date> examDateModel = new Model() {

            private static final long serialVersionUID = 1088212074765051906L;

            @Override
            public Serializable getObject() {
                Date typeStartingDate = exam.getDataExam();
                if (typeStartingDate == null) {
                    return null;
                }
                return dateFormat.format(typeStartingDate);
            }

            @Override
            public void setObject(final Serializable object) {
                if (object != null) {

                    if (object instanceof Date) {

                        Date data = (Date) object;

                        LOG.info("Setting exam date to {}", data);

                        exam.setDataExam(data);
                    } else {
                        try {
                            LOG.info("Setting exam date to {}", object.toString());
                            exam.setDataExam(dateFormat.parse(object.toString()));
                        } catch (ParseException ex) {
                            LOG.error("Error parsing starting date illness {}", ex.getMessage(), ex);
                        }
                    }
                } else {
                    exam.setDataExam(null);
                }
            }
        };

        final TextField examDate = new TextField<Date>("dataExam", examDateModel);
        examDate.setOutputMarkupId(true);

        final DatePicker examDatePicker = new DatePicker() {

            private static final long serialVersionUID = 4166072895162221956L;

            @Override
            protected String getDatePattern() {
                return getString("format_date");
            }

            public void setFORMAT_DATE() {
                DatePicker.FORMAT_DATE = getString("format_date");
            }

            @Override
            protected boolean enableMonthYearSelection() {
                return true;
            }
        };

        examDate.add(examDatePicker);

        form.add(examDate);

        form.setMultiPart(true);
        MultiFileUploadField fileUpload = new MultiFileUploadField("fileInput", new PropertyModel(this, "uploads"),
                Constants.MAX_FILE_UPLOAD);

        form.add(fileUpload);
        form.setMaxSize(Bytes.kilobytes(Constants.MAX_K_SIZE));
        ListView fileListView = new ListView("fileList", exam.getFileCases()) {

            private static final long serialVersionUID = 4949588177564901031L;

            @Override
            protected void populateItem(final ListItem item) {
                final FileCase file = (FileCase) item.getModelObject();
                item.add(new Label("file", file.getName()));
                item.add(new Link("delete") {

                    private static final long serialVersionUID = -4331619903296515985L;

                    @Override
                    public void onClick() {
                        exam.getFileCases().remove(file);
                        newCasePage.getTempDeletedFiles().add(file);
                        newCasePage.getFilesToDelete().add(file);
                    }
                });
            }
        };

        form.add(fileListView);

        form.add(new AjaxButton("save", new Model(getString("save")), form) {

            private static final long serialVersionUID = -5112995114556934353L;

            @Override
            public void onSubmit(final AjaxRequestTarget target, final Form form) {
                Iterator it = uploads.iterator();
                String fileName;
                while (it.hasNext()) {
                    final FileUpload upload = (FileUpload) it.next();

                    try {
                        InputStream reader = upload.getInputStream();
                        ByteArrayOutputStream output = new ByteArrayOutputStream();
                        int c;
                        while ((c = reader.read()) > -1) {
                            output.write(c);
                        }
                        fileName = upload.getClientFileName();
                        FileCase fc = new FileCase();
                        fc.setExam(exam);
                        fc.setName(fileName);
                        fc.setFile(output.toByteArray());
                        exam.getFileCases().add(fc);
                    } catch (IOException e) {
                        LOG.error("Unable to load file", e);
                        throw new IllegalStateException("Unable to read file");
                    }
                    upload.delete();
                }
                exam.setMedicineCase(newCasePage.getMC());
                newCasePage.getMC().getExams().add(exam);
                window.close(target);
            }

            @Override
            protected void onError(final AjaxRequestTarget target, final Form form) {
                target.addComponent(form.get("feedback"));
            }
        });
        add(form);
    }
}
