package net.tirasa.remara.console;

import net.tirasa.remara.console.pages.HomePage;
import javax.servlet.http.HttpSession;
import net.tirasa.remara.console.pages.LoginPage;
import net.tirasa.remara.console.utilities.Constants;
import org.apache.wicket.Request;
import org.apache.wicket.RequestCycle;
import org.apache.wicket.Response;
import org.apache.wicket.authentication.AuthenticatedWebApplication;
import org.apache.wicket.authentication.AuthenticatedWebSession;
import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.protocol.http.WebApplication;
import org.apache.wicket.protocol.http.WebRequest;
import org.apache.wicket.protocol.http.WebRequestCycle;
import org.apache.wicket.protocol.http.WebResponse;
import org.apache.wicket.spring.injection.annot.SpringComponentInjector;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RemaraApplication extends AuthenticatedWebApplication {

    private static final Logger LOG = LoggerFactory.getLogger(RemaraApplication.class);

    @Override
    protected void init() {
        super.init();
        LOG.debug("Init di Wicket");
        addComponentInstantiationListener(new SpringComponentInjector(this));
        getRequestCycleSettings().setResponseRequestEncoding(Constants.UTF_8);
        getMarkupSettings().setStripWicketTags(true);
        getMarkupSettings().setCompressWhitespace(true);
        getMarkupSettings().setDefaultMarkupEncoding(Constants.UTF_8);
        getResourceSettings().setThrowExceptionOnMissingResource(false);
    }

    public Class getHomePage() {
        return HomePage.class;
    }

    @Override
    public RequestCycle newRequestCycle(final Request request, final Response response) {
        return new myRequestCycle(this, (WebRequest) request, (WebResponse) response);
    }

    @Override
    public String getConfigurationType() {
        return DEPLOYMENT;
    }

    @Override
    protected Class<? extends AuthenticatedWebSession> getWebSessionClass() {
        return RemaraAuthWebSession.class;
    }

    @Override
    protected Class<? extends WebPage> getSignInPageClass() {
        return LoginPage.class;
    }

    public static WebRequest getReq() {
        return (WebRequest) RequestCycle.get().getRequest();
    }

    public static HttpSession getSession() {
        return ((WebRequest) RequestCycle.get().getRequest()).getHttpServletRequest().getSession();
    }

    public class myRequestCycle extends WebRequestCycle {

        public myRequestCycle(final WebApplication application, final WebRequest request, final Response response) {
            super(application, request, response);
        }

        @Override
        protected void logRuntimeException(final RuntimeException rex) {
            super.logRuntimeException(rex);
            setResponsePage(LoginPage.class);
        }
    }
}
