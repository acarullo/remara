package net.tirasa.remara.console.pages;

import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.core.management.UserManagement;
import java.util.List;
import net.tirasa.remara.persistence.data.User;
import org.apache.wicket.PageParameters;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.markup.html.list.ListItem;
import org.apache.wicket.markup.html.list.ListView;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class ListUsers extends BasePage {

    private static final long serialVersionUID = 2164661713629936438L;
    
    @SpringBean
    private UserManagement userManagement;

    public ListUsers() {
        super();

        add(new FeedbackPanel("feedback"));

        List<User> usersList = userManagement.getAllUsers();

        ListView datas = new ListView("usersList", usersList) {

            private static final long serialVersionUID = 4949588177564901031L;

            @Override
            protected void populateItem(ListItem item) {
                final User user = (User) item.getModelObject();
                item.add(new Label("name", user.getName() + " " + user.getSurname()));
                item.add(new Label("role", user.getRole().getDescription()));
                item.add(new Label("email", user.getEmail()));
                item.add(new Label("username", user.getUsername()));
                item.add(new Label("phone", user.getPhone()));
                item.add(new Label("fax", user.getFax()));

                Link linkOpen = new Link("linkOpen", item.getModel()) {

                    private static final long serialVersionUID = -5665438703028610801L;

                    @Override
                    public void onClick() {
                        PageParameters parameters = new PageParameters();
                        parameters.put("user", user);
                        setResponsePage(new NewUser(parameters));
                    }
                };
                linkOpen.add(new SimpleAttributeModifier("title", getString("open")));
                item.add(linkOpen);

                Link linkReset = new Link("linkReset", item.getModel()) {

                    private static final long serialVersionUID = -5665438703028610801L;

                    @Override
                    public void onClick() {
                        PageParameters parameters = new PageParameters();
                        parameters.put("user", user);
                        setResponsePage(new ResetPassword(parameters));
                    }
                };
                linkReset.add(new SimpleAttributeModifier("title", getString("reset")));
                linkReset.add(new SimpleAttributeModifier(
                        "onclick",
                        "return confirm('" + getString("confirm_reset") + "');"));
                item.add(linkReset);

                Link linkDelete = new Link("linkDelete", item.getModel()) {

                    private static final long serialVersionUID = -5665438703028610801L;

                    @Override
                    public void onClick() {
                            userManagement.delete(user);
                       
                        getSession().info(getString("info.delete"));
                        setResponsePage(new ListUsers());
                    }
                };
                linkDelete.add(new SimpleAttributeModifier("title", getString("delete")));
                linkDelete.add(new SimpleAttributeModifier("onclick",
                        "return confirm('" + getString("confirm_delete") + "');"));
                item.add(linkDelete);
            }
        };
        add(datas);

    }
}
