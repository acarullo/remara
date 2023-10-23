package net.tirasa.remara.console.pages;

import net.tirasa.remara.console.utilities.Constants;
import net.tirasa.remara.core.management.HospitalManagement;
import java.util.List;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import net.tirasa.remara.persistence.data.Region;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.markup.html.AjaxLink;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.extensions.ajax.markup.html.modal.ModalWindow;
import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.Button;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.list.ListItem;
import org.apache.wicket.markup.html.list.PageableListView;
import org.apache.wicket.markup.html.navigation.paging.PagingNavigator;
import org.apache.wicket.model.Model;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class HoPopup extends WebPage {

    private static final long serialVersionUID = -9143215191736195717L;

    @SpringBean
    private HospitalManagement hospitalManagement;

    private static final String REGION = "region";

    private TextField region;

    private Region sRegion;

    HoPopup(final PageParameters parameters, final ModalWindow hoPopup, final WebPage aThis) {
        super(parameters);
        final NewCase newCasePage = (NewCase) aThis;
        final Form findForm = new Form("search") {

            private static final long serialVersionUID = 7283381648682393116L;

            @Override
            protected void onSubmit() {
                PageParameters parameters = new PageParameters();
                parameters.put(REGION, sRegion);
                parameters.put("name", region.getModelObject());
                setResponsePage(new HoPopup(parameters, hoPopup, aThis));
            }
        };
        add(findForm);

        sRegion = null;
        if (parameters != null && parameters.containsKey(REGION)) {
            sRegion = (Region) parameters.get(REGION);
        }
        region = new TextField(REGION, new Model());
        findForm.add(region);

        findForm.add(new Button("find", new Model(getString("find"))));

        HospitalOrganization patient = new HospitalOrganization();
        patient.setRegion(sRegion);

        List<HospitalOrganization> hoList;
        if (parameters != null && parameters.containsKey("name")) {
            hoList = hospitalManagement.findByNameAndRegion(parameters.getString("name"), sRegion);
        } else if (parameters != null && parameters.containsKey(REGION)) {
            hoList = hospitalManagement.findByRegion(sRegion);
        } else {
            hoList = hospitalManagement.getAllHospitals();
        }

        final PageableListView dataView = new PageableListView("hoList",
                hoList, Constants.MAX_ROWS) {

            private static final long serialVersionUID = -9186076471982907981L;

            @Override
            protected void populateItem(ListItem item) {
                final HospitalOrganization ho = (HospitalOrganization) item.getModelObject();
                String description = ho.getName();
                item.add(new Label("name", description));

                AjaxLink linkSelect = new AjaxLink("linkSelect", item.getModel()) {

                    private static final long serialVersionUID = 3776750333491622263L;

                    public void onClick(AjaxRequestTarget target) {
                        if (hoPopup != null) {
                            newCasePage.setHo(ho);
                        }
                        hoPopup.close(target);
                    }
                };
                item.add(linkSelect);
            }
        };
        add(dataView);
        add(new PagingNavigator("headerPaginator", dataView));
    }
}
