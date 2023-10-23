package net.tirasa.remara.console.pages;

import net.tirasa.remara.console.RemaraAuthWebSession;
import org.apache.wicket.PageParameters;
import org.apache.wicket.Session;
import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.markup.html.form.Button;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.PasswordTextField;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.model.Model;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoginPage extends WebPage {

    private static final long serialVersionUID = -6562944159555287603L;

    private static final Logger LOG = LoggerFactory.getLogger(LoginPage.class);

    protected FeedbackPanel feedbackPanel;

    private final Form<Void> form;

    private TextField<String> userIdField;

    private TextField<String> passwordField;

    public LoginPage(final PageParameters parameters) {
        super(parameters);

        LOG.debug("Entrato nella Login");

        form = new Form<Void>("login");

        userIdField = new TextField<String>("userId", new Model<String>());
        userIdField.setMarkupId("userId");
        form.add(userIdField);

        passwordField = new PasswordTextField("password", new Model<String>());
        passwordField.setMarkupId("password");
        form.add(passwordField);

        final Button submitButton = new Button("submit", new Model<String>(getString("submit"))) {

            private static final long serialVersionUID = 429178684321093953L;

            @Override
            public void onSubmit() {
                if (signIn(userIdField.getRawInput(), passwordField.getRawInput())) {
                    LOG.debug("Login success for user: {}", userIdField.getRawInput());
                    continueToOriginalDestination();
                    setResponsePage(getApplication().getHomePage());
                } else {
                    error(getString("login-error") + " Username/Password errati");
                }
            }
        };

        submitButton.setDefaultFormProcessing(false);
        form.add(submitButton);

        add(form);
        add(new FeedbackPanel("feedback"));
    }

    private boolean signIn(final String username, final String password) {
        RemaraAuthWebSession.get().setLocale(Session.get().getLocale());
        return RemaraAuthWebSession.get().signIn(username, password);
    }
}
