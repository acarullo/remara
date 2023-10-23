package net.tirasa.remara.console;

import org.apache.wicket.Request;
import org.apache.wicket.Session;
import org.apache.wicket.protocol.http.WebSession;

public class RemaraSession extends WebSession {

    private static final long serialVersionUID = -6842577874773192645L;

    public static RemaraSession get() {
        return (RemaraSession) Session.get();
    }

    private RemaraConsoleUser user;

    public RemaraSession(final Request request) {
        super(request);

        setLocale(request.getLocale());
    }

    public synchronized RemaraConsoleUser getUser() {
        return user;
    }

    public synchronized boolean isAuthenticated() {
        return (user != null);
    }

    public synchronized void setUser(final RemaraConsoleUser user) {
        this.user = user;
        dirty();
    }
}
