package net.tirasa.remara.console.pages;

import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.core.management.HospitalManagement;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import net.tirasa.remara.persistence.data.HospitalWard;
import net.tirasa.remara.persistence.data.Region;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.markup.html.form.AjaxButton;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.extensions.ajax.markup.html.modal.ModalWindow;
import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.model.Model;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class WardPopup extends WebPage {

    private static final long serialVersionUID = -6474300764112422277L;

    @SpringBean
    private HospitalManagement hospitalManagement;

    private final TextField wardName;

    private HospitalOrganization hospital;

    private final Form form;

    public WardPopup(final PageParameters parameters, final ModalWindow window, final WebPage newCase) {
        super(parameters);
        final NewCase newCasePage = (NewCase) newCase;
        Region region = (Region) parameters.get("region");
        hospital = (HospitalOrganization) parameters.get("hospital");

        String strRegion = "";
        if (region != null) {
            strRegion = region.getDescription();
        }

        String strHospital = "";
        if (hospital != null) {
            strHospital = hospital.getName();
        }

        form = new Form("form");
        add(form);

        form.add(new FeedbackPanel("feedback").setOutputMarkupId(true));

        String hospitalRequired = "";
        if (hospital == null || hospital.getId() == null) {
            form.setEnabled(false);
            hospitalRequired = getString("hospital.required");
        }
        add(new Label("hospital.required", new Model(hospitalRequired)));

        form.add(new Label("region", new Model(strRegion)));
        form.add(new Label("hospital", new Model(strHospital)));

        wardName = new TextField("wardName", new Model(""));
        wardName.add(new SimpleAttributeModifier("title", getString("wardName")));
        form.add(wardName);

        form.add(new AjaxButton("save", new Model(getString("save")), form) {

            private static final long serialVersionUID = -5112995114556934353L;

            @Override
            public void onSubmit(AjaxRequestTarget target, Form form) {
                String wardName = (String) ((TextField) form.get("wardName")).getModelObject();
                try {
                    HospitalWard hospitalWard = hospitalManagement.insertWard(hospital, wardName);
                    newCasePage.setHospitalWard(hospitalWard);
                    window.close(target);
                } catch (DBException ex) {
                    error(getString(ex.getMessage()));
                }
            }

            @Override
            protected void onError(AjaxRequestTarget target, Form form) {
                target.addComponent(form.get("feedback"));
            }
        });
        add(form);
    }
}
