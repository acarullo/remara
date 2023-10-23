package net.tirasa.remara.console.pages;

import net.tirasa.remara.console.utilities.StringUtils;
import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.core.management.Encoder;
import net.tirasa.remara.core.management.IllnessManagement;
import net.tirasa.remara.persistence.data.Illness;
import org.apache.wicket.PageParameters;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.Button;
import org.apache.wicket.markup.html.form.CheckBox;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.model.CompoundPropertyModel;
import org.apache.wicket.model.Model;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class NewIllness extends BasePage {

    private static final long serialVersionUID = 8615024079319072735L;

    @SpringBean
    private IllnessManagement illnessManagement;

    private Illness illness = null;

    private Form form;

    private boolean newIllness;

    private String typeButton = "";

    private boolean verifyForm() {

        toUtf(illness);

        boolean verify = true;
        String name = illness.getCode();
        String description = illness.getDescription();
        String exempt = illness.getExempt();

        if ((!StringUtils.containsLowerCase(name)) || (!StringUtils.containsLowerCase(description))
                || (!StringUtils.containsLowerCase(exempt))) {
            error(getString(WRONG_CHAR));
            verify = false;
        }

        return verify;

    }

    public NewIllness(final PageParameters parameters) {
        super();
        newIllness = false;
        if (parameters.containsKey("illness")) {
            illness = (Illness) parameters.get("illness");
            add(new Label("new_illness", getString("new_illness.update")));
        } else {
            illness = new Illness();
            newIllness = true;
            add(new Label("new_illness", getString("new_illness.new")));
        }
        add(new FeedbackPanel("feedback"));
        form = new Form("IllnessForm", new CompoundPropertyModel(illness)) {

            private static final long serialVersionUID = -3061771342119019368L;

            @Override
            protected void onSubmit() {
                if (!verifyForm()) {
                    return;
                }
                if (typeButton.equals("save")) {
                    try {
                        if (newIllness) {
                            illnessManagement.insert(illness, getRemaraUser().getUsername());
                        } else {
                            illnessManagement.update(illness);
                        }
                    } catch (DBException e) {
                        error(getString(e.getMessage()));
                        return;
                    }
                    info(getString("info.save"));
                    newIllness = false;
                    form.get("code").setEnabled(false);
                    form.setEnabled(false);
                    form.get("save").setVisible(false);
                }
            }
        };
        add(form);

        TextField code = new TextField("code");
        code.setRequired(true);
        code.setEnabled(newIllness);
        code.add(new SimpleAttributeModifier("title", getString("code")));
        form.add(code);
        TextField description = new TextField("description");
        description.setRequired(true);
        description.add(new SimpleAttributeModifier(
                "title", getString("description")));
        form.add(description);
        TextField exempt = new TextField("exempt");
        exempt.setRequired(true);
        exempt.add(new SimpleAttributeModifier("title", getString("exempt")));
        form.add(exempt);
        CheckBox marche = new CheckBox("marche");
        marche.add(new SimpleAttributeModifier("title", getString("marche")));
        form.add(marche);
        form.add(new Button("save", new Model(getString("save"))) {

            private static final long serialVersionUID = 429178684321093953L;

            @Override
            public void onSubmit() {
                typeButton = "save";
            }
        });
    }

    private void toUtf(final Illness illness) {
        if (illness.getDescription() != null) {
            illness.setDescription(
                    Encoder.toUtf(illness.getDescription()));
        }
        if (illness.getCode() != null) {
            illness.setCode(Encoder.toUtf(illness.getCode()));

        }
        if (illness.getExempt() != null) {
            illness.setExempt(Encoder.toUtf(illness.getExempt()));
        }
    }
}
