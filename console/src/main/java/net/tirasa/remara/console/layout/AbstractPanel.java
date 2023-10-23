package net.tirasa.remara.console.layout;

import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.panel.Panel;

public class AbstractPanel extends Panel {

    private static final long serialVersionUID = 8160817860583154322L;

    public AbstractPanel(final String id) {
        super(id);
    }

    protected Label searchLabel() {
        return new Label("insertSurname", "Inserisci il cognome o il codice fiscale");
    }
}
