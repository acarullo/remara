package net.tirasa.remara.console.layout;

import net.tirasa.remara.console.pages.ListIllness;
import org.apache.wicket.PageParameters;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.markup.html.form.Button;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.model.Model;

public final class IllnessAdvancedFind extends AbstractPanel {

    private static final long serialVersionUID = 3533525189977152797L;

    private TextField findCode;

    private TextField findDescription;

    private TextField findExempt;

    public IllnessAdvancedFind(String id, String code, String description, String exempt) {
        super(id);

        Form findForm = new Form("search") {

            private static final long serialVersionUID = 7283381648682393116L;

            @Override
            protected void onSubmit() {
                PageParameters parameters = new PageParameters();
                parameters.put("findCode", findCode.getModelObject());
                parameters.put("findDescription", findDescription.getModelObject());
                parameters.put("findExempt", findExempt.getModelObject());
                setResponsePage(new ListIllness(parameters));
            }
        };
        add(findForm);

        findCode = new TextField("findCode", new Model(code));
        findCode.add(new SimpleAttributeModifier("title", getString("code")));
        findForm.add(findCode);

        findDescription = new TextField("findDescription", new Model(description));
        findDescription.add(new SimpleAttributeModifier("title", getString("description")));
        findForm.add(findDescription);

        findExempt = new TextField("findExempt", new Model(exempt));
        findExempt.add(new SimpleAttributeModifier("title", getString("exempt")));
        findForm.add(findExempt);

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
