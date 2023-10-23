package net.tirasa.remara.console.layout;

import net.tirasa.remara.console.pages.ListAdvCases;
import net.tirasa.remara.console.wicket.FormComponentFactory;
import org.apache.wicket.PageParameters;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.TextField;

public class CaseFind extends AbstractPanel {

    private static final long serialVersionUID = -4353006770898433964L;

    private final FormComponentFactory formComponentFactory = new FormComponentFactory();

    private final TextField findText;

    public CaseFind(final String id, final String text) {
        super(id);
        findText = formComponentFactory.textField("findText", text);
        add(createForm());
    }

    private Form createForm() {
        Label insertSurname = searchLabel();
        final Form findForm = new Form("search") {

            private static final long serialVersionUID = 7283381648682393116L;

            @Override
            protected void onSubmit() {
                PageParameters parameters = new PageParameters();
                parameters.put("findText", findText.getModelObject());
                setResponsePage(new ListAdvCases(parameters));
            }
        };
        findForm.add(insertSurname);
        findForm.add(findText);
        findForm.add(formComponentFactory.button("find"));
        return findForm;
    }
}
