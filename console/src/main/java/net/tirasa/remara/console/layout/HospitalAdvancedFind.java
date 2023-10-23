package net.tirasa.remara.console.layout;

import net.tirasa.remara.console.pages.ListHospitals;
import net.tirasa.remara.console.pages.ListIllness;
import org.apache.wicket.PageParameters;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.markup.html.form.Button;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.model.Model;

public class HospitalAdvancedFind extends AbstractPanel {

    private static final long serialVersionUID = -6279411789068087354L;

    private TextField findName;
    private TextField findRegion;

    public HospitalAdvancedFind(final String id, final String name) {
        super(id);

        final Form findForm = new Form("search") {
            private static final long serialVersionUID = 7283381648682393116L;

            @Override
            protected void onSubmit() {
                final PageParameters parameters = new PageParameters();
                parameters.put("findName", findName.getModelObject());
                parameters.put("findRegion", findRegion.getModelObject());
                setResponsePage(new ListHospitals());
            }
        };
        add(findForm);

        findName = new TextField("findName", new Model(name));
        findName.add(new SimpleAttributeModifier("title", getString("name")));
        findForm.add(findName);

        findForm.add(new Button("find", new Model(getString("find"))));

        findForm.add(new Link("link") {
            private static final long serialVersionUID = -4331619903296515985L;

            @Override
            public void onClick() {
                setResponsePage(new ListIllness(new PageParameters()));
            }
        });
    }
}
