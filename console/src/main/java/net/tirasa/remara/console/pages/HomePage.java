package net.tirasa.remara.console.pages;

import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@AuthorizeInstantiation("ADMIN")
public class HomePage extends BasePage {

    private static final long serialVersionUID = -3029206219622528829L;

    private static final Logger LOG = LoggerFactory.getLogger(HomePage.class);

    public HomePage() {
        super();
        LOG.debug("Entrato dentro HomePage");
    }
}
