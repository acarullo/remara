package net.tirasa.remara.console.pages;

import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.core.management.UserManagement;
import net.tirasa.remara.persistence.data.User;
import org.apache.wicket.PageParameters;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.model.Model;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class ResetPassword extends BasePage {

    private static final long serialVersionUID = -2497507021324243920L;

    @SpringBean
    private UserManagement userManagement;

    public ResetPassword(PageParameters parameters) {
        super();

        User user = (User) parameters.get("user");
        String password = userManagement.resetPassword(user);

        add(new FeedbackPanel("feedback"));
        add(new Label("username", new Model(user.getUsername())));
        add(new Label("password", new Model(password)));
    }
}
