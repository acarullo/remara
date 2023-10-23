package net.tirasa.remara.console.pages;

import net.tirasa.remara.core.management.ExportManagement;
import net.tirasa.remara.core.resource.IResourceStringImpl;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.markup.html.form.AjaxButton;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.extensions.ajax.markup.html.modal.ModalWindow;
import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.markup.html.WebResource;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.link.ResourceLink;
import org.apache.wicket.model.Model;
import org.apache.wicket.protocol.http.WebResponse;
import org.apache.wicket.spring.injection.annot.SpringBean;
import org.apache.wicket.util.resource.IResourceStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@AuthorizeInstantiation("ADMIN")
public class ExportPopup extends WebPage {

    private static final Logger LOG = LoggerFactory.getLogger(ExportPopup.class);

    @SpringBean
    private ExportManagement exportManagement;

    private static final long serialVersionUID = -8473740273641403671L;

    private Form form;

    private String code;

    private Date dateFrom;

    private Date dateTo;

    private HospitalOrganization hospitalOrganization;

    public ExportPopup(final PageParameters parameters, final ModalWindow window) {
        super(parameters);

        final Calendar currentDate = Calendar.getInstance(); //Get the current date
        final SimpleDateFormat formatter = new SimpleDateFormat("dd_MMM_yyyy"); //format it as per your requirement
        final String dateNow = formatter.format(currentDate.getTime());

        final String FILE_ANAGRAFIC = dateNow + "_A.TXT";

        final String FILE_ILLNESS = dateNow + "_P.TXT";

        code = (String) parameters.get("code");
        dateFrom = (Date) parameters.get("dateFrom");
        dateTo = (Date) parameters.get("dateTo");
        hospitalOrganization = (HospitalOrganization) parameters.get("hospitalOrganization");

        form = new Form("exportForm");
        add(form);

        final AjaxButton ab = new AjaxButton("end", new Model(getString("end")), form) {

            private static final long serialVersionUID = 101423384012287742L;

            @Override
            public void onSubmit(AjaxRequestTarget target, Form form) {
                try {
                    exportManagement.setCode(code);
                    exportManagement.setFrom(dateFrom);
                    exportManagement.setSped(new Date());
                    exportManagement.setTo(dateTo);
                    exportManagement.setHospitalOrganization(hospitalOrganization);
                    exportManagement.termite();
                } catch (Exception ex) {
                    LOG.error("Error on submit", ex);
                }
                window.close(target);
            }
        };

        ab.add(new SimpleAttributeModifier("onclick", "return confirm('" + getString("confirm_delete") + "');"));

        form.add(ab);

        final WebResource exportAnagrafica = new WebResource() {

            private static final long serialVersionUID = -4012743406022686197L;

            @Override
            public IResourceStream getResourceStream() {
                String source = "";
                try {
                    exportManagement.setCode(code);
                    exportManagement.setFrom(dateFrom);
                    exportManagement.setSped(new Date());
                    exportManagement.setTo(dateTo);
                    exportManagement.setHospitalOrganization(hospitalOrganization);
                    source = exportManagement.export1();
                } catch (Exception ex) {
                    LOG.error("Error on submit", ex);
                }
                return new IResourceStringImpl(source, getLocale(), FILE_ANAGRAFIC);
            }

            @Override
            protected void setHeaders(final WebResponse response) {
                super.setHeaders(response);
                BasePage.responeSetHeader(response);
                response.setAttachmentHeader(FILE_ANAGRAFIC);
            }
        };
        exportAnagrafica.setCacheable(false);
        add(new ResourceLink("linkFileA", exportAnagrafica));

        final WebResource exportPatologie = new WebResource() {

            private static final long serialVersionUID = -4012743406022686197L;

            @Override
            public IResourceStream getResourceStream() {
                String source = "";
                try {
                    exportManagement.setCode(code);
                    exportManagement.setFrom(dateFrom);
                    exportManagement.setSped(new Date());
                    exportManagement.setTo(dateTo);
                    exportManagement.setHospitalOrganization(hospitalOrganization);
                    source = exportManagement.export2();
                } catch (final Exception ex) {
                    LOG.error("Error on submit", ex);
                }
                return new IResourceStringImpl(source, getLocale(), FILE_ILLNESS);
            }

            @Override
            protected void setHeaders(final WebResponse response) {
                super.setHeaders(response);
                BasePage.responeSetHeader(response);
                response.setAttachmentHeader(FILE_ILLNESS);
            }
        };
        exportPatologie.setCacheable(false);
        add(new ResourceLink("linkFileP", exportPatologie));
    }
}
