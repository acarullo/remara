package net.tirasa.remara.console.pages;

import net.tirasa.remara.console.utilities.Constants;
import net.tirasa.remara.core.dataprovider.IllnessDataProvider;
import net.tirasa.remara.persistence.data.Illness;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.markup.html.AjaxLink;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.extensions.ajax.markup.html.modal.ModalWindow;
import org.apache.wicket.extensions.markup.html.repeater.data.sort.OrderByBorder;
import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.Button;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.navigation.paging.PagingNavigator;
import org.apache.wicket.markup.repeater.Item;
import org.apache.wicket.markup.repeater.data.DataView;
import org.apache.wicket.model.Model;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public final class IllnessPopup extends WebPage {

    private static final long serialVersionUID = -2851771947227257207L;
    
    @SpringBean
    private IllnessDataProvider illnessDataProvider;

    private TextField findCode;

    private TextField findDescription;

    private TextField findExempt;

    /**
     *
     * @param parameters
     * @param modalWindowPage
     * @param window
     */
    public IllnessPopup(PageParameters parameters, final FindPopupIllness modalWindowPage, final ModalWindow window) {
        super(parameters);

        final Form findForm = new Form("search") {

            private static final long serialVersionUID = 7283381648682393116L;

            @Override
            protected void onSubmit() {
                PageParameters parameters = new PageParameters();
                parameters.put("findCode", findCode.getModelObject());
                parameters.put("findDescription", findDescription.getModelObject());
                parameters.put("findExempt", findExempt.getModelObject());
                setResponsePage(new IllnessPopup(parameters, modalWindowPage, window));
            }
        };
        add(findForm);

        String code = "";
        if (parameters != null && parameters.containsKey("findCode")) {
            code = parameters.getString("findCode");
        }
        String description = "";
        if (parameters != null && parameters.containsKey("findDescription")) {
            description = parameters.getString("findDescription");
        }
        String exempt = "";
        if (parameters != null && parameters.containsKey("findExempt")) {
            exempt = parameters.getString("findExempt");
        }

        findCode = new TextField("findCode", new Model(code));
        findForm.add(findCode);

        findDescription = new TextField("findDescription", new Model(description));
        findForm.add(findDescription);

        findExempt = new TextField("findExempt", new Model(exempt));
        findForm.add(findExempt);

        findForm.add(new Button("find", new Model(getString("find"))));

        illnessDataProvider.setOrCriteria(false);

        illnessDataProvider.setCode(code);
        illnessDataProvider.setDescription(description);
        illnessDataProvider.setExempt(exempt);

        illnessDataProvider.setSort("description", true);

        DataView dataView = new DataView("illnessList", illnessDataProvider, Constants.MAX_ROWS) {

            private static final long serialVersionUID = 3730925125889062563L;

            @Override
            protected void populateItem(Item item) {
                final Illness illness = (Illness) item.getModelObject();
                item.add(new Label("code", illness.getCode()));
                item.add(new Label("description", illness.getDescription()));
                item.add(new Label("exempt", illness.getExempt()));

                AjaxLink linkSelect = new AjaxLink("linkSelect", item.getModel()) {
                    private static final long serialVersionUID = 3776750333491622263L;

                    public void onClick(AjaxRequestTarget target) {
                        if (modalWindowPage != null) {
                            modalWindowPage.setResult(illness);
                        }
                        window.close(target);
                    }
                };
                item.add(linkSelect);
            }
        };
        add(dataView);
        add(new PagingNavigator("headerPaginator", dataView));
        add(new OrderByBorder("orderByCode", "illness.code", illnessDataProvider));
        add(new OrderByBorder("orderByDescription", "illness.description", illnessDataProvider));
        add(new OrderByBorder("orderByExempt", "illness.exempt", illnessDataProvider));
    }
}
