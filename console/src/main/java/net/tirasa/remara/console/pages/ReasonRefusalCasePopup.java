package net.tirasa.remara.console.pages;

import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.persistence.data.MedicineCase;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.markup.html.form.AjaxButton;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.extensions.ajax.markup.html.modal.ModalWindow;
import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.TextArea;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.model.Model;

@AuthorizeInstantiation("ADMIN")
public class ReasonRefusalCasePopup extends WebPage {

    public static final String ACTION_UPDATE = "update";

    public static final String ACTION_REJECT = "reject";

    private static final long serialVersionUID = 5364735512393265L;

    private final TextArea reason;

    MedicineCase medicineCase;

    private final Form form;

    private String action;

    public ReasonRefusalCasePopup(final PageParameters parameters,
            final ModalWindow window, final WfReferentCase wRefCase) {
        super(parameters);

        medicineCase = (MedicineCase) parameters.get("medicineCase");
        action = parameters.getString("action");
        final String strCase = medicineCase.getPatient().getName()
                + " " + medicineCase.getPatient().getSurname()
                + " - "
                + medicineCase.getIllness().getExempt();

        form = new Form("form");
        add(form);

        form.add(new FeedbackPanel("feedback").setOutputMarkupId(true));

        form.add(new Label("medicineCase", new Model(strCase)));
        if (action.equals(ACTION_UPDATE)) {
            add(new Label("title", new Model(getString("title_update"))));
        } else {
            add(new Label("title", new Model(getString("title_reject"))));
        }

        reason = new TextArea("reason", new Model(""));
        reason.setRequired(true);
        form.add(reason);

        form.add(new AjaxButton("save", new Model(getString("save")), form) {

            private static final long serialVersionUID = -5112995114556934353L;

            @Override
            public void onSubmit(final AjaxRequestTarget target, final Form form) {
                String reason = (String) ((TextArea) form.get("reason")).getModelObject();
                try {
                    if (action.equals(ACTION_UPDATE)) {
                        wRefCase.requestUpdate(medicineCase, reason);
                    } else {
                        wRefCase.reject(medicineCase, reason);
                    }
                    window.close(target);
                } catch (final DBException ex) {
                    error(getString(ex.getMessage()));
                }
            }

            @Override
            protected void onError(final AjaxRequestTarget target, final Form form) {
                target.addComponent(form.get("feedback"));
            }
        });
        add(form);
    }
}
