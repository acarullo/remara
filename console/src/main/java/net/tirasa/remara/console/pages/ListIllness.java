package net.tirasa.remara.console.pages;

import net.tirasa.remara.console.utilities.Constants;
import net.tirasa.remara.console.layout.IllnessAdvancedFind;
import net.tirasa.remara.console.layout.IllnessFind;
import net.tirasa.remara.core.dataprovider.IllnessDataProvider;
import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.core.management.IllnessManagement;
import net.tirasa.remara.persistence.data.Illness;
import org.apache.wicket.PageParameters;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.markup.html.navigation.paging.PagingNavigator;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.markup.repeater.Item;
import org.apache.wicket.markup.repeater.data.DataView;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class ListIllness extends BasePage {

    private static final long serialVersionUID = 1190863577392217864L;

    @SpringBean
    private IllnessManagement illnessManagement;

    @SpringBean
    private IllnessDataProvider illnessDataProvider;

    private long role;

    public ListIllness(final PageParameters parameters) {
        super();
        role = getRemaraUser().getRole();

        add(new FeedbackPanel("feedback"));

        boolean advancedFind = false;
        String code = "";
        if (parameters != null && parameters.containsKey("findCode")) {
            code = parameters.getString("findCode");
            advancedFind = true;
        }
        String description = "";
        if (parameters != null && parameters.containsKey("findDescription")) {
            description = parameters.getString("findDescription");
        }
        String exempt = "";
        if (parameters != null && parameters.containsKey("findExempt")) {
            exempt = parameters.getString("findExempt");
        }

        if (advancedFind) {
            add(new IllnessAdvancedFind("findPanel", code, description, exempt));
            illnessDataProvider.setOrCriteria(false);
        } else {
            code = "";
            if (parameters != null && parameters.containsKey("findText")) {
                code = parameters.getString("findText");
            }
            description = code;
            exempt = code;
            add(new IllnessFind("findPanel", code));
            illnessDataProvider.setOrCriteria(true);
        }

        illnessDataProvider.setCode(code);
        illnessDataProvider.setDescription(description);
        illnessDataProvider.setExempt(exempt);
        illnessDataProvider.setSort("description", true);

        final DataView dataView = new DataView("illnessList", illnessDataProvider, Constants.MAX_ROWS) {

            private static final long serialVersionUID = 3730925125889062563L;

            @Override
            protected void populateItem(Item item) {
                final Illness illness = (Illness) item.getModelObject();
                item.add(new Label("code", illness.getCode()));
                item.add(new Label("description", illness.getDescription()));
                item.add(new Label("exempt", illness.getExempt()));

                Link openLink = new Link("linkOpen", item.getModel()) {

                    private static final long serialVersionUID = -5665438703028610801L;

                    @Override
                    public void onClick() {
                        PageParameters parameters = new PageParameters();
                        parameters.put("illness", illness);
                        setResponsePage(new NewIllness(parameters));
                    }
                };
                openLink.add(new SimpleAttributeModifier("title", getString("open")));
                if (role != 1) {
                    openLink.setVisible(false);
                }
                item.add(openLink);

                Link linkDelete = new Link("linkDelete", item.getModel()) {

                    private static final long serialVersionUID = -5665438703028610801L;

                    @Override
                    public void onClick() {
                        try {
                            illnessManagement.delete(illness);
                        } catch (DBException e) {
                            error(getString(e.getMessage()));
                            return;
                        }
                        getSession().info(getString("info.delete"));
                        setResponsePage(new ListIllness(null));
                    }
                };
                linkDelete.add(new SimpleAttributeModifier("title", getString("delete")));
                linkDelete.add(new SimpleAttributeModifier("onclick", "return confirm('" + getString("confirm_delete")
                        + "');"));
                if (role != 1) {
                    linkDelete.setVisible(false);
                }
                item.add(linkDelete);
            }
        };
        add(dataView);
        add(new PagingNavigator("headerPaginator", dataView));
    }
}
