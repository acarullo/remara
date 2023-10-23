package net.tirasa.remara.console.pages;

import net.tirasa.remara.core.resource.IResourcePDFImpl;
import java.text.DateFormat;
import net.tirasa.remara.persistence.data.Patient;
import org.apache.wicket.PageParameters;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.markup.html.WebResource;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.link.ResourceLink;
import org.apache.wicket.model.Model;
import org.apache.wicket.protocol.http.WebResponse;
import org.apache.wicket.spring.injection.annot.SpringBean;
import org.apache.wicket.util.resource.IResourceStream;

@AuthorizeInstantiation("ADMIN")
public class PatientViewPopup extends WebPage {

    private static final long serialVersionUID = 5006402177722526381L;

    @SpringBean
    private IResourcePDFImpl iResourcePDFImpl;

    private DateFormat df = null;

    public PatientViewPopup(final PageParameters parameters) {
        super(parameters);

        final Patient patient = (Patient) parameters.get("patient");
        WebResource export = new WebResource() {

            private static final long serialVersionUID = 1L;

            @Override
            public IResourceStream getResourceStream() {
                return iResourcePDFImpl.iResourcePDFImpl(patient, false);
            }

            @Override
            protected void setHeaders(WebResponse response) {
                super.setHeaders(response);
                response.setHeader("Pragma", "public");
                response.setHeader("Cache-Control", "no-store, must-revalidate");
                response.setHeader("Expires", "-1");
                response.setAttachmentHeader(patient.getSurname() + ".pdf");
            }
        };
        export.setCacheable(false);

        ResourceLink linkPrint = new ResourceLink("linkPrint", export);
        linkPrint.add(new SimpleAttributeModifier("title", getString("print")));
        add(linkPrint);

        String name = patient.getName() + " " + patient.getSurname();
        String foreigner = patient.getForeigner();
        String birthAddress = "";
        if (foreigner.equals("Italia")) {
            if (patient.getBirthMunicipality() != null) {
                birthAddress += patient.getBirthMunicipality().getDescription();
            }
            if (patient.getBirthProvince() != null) {
                birthAddress += " (" + patient.getBirthProvince().getId() + ") ";
            }
            if (patient.getBirthCap() != null && !patient.getBirthCap().isEmpty()) {
                birthAddress += " - " + patient.getBirthCap();
            }
        } else {
            birthAddress += " " + patient.getBirthForeignInformation();
            if (patient.getBirthNation() != null) {
                birthAddress += " " + patient.getBirthNation().getDescriptionIt();
            }
        }

        String residence = "";
        if (patient.getLivingAddress() != null) {
            residence = patient.getLivingAddress();
        }

        if (patient.getLivingMunicipality() != null) {
            residence += " " + patient.getLivingMunicipality().getDescription();
        }
        if (patient.getLivingProvince() != null) {
            residence += " (" + patient.getLivingProvince().getId() + ") ";
        }
        if (patient.getLivingCap() != null && !patient.getLivingCap().isEmpty()) {
            residence += " - " + patient.getLivingCap();
        }
        String personalEducation = "";
        if (patient.getPersonalEducation() != null) {
            personalEducation = patient.getPersonalEducation().getDescriptionIt();
        }
        String personalOccupation = "";
        if (patient.getPersonalOccupation() != null) {
            personalOccupation = patient.getPersonalOccupation().getDescriptionIt();
        }
        String motherEducation = "";
        if (patient.getMotherEducation() != null) {
            motherEducation = patient.getMotherEducation().getDescriptionIt();
        }
        String fatherEducation = "";
        if (patient.getFatherEducation() != null) {
            fatherEducation = patient.getFatherEducation().getDescriptionIt();
        }
        String motherOccupation = "";
        if (patient.getMotherOccupation() != null) {
            motherOccupation = patient.getMotherOccupation().getDescriptionIt();
        }
        String fatherOccupation = "";
        if (patient.getFatherOccupation() != null) {
            fatherOccupation = patient.getFatherOccupation().getDescriptionIt();
        }
        df = DateFormat.getDateInstance(DateFormat.MEDIUM, getLocale());
        String deathDate = "";
        if (patient.getDeathDate() != null) {
            deathDate = df.format(patient.getDeathDate());
        }

        add(new Label("name", new Model(name)));
        add(new Label("sex", new Model(patient.getSex())));
        add(new Label("taxCode", new Model(patient.getTaxCode())));
        add(new Label("telephone", new Model(patient.getTelephone())));
        add(new Label("birthDate", new Model(df.format(patient.getBirthDate()))));
        add(new Label("deathDate", new Model(deathDate)));
        add(new Label("place_of_birth", new Model(birthAddress)));
        add(new Label("residence", new Model(residence)));
        add(new Label("personalEducation", new Model(personalEducation)));
        add(new Label("personalOccupation", new Model(personalOccupation)));
        add(new Label("exactlyOccupation", new Model(patient.getExactlyOccupation())));
        add(new Label("motherEducation", new Model(motherEducation)));
        add(new Label("fatherEducation", new Model(fatherEducation)));
        add(new Label("motherOccupation", new Model(motherOccupation)));
        add(new Label("fatherOccupation", new Model(fatherOccupation)));
    }
}
