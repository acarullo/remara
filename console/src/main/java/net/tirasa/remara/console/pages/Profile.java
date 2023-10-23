package net.tirasa.remara.console.pages;

import static net.tirasa.remara.console.RemaraAuthWebSession.SESSION_USERNAME;
import net.tirasa.remara.console.RemaraApplication;
import net.tirasa.remara.console.wicket.FormComponentFactory;
import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.core.management.UserManagement;
import net.tirasa.remara.persistence.data.User;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.markup.html.form.Button;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.PasswordTextField;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.model.Model;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class Profile extends BasePage {

    private static final long serialVersionUID = 3592038325994348697L;

    private final Form form;

    @SpringBean
    private UserManagement userManagement;

    public Profile() {
        super();
        FormComponentFactory formComponentFactory = new FormComponentFactory();

        add(new FeedbackPanel("feedback"));
        form = createPasswordResetForm();

        add(form);
        form.add(formComponentFactory.passwordTextField("oldPassword"));
        form.add(formComponentFactory.passwordTextField("newPassword"));
        form.add(formComponentFactory.passwordTextField("confirmPassword"));
        form.add(new Button("submit", new Model(getString("save"))));
    }

    private Form createPasswordResetForm() {
        return new Form("UserForm") {

            private static final long serialVersionUID = 7283381648682393116L;

            @Override
            protected void onSubmit() {
                String formOldPassword = (String) ((PasswordTextField) form.get("oldPassword")).getModelObject();
                String formNewPassword = (String) ((PasswordTextField) form.get("newPassword")).getModelObject();
                String formConfirmPassword = (String) ((PasswordTextField) form.get("confirmPassword")).getModelObject();
                User user = userManagement.getUser((String) RemaraApplication.getSession().
                        getAttribute(SESSION_USERNAME));
                String userOldPassword = user.getPassword();

                if (verifyOldAndNewPassword(userOldPassword, formOldPassword,
                        formNewPassword, formConfirmPassword)) {
                    return;
                }

                updateUserWithNewPassword(user, formNewPassword);
                info(getString("info.save"));
                form.setEnabled(false);
            }

            private void updateUserWithNewPassword(User user, String formNewPassword) {
                user.setPassword(formNewPassword);
                try {
                    userManagement.update(user);
                } catch (DBException ex) {
                    error(getString(ex.getMessage()));
                }
            }

            private boolean verifyOldAndNewPassword(String userOldPassword, String formOldPassword,
                    String formNewPassword, String formConfirmPassword) {
                if (!userOldPassword.equals(formOldPassword)) {
                    error(getString("verify_old_password"));
                    return true;
                }
                if (!formNewPassword.equals(formConfirmPassword)) {
                    error(getString("verify_confirm_password"));
                    return true;
                }
                return false;
            }
        };
    }
}
