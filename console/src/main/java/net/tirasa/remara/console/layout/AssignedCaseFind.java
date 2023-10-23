package net.tirasa.remara.console.layout;

import net.tirasa.remara.console.pages.CaseAssigned;
import net.tirasa.remara.console.wicket.FormComponentFactory;
import org.apache.wicket.PageParameters;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.TextField;

public class AssignedCaseFind extends AbstractPanel {

    private static final long serialVersionUID = 7818344387839217176L;

    private final FormComponentFactory formComponentFactory = new FormComponentFactory();

    private final TextField findText;

    public AssignedCaseFind(final String id, final String text) {
        super(id);
        findText = formComponentFactory.textField("findText", text);
        add(createForm());
    }

    private Form createForm() {
        final Label insertSurname = searchLabel();
        final Form findForm = new Form("search") {

            private static final long serialVersionUID = 7283381648682393116L;

            @Override
            protected void onSubmit() {
                PageParameters parameters = new PageParameters();
                parameters.put("findText", findText.getModelObject());
                setResponsePage(new CaseAssigned(parameters));
            }
        };
        findForm.add(insertSurname);
        findForm.add(findText);
        findForm.add(formComponentFactory.button("find"));
        return findForm;
    }
}
