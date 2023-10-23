package net.tirasa.remara.console.pages;

import net.tirasa.remara.console.RemaraSession;
import net.tirasa.remara.console.RemaraConsoleUser;
import net.tirasa.remara.core.management.UserManagement;
import java.util.Map;
import net.tirasa.remara.persistence.data.User;
import org.apache.wicket.RequestCycle;
import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.protocol.http.WebRequestCycle;
import org.apache.wicket.request.target.basic.EmptyRequestTarget;
import org.apache.wicket.spring.injection.annot.SpringBean;

public class Login extends WebPage {

    private static final long serialVersionUID = -6846240514254505484L;

    private static final String USERNAME = "username";

    private final static String LOGIN = "/remara/login";
    
    @SpringBean
    private UserManagement userManagement;

    public Login() {
        if (((RemaraSession) getSession()).isAuthenticated()) {
            setRedirect(true);
            setResponsePage(HomePage.class);
        } else {
            securityCheck();
        }
    }

    /**
     * Common servlet login workaround
     */
    private void securityCheck() {
        final Map parametersMap = ((WebRequestCycle) RequestCycle.get()).getWebRequest().getHttpServletRequest().
                getParameterMap();
        if (parametersMap.containsKey(USERNAME)) {
            // getting parameters from POST request
            final String userName = ((String[]) parametersMap.get(USERNAME))[0];

            // if POST parameters are ok, redirect them to j_security_check
            if ((userName != null)) {
                getRequestCycle().setRedirect(false);
                getRequestCycle().setRequestTarget(
                        EmptyRequestTarget.getInstance());

                // NOTE: Posting username and password to j_security_check like this will
                // display username and password in access logs. Be careful!
                /*
                 * getResponse().redirect( "/remara/j_security_check?j_username=" + userName + "&j_password=" +
                 * userPassword );
                 */
                User user = userManagement.getUser(userName);

                if (user == null) {
                    getResponse().redirect(LOGIN);
                } else {
                    RemaraSession session = (RemaraSession) getSession();

                    session.setUser(new RemaraConsoleUser(user.getUsername(), null, null, user.getRole().getId(), null));

                    //TODO controllare se viene settato
                    ((WebRequestCycle) RequestCycle.get()).getWebRequest().
                            getHttpServletRequest().setAttribute("user", userName);

                    setResponsePage(new HomePage());
                }
            }
        }
    }
}
