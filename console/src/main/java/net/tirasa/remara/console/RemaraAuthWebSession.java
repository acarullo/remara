package net.tirasa.remara.console;

import net.tirasa.remara.core.management.UserManagement;
import net.tirasa.remara.persistence.data.User;
import org.apache.wicket.Request;
import org.apache.wicket.authentication.AuthenticatedWebSession;
import org.apache.wicket.authorization.strategies.role.Roles;
import org.apache.wicket.injection.web.InjectorHolder;
import org.apache.wicket.spring.injection.annot.SpringBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RemaraAuthWebSession extends AuthenticatedWebSession {

    private static final long serialVersionUID = 7271599198638800354L;

    private static final Logger LOG = LoggerFactory.getLogger(RemaraAuthWebSession.class);

    public static final String SESSION_USERNAME = "uid";

    public static final String SESSION_USER = "user";

    @SpringBean
    private UserManagement userManagement;

    public RemaraAuthWebSession(final Request request) {
        super(request);
        injectDependencies();
        ensureDependenciesNotNull();
    }

    private void ensureDependenciesNotNull() {
        if (userManagement == null) {
            throw new IllegalStateException("userManagement is required for authentication.");
        }
    }

    private void injectDependencies() {
        InjectorHolder.getInjector().inject(this);
    }

    @Override
    public boolean authenticate(final String username, final String password) {
        LOG.debug("Autenticazione per {}", username);
        boolean auth = false;
        final User userPojo = userManagement.getUser(username);
        if (userPojo != null && userPojo.getPassword().equals(password)) {
            LOG.debug("Utente {} autenticato con successo", username);
            auth = true;
            RemaraConsoleUser user = new RemaraConsoleUser(userPojo.getUsername(), userPojo.getName(), userPojo.
                    getSurname(),
                    userPojo.getRole().getId(), userPojo.getEmail());
            RemaraApplication.getSession().setAttribute(SESSION_USERNAME, username);
            RemaraApplication.getSession().setAttribute(SESSION_USER, user);
        } else {
            LOG.debug("Id utente/password errati", username);
        }
        return auth;
    }

    @Override
    public Roles getRoles() {
        Roles role = null;
        if (isSignedIn()) {
            role = new Roles(Roles.ADMIN);
        }
        return role;
    }
}
