package net.tirasa.remara.console.layout;

import net.tirasa.remara.console.pages.ListIllness;
import org.apache.wicket.PageParameters;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.Button;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.model.Model;

public final class IllnessFind extends AbstractPanel {

    private static final long serialVersionUID = -2767228440698651831L;

    private TextField findText;

    public IllnessFind(String id, String text) {
        super(id);
        Label insertData = new Label("insertData", "Inserisci Descrizione, Codice o Cod. Esenzione");
        Form findForm = new Form("search") {

            private static final long serialVersionUID = 7283381648682393116L;

            @Override
            protected void onSubmit() {
                PageParameters parameters = new PageParameters();
                parameters.put("findText", findText.getModelObject());
                setResponsePage(new ListIllness(parameters));
            }
        };
        add(findForm);

        findForm.add(insertData);
        findText = new TextField("findText", new Model(text));
        findText.add(new SimpleAttributeModifier("title", getString("findText")));
        findForm.add(findText);

        findForm.add(new Button("find", new Model(getString("find"))));

        findForm.add(new Link("link") {

            private static final long serialVersionUID = -4331619903296515985L;

            @Override
            public void onClick() {
                PageParameters parameters = new PageParameters();
                parameters.put("findCode", "");
                setResponsePage(new ListIllness(parameters));
            }
        });
    }
}
