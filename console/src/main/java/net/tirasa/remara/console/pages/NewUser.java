package net.tirasa.remara.console.pages;

import net.tirasa.remara.console.utilities.StringUtils;
import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.core.management.Encoder;
import net.tirasa.remara.core.management.RoleManagement;
import net.tirasa.remara.core.management.UserManagement;
import java.util.ArrayList;
import java.util.List;
import net.tirasa.remara.persistence.data.Role;
import net.tirasa.remara.persistence.data.User;
import org.apache.wicket.PageParameters;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.Button;
import org.apache.wicket.markup.html.form.CheckBox;
import org.apache.wicket.markup.html.form.ChoiceRenderer;
import org.apache.wicket.markup.html.form.DropDownChoice;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.model.CompoundPropertyModel;
import org.apache.wicket.model.Model;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class NewUser extends BasePage {

    private static final long serialVersionUID = -5397066526071141313L;

    @SpringBean
    private RoleManagement roleManagement;

    @SpringBean
    private UserManagement userManagement;

    private User user = null;

    private boolean newUser;

    private final Form form;

    private boolean verifyForm() {

        toUtf(user);

        boolean verify = true;
        String name = user.getName();
        if (name == null || name.isEmpty()) {
            error(getString("name.Required"));
            verify = false;
        }
        String surname = user.getSurname();
        if (surname == null || surname.isEmpty()) {
            error(getString("surname.Required"));
            verify = false;
        }
        String username = user.getUsername();
        if (username == null || username.isEmpty()) {
            error(getString("username.Required"));
            verify = false;
        }
        Role role = user.getRole();
        if (role == null || role.getDescription().isEmpty()) {
            error(getString("role.Required"));
            verify = false;
        }
        String mail = user.getEmail();
        if (mail == null || mail.isEmpty()) {
            error(getString("email.Required"));
            verify = false;
        }
        if (user.getPediatrician() && user.getRole().getId() != 2) {
            error(getString("error.role_pediatrician"));
            verify = false;
        }

        if ((!StringUtils.containsLowerCase(name)) || (!StringUtils.containsLowerCase(surname))
                || (!StringUtils.containsLowerCase(user.getEmail())) || (!StringUtils.containsLowerCase(user.
                getSurname()))
                || (!StringUtils.containsLowerCase(user.getHospitalOrganization()))
                || (!StringUtils.containsLowerCase(user.getHospitalWard()))
                || (!StringUtils.containsLowerCase(user.getAddress()))) {
            error(getString(WRONG_CHAR));
            verify = false;
        }
        return verify;
    }

    public NewUser(final PageParameters parameters) {
        super();

        newUser = false;
        if (parameters.containsKey("user")) {
            user = (User) parameters.get("user");
            add(new Label("new_user", getString("new_user.update")));
        } else {
            user = new User();
            newUser = true;
            add(new Label("new_user", getString("new_user.new")));
        }
        add(new FeedbackPanel("feedback"));
        form = new Form("UserForm", new CompoundPropertyModel(user)) {

            private static final long serialVersionUID = -3061771342119019368L;

            @Override
            protected void onSubmit() {
                if (!verifyForm()) {
                    return;
                }
                try {
                    if (newUser) {
                        userManagement.insert(user);
                    } else {
                        userManagement.update(user);
                    }
                } catch (DBException e) {
                    error(getString(e.getMessage()));
                    return;
                }
                getSession().info(getString("info.save"));
                if (newUser) {
                    PageParameters parameters = new PageParameters();
                    parameters.put("user", user);
                    setResponsePage(new ResetPassword(parameters));
                } else {
                    setResponsePage(new ListUsers());
                }
            }
        };
        add(form);

        addFields();
    }

    private void addFields() {
        TextField name = new TextField("name");
        name.add(new SimpleAttributeModifier("title", getString("name")));
//        name.setRequired(true);
        form.add(name);

        List<Role> roles = new ArrayList<Role>();

        ChoiceRenderer roleRenderer = new ChoiceRenderer("description", "id");
        roles.addAll(roleManagement.getRolesList());

        DropDownChoice role = new DropDownChoice("role", roles, roleRenderer);
        role.add(new SimpleAttributeModifier("title", getString("role")));
//        role.setRequired(true);
        form.add(role);

        TextField surname = new TextField("surname");
//        surname.setRequired(true);
        surname.add(new SimpleAttributeModifier("title", getString("surname")));
        form.add(surname);

        TextField email = new TextField("email");
//        email.setRequired(true);
        email.add(new SimpleAttributeModifier("title", getString("email")));
        form.add(email);

        TextField username = new TextField("username");
//        username.setRequired(true);
        username.add(new SimpleAttributeModifier("title", getString("username")));
        username.setEnabled(newUser);
        form.add(username);

        CheckBox pediatrician = new CheckBox("pediatrician");
        pediatrician.add(new SimpleAttributeModifier("title", getString("pediatrician")));
        form.add(pediatrician);

        TextField hospitalOrganization = new TextField("hospitalOrganization");
        hospitalOrganization.add(new SimpleAttributeModifier("title", getString("hospitalOrganization")));
        form.add(hospitalOrganization);

        TextField hospitalWard = new TextField("hospitalWard");
        hospitalWard.add(new SimpleAttributeModifier("title", getString("hospitalWard")));
        form.add(hospitalWard);

        TextField phone = new TextField("phone");
        phone.add(new SimpleAttributeModifier("title", getString("phone")));
        form.add(phone);

        TextField fax = new TextField("fax");
        fax.add(new SimpleAttributeModifier("title", getString("fax")));
        form.add(fax);

        TextField address = new TextField("address");
        address.add(new SimpleAttributeModifier("title", getString("address")));
        form.add(address);

        form.add(new Button("submit", new Model(getString("save"))));
    }

    private void toUtf(User user) {
        if (user.getAddress() != null) {
            user.setAddress(Encoder.toUtf(user.getAddress()));
        }

        if (user.getName() != null) {
            user.setName(Encoder.toUtf(user.getName()));
        }

        if (user.getSurname() != null) {
            user.setSurname(Encoder.toUtf(user.getSurname()));
        }
    }
}
