package net.tirasa.remara.console.pages;

import net.tirasa.remara.core.management.HospitalManagement;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import net.tirasa.remara.persistence.data.HospitalWard;
import net.tirasa.remara.persistence.data.Region;
import org.apache.wicket.PageParameters;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.Button;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.model.CompoundPropertyModel;
import org.apache.wicket.model.Model;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class UpdateHospitalWard extends BasePage {

    private static final long serialVersionUID = -6195289438678718231L;

    @SpringBean
    private HospitalManagement hospitalManagement;

    private HospitalWard hospitalWard;

    private final Form form;

    public UpdateHospitalWard(PageParameters parameters) {
        super();

        hospitalWard = (HospitalWard) parameters.get("hospitalWard");
        HospitalOrganization hospital = hospitalWard.getHospitalOrganization();
        Region region = hospital.getRegion();

        String strRegion = region.getDescription();
        String strHospital = hospital.getName();

        form = new Form("form", new CompoundPropertyModel(hospitalWard)) {

            private static final long serialVersionUID = -3061771342119019368L;

            @Override
            protected void onSubmit() {
                    hospitalManagement.update(hospitalWard);
                
                getSession().info(getString("info.save"));
                setResponsePage(new ListHospitalWard());
            }
        };
        add(form);

        form.add(new FeedbackPanel("feedback"));
        form.add(new Label("region", new Model(strRegion)));
        form.add(new Label("hospital", new Model(strHospital)));

        TextField wardName = new TextField("name");
        wardName.add(new SimpleAttributeModifier("title", getString("name")));
        form.add(wardName);

        form.add(new Button("save", new Model(getString("save"))));
        add(form);
    }
}
