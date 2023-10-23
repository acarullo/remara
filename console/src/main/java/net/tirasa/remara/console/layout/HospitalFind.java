package net.tirasa.remara.console.layout;

import net.tirasa.remara.console.pages.ListHospitals;
import org.apache.wicket.PageParameters;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.markup.html.form.Button;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.model.Model;

public final class HospitalFind extends AbstractPanel {

    private static final long serialVersionUID = -3541749505453173885L;

    private TextField findCode;

    private TextField findRegion;

    public HospitalFind(final String id, final String text) {
        super(id);

        final Form findForm = new Form("search") {

            private static final long serialVersionUID = 7283381648682393116L;

            @Override
            protected void onSubmit() {
                PageParameters parameters = new PageParameters();
                parameters.put("findCode", findCode.getModelObject());
                parameters.put("findRegion", findRegion.getModelObject());
                setResponsePage(new ListHospitals());
            }
        };
        add(findForm);

        findCode = new TextField("findCode", new Model(text));
        findCode.add(new SimpleAttributeModifier("title", getString("findCode")));
        findForm.add(findCode);

        findRegion = new TextField("findRegion", new Model(text));
        findRegion.add(new SimpleAttributeModifier("title", getString("findRegion")));
        findForm.add(findRegion);

        findForm.add(new Button("find", new Model(getString("find"))));

        findForm.add(new Link("link") {

            private static final long serialVersionUID = -4331619903296515985L;

            @Override
            public void onClick() {
                final PageParameters parameters = new PageParameters();
                parameters.put("findCode", "");
                parameters.put("findRegion", "");
                setResponsePage(new ListHospitals());
            }
        });
    }
}
