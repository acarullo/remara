package net.tirasa.remara.console.wicket;

import java.util.List;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.markup.html.form.*;
import org.apache.wicket.model.IModel;
import org.apache.wicket.model.Model;

@AuthorizeInstantiation("ADMIN")
public class FormComponentFactory extends WebPage {

    private static final long serialVersionUID = 6695453434035200923L;

    public final PasswordTextField passwordTextField(final String id) {
        PasswordTextField passwordTextField = new PasswordTextField(id, new Model(""));
        passwordTextField.add(simpleAttributeModifier(id));
        passwordTextField.setRequired(true);
        return passwordTextField;
    }

    public final DropDownChoice dropDownChoice(final String renderId,
            final String id, final List data) {
        final ChoiceRenderer renderer = new ChoiceRenderer(renderId, "id");
        final DropDownChoice dropDownChoice = new DropDownChoice(id, data, renderer);
        dropDownChoice.add(simpleAttributeModifier(id));
        return dropDownChoice;
    }

    public final DropDownChoice dropDownChoice(final String rendererId,
            final String id, final IModel model) {
        final ChoiceRenderer renderer = new ChoiceRenderer(rendererId, "id");
        final DropDownChoice dropDownChoice = new DropDownChoice(id, model, renderer);
        dropDownChoice.add(simpleAttributeModifier(id));
        return dropDownChoice;
    }

    public final TextField textField(final String id) {
        final TextField textField = new TextField(id);
        textField.add(simpleAttributeModifier(id));
        return textField;
    }

    public final TextField textFieldWithDifferentSimpleAttributeModifierId(
            final String id, final String samId) {
        final TextField textField = new TextField(id);
        textField.add(simpleAttributeModifier(samId));
        return textField;
    }

    public final TextField textField(final String id, final String text) {
        final TextField textField = new TextField(id, new Model(text));
        textField.add(simpleAttributeModifier(id));
        return textField;
    }

    private SimpleAttributeModifier simpleAttributeModifier(final String id) {
        return new SimpleAttributeModifier("title", getString(id));
    }

    public final RadioChoice radioChoice(final String id, final List data) {
        return new RadioChoice(id, data);
    }

    public final TextField dateTextField(final String id) {
        final TextField textField = new TextField(id);
        textField.add(new SimpleAttributeModifier(
                "title", getString(id)));
        return textField;
    }

    public final HiddenField hiddenField(final String id, final IModel iModel) {
        return new HiddenField(id, iModel);
    }

    public final Button button(final String id) {
        return new Button(id, new Model(getString(id)));
    }
}
