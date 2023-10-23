package net.tirasa.remara.console.pages;

import net.tirasa.remara.console.RemaraApplication;
import net.tirasa.remara.console.RemaraAuthWebSession;
import net.tirasa.remara.console.RemaraConsoleUser;
import net.tirasa.remara.console.layout.AdminMenu;
import net.tirasa.remara.console.layout.CompilerMenu;
import net.tirasa.remara.console.layout.ReferentMenu;
import org.apache.wicket.Session;
import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.protocol.http.WebResponse;

public class BasePage extends WebPage {

    protected static final String WRONG_CHAR = "wrongchar";

    protected static final String CONFIRM = "confirm";

    protected static final String REGION = "region";

    protected static final String REGIONI = "regioni";

    protected static final String PATIENT = "patient";

    protected static final String ON = "on";

    private static final long serialVersionUID = -2662837016253132023L;

    private final RemaraConsoleUser remaraConsoleUser;

    /**
     * Constructor that is invoked when page is invoked without a session.
     *
     */
    public BasePage() {

        remaraConsoleUser = (RemaraConsoleUser) RemaraApplication.getSession().getAttribute(
                RemaraAuthWebSession.SESSION_USER);

        if (remaraConsoleUser.getRole() == 1) {
            add(new AdminMenu("leftMenu"));
        } else if (remaraConsoleUser.getRole() == 2) {
            add(new ReferentMenu("leftMenu"));
        } else {
            add(new CompilerMenu("leftMenu"));
        }
        add(new Label("user", remaraConsoleUser.getName()));
        add(new Link<Void>("logout") {

            private static final long serialVersionUID = -4331619903296515985L;

            @Override
            public void onClick() {
                Session.get().invalidate();
                getSession().invalidateNow();
                getSession().invalidate();
                setResponsePage(getApplication().getHomePage());
            }
        });

    }

    public final RemaraConsoleUser getRemaraUser() {
        return remaraConsoleUser;
    }

    protected static void responeSetHeader(final WebResponse response) {
        response.setHeader("Pragma", "public");
        response.setHeader("Cache-Control", "no-store, must-revalidate");
        response.setHeader("Expires", "-1");
    }
}
