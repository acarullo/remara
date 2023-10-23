package net.tirasa.remara.console.pages;

import net.tirasa.remara.console.utilities.Constants;
import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.core.management.HospitalManagement;
import net.tirasa.remara.core.management.RegionsManagement;
import java.util.ArrayList;
import java.util.List;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import net.tirasa.remara.persistence.data.Region;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.form.AjaxFormComponentUpdatingBehavior;
import org.apache.wicket.ajax.markup.html.AjaxLink;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.markup.html.WebMarkupContainer;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.ChoiceRenderer;
import org.apache.wicket.markup.html.form.DropDownChoice;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.markup.html.list.ListItem;
import org.apache.wicket.markup.html.list.PageableListView;
import org.apache.wicket.markup.html.navigation.paging.PagingNavigator;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.model.Model;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class ListHospitals extends BasePage {

    private static final long serialVersionUID = 2956771136769855683L;

    @SpringBean
    private HospitalManagement hospitalManagement;

    @SpringBean
    private RegionsManagement regionsManagement;

    private List<HospitalOrganization> hospitalsList;

    public ListHospitals() {
        super();

        this.setOutputMarkupId(true);

        add(new FeedbackPanel("feedback"));
        final WebMarkupContainer datasContainer = new WebMarkupContainer("datasContainer");
        datasContainer.setOutputMarkupId(true);

        hospitalsList = hospitalManagement.getAllHospitals();

        final PageableListView datas = new PageableListView("hospitalsList", hospitalsList, Constants.MAX_ROWS) {

            private static final long serialVersionUID = -9186076471982907981L;

            @Override
            protected void populateItem(final ListItem item) {
                final HospitalOrganization hospitalOrganization = (HospitalOrganization) item.getModelObject();

                item.add(new Label("code", hospitalOrganization.getCode()));
                item.add(new Label("name", hospitalOrganization.getName()));
                item.add(new Label(REGION, hospitalOrganization.getRegion().getDescription()));

                Link linkOpen = new Link("linkOpen", item.getModel()) {

                    private static final long serialVersionUID = -5665438703028610801L;

                    @Override
                    public void onClick() {
                        PageParameters parameters = new PageParameters();
                        parameters.put(
                                "hospitalOrganization", hospitalOrganization);
                        setResponsePage(new NewHospital(parameters));
                    }
                };
                linkOpen.add(new SimpleAttributeModifier(
                        "title", getString("open")));
                item.add(linkOpen);

                Link linkDelete = new Link("linkDelete", item.getModel()) {

                    private static final long serialVersionUID = -5665438703028610801L;

                    @Override
                    public void onClick() {
                        try {
                            hospitalManagement.delete(hospitalOrganization);
                        } catch (DBException e) {
                            error(getString(e.getMessage()));
                            return;
                        }
                        getSession().info(getString("info.delete"));
                        setResponsePage(new ListHospitals());
                    }
                };
                linkDelete.add(new SimpleAttributeModifier(
                        "title", getString("delete")));
                linkDelete.add(new SimpleAttributeModifier(
                        "onclick",
                        "return confirm('" + getString(
                        "confirm_delete") + "');"));
                item.add(linkDelete);

            }
        };
        datas.setReuseItems(true);
        datas.setOutputMarkupId(true);
        datasContainer.add(new PagingNavigator("headerPaginator", datas));
        datasContainer.add(datas);
        add(datasContainer);

        add(new AjaxLink("allRegions") {

            private static final long serialVersionUID = -4331619903296515985L;

            @Override
            public void onClick(AjaxRequestTarget art) {
                hospitalsList = hospitalManagement.getAllHospitals();

                datas.removeAll();
                datas.setList(hospitalsList);
                datasContainer.addOrReplace(datas);
                art.addComponent(getPage());
            }
        });

        add(addDropDownChoiceRegion(datasContainer, datas));
    }

    private DropDownChoice addDropDownChoiceRegion(final WebMarkupContainer c, final PageableListView p) {
        final List<Region> regions = new ArrayList<Region>();
        final ChoiceRenderer regionsRenderer = new ChoiceRenderer("description", "id");
        regions.addAll(regionsManagement.getRegionsList());
        final DropDownChoice regioni = new DropDownChoice(
                REGIONI, new Model(), regions, regionsRenderer);
        regioni.add(new SimpleAttributeModifier("title", getString(REGIONI)));
        regioni.setRequired(true);
        regioni.add(new AjaxFormComponentUpdatingBehavior(Constants.ON_CHANGE) {

            private static final long serialVersionUID = -1107858522700306810L;

            @Override
            protected void onUpdate(final AjaxRequestTarget target) {
                hospitalsList = hospitalManagement.findByRegionId(Integer.valueOf(regioni.getModelValue()));
                p.removeAll();
                p.setList(hospitalsList);
                c.addOrReplace(p);
                target.addComponent(getPage());
            }
        });
        return regioni;
    }
}
