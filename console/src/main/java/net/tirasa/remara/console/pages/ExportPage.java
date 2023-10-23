package net.tirasa.remara.console.pages;

import net.tirasa.remara.core.management.ExportManagement;
import net.tirasa.remara.core.management.HospitalManagement;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import net.tirasa.remara.persistence.data.Export;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import org.apache.wicket.Page;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.markup.html.form.AjaxButton;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.datetime.markup.html.form.DateTextField;
import org.apache.wicket.extensions.ajax.markup.html.modal.ModalWindow;
import org.apache.wicket.extensions.yui.calendar.DatePicker;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.markup.html.list.ListItem;
import org.apache.wicket.markup.html.list.PageableListView;
import org.apache.wicket.markup.html.navigation.paging.PagingNavigator;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.model.Model;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class ExportPage extends BasePage {

    private static final long serialVersionUID = 3859707998442217255L;

    @SpringBean
    private HospitalManagement hospitalManagement;

    @SpringBean
    private ExportManagement exportManagement;

    private static final String DATE_FROM = "dateFrom";

    private static final String DATE_TO = "dateTo";

    private static final String HOSPITAL_ORGANIZATION = "hospitalOrganization";

    private Form form;

    private Export export;

    public ExportPage() {
        super();

        final ModalWindow exportPopup = new ModalWindow("exportPopup");
        add(exportPopup);

        exportPopup.setPageMapName(getString("titleExportPopup"));
        exportPopup.setCookieName("exportViewModal");
        exportPopup.setTitle(getString("titleExportPopup"));

        form = new Form("exportForm");
        add(form);

        form.add(new FeedbackPanel("feedback").setOutputMarkupId(true));

        final String formatDate = getString("format_date");
        final DateTextField dateFrom = DateTextField.forDatePattern(
                DATE_FROM, new Model(null), formatDate);
        dateFrom.setRequired(true);
        dateFrom.add(new SimpleAttributeModifier("title", getString(DATE_FROM)));
        dateFrom.add(new DatePicker() {

            private static final long serialVersionUID = 4166072895162221956L;

            @Override
            protected boolean enableMonthYearSelection() {
                return true;
            }
        });
        form.add(dateFrom);
        final DateTextField dateTo = DateTextField.forDatePattern(DATE_TO, new Model(null), formatDate);
        dateTo.setRequired(true);
        dateTo.add(new SimpleAttributeModifier(
                "title", getString(DATE_TO)));
        dateTo.add(new DatePicker() {

            private static final long serialVersionUID = 4166072895162221956L;

            @Override
            protected boolean enableMonthYearSelection() {
                return true;
            }
        });
        form.add(dateTo);

        form.add(new AjaxButton("export", new Model(getString("export")), form) {

            private static final long serialVersionUID = -5741260185776705207L;

            @Override
            protected void onSubmit(final AjaxRequestTarget target, final Form thisForm) {
                target.addComponent(form.get("feedback"));
                final Date dateFrom = (Date) ((TextField) thisForm.get(DATE_FROM)).getModelObject();
                final Date dateTo = (Date) ((TextField) thisForm.get(DATE_TO)).getModelObject();
                final String code = "ISSMR_MAR";
                final HospitalOrganization hospital = hospitalManagement.findByCode("11090501").get(0);

                exportPopup.setPageCreator(new ModalWindow.PageCreator() {

                    private static final long serialVersionUID = -7834632442532690940L;

                    public Page createPage() {
                        final PageParameters parameters = new PageParameters();
                        parameters.put(DATE_FROM, dateFrom);
                        parameters.put(DATE_TO, dateTo);
                        parameters.put("code", code);
                        parameters.put(HOSPITAL_ORGANIZATION, hospital);
                        return new ExportPopup(parameters, exportPopup);
                    }
                });
                exportPopup.show(target);

            }

            @Override
            protected void onError(AjaxRequestTarget target, Form form) {
                target.addComponent(form.get("feedback"));
            }
        });

        List<Export> exportsList = exportManagement.findAllExport();

        PageableListView datas = new PageableListView("exportsList", exportsList, 5) {

            private static final long serialVersionUID = -9186076471982907981L;

            private final DateFormat df = DateFormat.getDateInstance(DateFormat.MEDIUM, getLocale());

            @Override
            protected void populateItem(final ListItem item) {
                final Export export = (Export) item.getModelObject();

                item.add(new Label("date_send", df.format(export.getExportdate())));
                item.add(new Label("comment", export.getComment()));

                Link linkDelete = new Link("linkDelete", item.getModel()) {

                    private static final long serialVersionUID = -5665438703028610801L;

                    @Override
                    public void onClick() {
                        exportManagement.delete(export);

                        getSession().info(getString("info.delete"));
                        setResponsePage(new ExportPage());
                    }
                };
                linkDelete.add(new SimpleAttributeModifier("title", getString("delete")));
                linkDelete.add(new SimpleAttributeModifier("onclick", "return confirm('" + getString("confirm_delete")
                        + "');"));
                item.add(linkDelete);

            }
        };

        add(new PagingNavigator("headerPaginator", datas));
        add(datas);

        final DateTextField exportDate = DateTextField.forDatePattern("exportDate", new Model(null), formatDate);
        exportDate.setRequired(true);
        exportDate.add(new SimpleAttributeModifier("title", getString("exportDate")));
        exportDate.add(new DatePicker() {

            private static final long serialVersionUID = 4166072895162221956L;

            @Override
            protected boolean enableMonthYearSelection() {
                return true;
            }
        });

        final TextField comment = new TextField("comment", Model.of(""));
        comment.setRequired(true);
        comment.add(new SimpleAttributeModifier("title", getString("comment")));

        export = new Export();
        final Form exportFormDb = new Form("exportFormDb") {

            private static final long serialVersionUID = -3061771342119019368L;

            @Override
            protected void onSubmit() {
                export.setComment((String) comment.getModelObject());
                export.setExportdate((Date) exportDate.getModelObject());

                if (!verifyForm()) {
                    return;
                }

                exportManagement.insert(export);

                info(getString("info.save"));
                setResponsePage(new ExportPage());
            }
        };
        exportFormDb.add(exportDate);
        exportFormDb.add(comment);
        add(exportFormDb);

    }

    private boolean verifyForm() {

        boolean verify = true;
        String comment = export.getComment();
        Date date = export.getExportdate();

        if (comment == null || comment.isEmpty()) {
            error(getString("comment.export.Required"));
            verify = false;
        }

        if (date == null || date.toString().isEmpty()) {
            error(getString("date.export.Required"));
            verify = false;
        }

        return verify;

    }
}
