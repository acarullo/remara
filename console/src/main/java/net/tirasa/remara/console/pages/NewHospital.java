package net.tirasa.remara.console.pages;

import net.tirasa.remara.console.utilities.Constants;
import net.tirasa.remara.console.utilities.StringUtils;
import net.tirasa.remara.core.exception.DBException;
import net.tirasa.remara.core.management.Encoder;
import net.tirasa.remara.core.management.HospitalManagement;
import net.tirasa.remara.core.management.RegionsManagement;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import net.tirasa.remara.persistence.data.HospitalOrganization;
import net.tirasa.remara.persistence.data.HospitalWard;
import net.tirasa.remara.persistence.data.Region;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.form.AjaxFormComponentUpdatingBehavior;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.Button;
import org.apache.wicket.markup.html.form.ChoiceRenderer;
import org.apache.wicket.markup.html.form.DropDownChoice;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.markup.html.list.ListItem;
import org.apache.wicket.markup.html.list.ListView;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.model.CompoundPropertyModel;
import org.apache.wicket.model.IModel;
import org.apache.wicket.model.Model;
import org.apache.wicket.model.PropertyModel;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class NewHospital extends BasePage {

    private static final long serialVersionUID = -4745624518579671883L;

    @SpringBean
    private HospitalManagement hospitalManagement;

    @SpringBean
    private RegionsManagement regionsManagement;

    private boolean newHospital;

    private HospitalOrganization hospitalOrganization = null;

    private final Form form;

    private List<HospitalWard> hospitalWards = null;

    private boolean verifyForm() {

        toUtf(hospitalOrganization);

        boolean verify = true;
        String code = hospitalOrganization.getCode();
        String description = hospitalOrganization.getName();

        if ((!StringUtils.containsLowerCase(code)) || (!StringUtils.containsLowerCase(description))) {
            error(getString(WRONG_CHAR));
            verify = false;
        }

        return verify;

    }

    public NewHospital(PageParameters parameters) {

        super();

        newHospital = false;
        if (parameters.containsKey("hospitalOrganization")) {
            hospitalOrganization = (HospitalOrganization) parameters.get("hospitalOrganization");
            add(new Label("new_hospital", getString("new_hospital.update")));

            initializeWardsList(hospitalManagement.getHospitalWard(hospitalOrganization));
        } else {
            hospitalOrganization = new HospitalOrganization();
            newHospital = true;
            add(new Label("new_hospital", getString("new_hospital.new")));
        }
        add(new FeedbackPanel("feedback"));
        form = new Form("HospitalForm", new CompoundPropertyModel(hospitalOrganization)) {

            private static final long serialVersionUID = -3061771342119019368L;

            @Override
            protected void onSubmit() {
//                if (!verifyForm()) {
//                    return;
//                }

                try {
                    if (newHospital) {
                        processWardsList();
                        hospitalManagement.insert(hospitalOrganization);
                    } else {
                        processWardsList();
                        hospitalManagement.update(hospitalOrganization);
                    }
                } catch (DBException e) {
                    error(getString(e.getMessage()));
                    return;
                }
                getSession().info(getString("info.save"));
                setResponsePage(new ListHospitals());
            }
        };

        add(form);

        TextField code = new TextField("code");
        code.setRequired(true);
        code.add(new SimpleAttributeModifier("title", getString("code")));
        code.setEnabled(newHospital);

        TextField name = new TextField("name");
        name.add(new SimpleAttributeModifier("title", getString("name")));
        name.setRequired(true);

        List<Region> regions = new ArrayList<Region>();

        ChoiceRenderer regionsRenderer = new ChoiceRenderer("description", "id");
        regions.addAll(regionsManagement.getRegionsList());

        DropDownChoice region = new DropDownChoice("region", regions, regionsRenderer);
        region.add(new SimpleAttributeModifier("title", getString("region")));
        region.setRequired(true);

        if (hospitalWards == null) {
            hospitalWards = new ArrayList<HospitalWard>();
            hospitalWards.add(new HospitalWard());
        }

        form.add(new ListView("hospitalWards", hospitalWards) {

            private static final long serialVersionUID = 4949588177564901031L;

            @Override
            protected void populateItem(ListItem item) {
                HospitalWard hospitalWard = (HospitalWard) item.getModelObject();
                TextField wardName = new UpdatingTextField("wardName", new PropertyModel(hospitalWard,
                        "name"));
                wardName.add(new SimpleAttributeModifier("title", getString("name")));
                wardName.setRequired(true);
                item.add(wardName);

                Link linkDelete = new Link("removeButton", item.getModel()) {

                    private static final long serialVersionUID = -5665438703028610801L;

                    @Override
                    public void onClick() {
                        int id = new Integer(getParent().getId());
                        HospitalWard hospitalWardRemoved = hospitalWards.get(id);

                        if (hospitalWardRemoved.getId() != null) {
                            hospitalOrganization.getHospitalWardsToDelete().add(hospitalWardRemoved);
                        }

                        for (HospitalWard hw : hospitalOrganization.getHospitalWardsToDelete()) {
                        }

                        hospitalWards.remove(id);
                    }
                };

                //At least one ward is required
                if (item.getIndex() == 0) {
                    linkDelete.setEnabled(false);
                    linkDelete.setVisible(false);
                }

                linkDelete.add(new SimpleAttributeModifier(
                        "title", getString("delete")));
                linkDelete.add(new SimpleAttributeModifier(
                        "onclick",
                        "return confirm('" + getString(
                        "confirm_delete") + "');"));
                item.add(linkDelete);
            }
        });

        Button addButton = new Button("addButton") {

            private static final long serialVersionUID = 9123164874596936371L;

            @Override
            public void onSubmit() {
                hospitalWards.add(new HospitalWard());
            }
        };

        addButton.setDefaultFormProcessing(false);

        form.add(code);
        form.add(name);
        form.add(region);
        form.add(addButton);

        form.add(new Button("save", new Model(getString("save"))));
    }

    /**
     * Convert wards list from java.util.List to java.util.Set for storing it into db.
     */
    public void processWardsList() {
        Set<HospitalWard> wardsHashSet = new HashSet<HospitalWard>();

        for (HospitalWard hospitalWard : hospitalWards) {
            hospitalWard.setHospitalOrganization(hospitalOrganization);
            wardsHashSet.add(hospitalWard);
        }
        hospitalOrganization.setHospitalWards(wardsHashSet);
    }

    /**
     * Initialize hospitalWards (java.util.List) with java.util.Set of an existing Hospital Organization.
     */
    private void initializeWardsList(List<HospitalWard> wardsHashSet) {
        hospitalWards = new ArrayList<HospitalWard>();

        for (HospitalWard hospitalWard : wardsHashSet) {
            hospitalWards.add(hospitalWard);
        }

    }

    /**
     * Extension class of TextField. It's purposed for storing values in the corresponding property model after pressing
     * 'Add' button.
     */
    private static class UpdatingTextField extends TextField {

        private static final long serialVersionUID = -883443353421517407L;

        public UpdatingTextField(final String id, final IModel model) {
            super(id, model);
            add(new AjaxFormComponentUpdatingBehavior(Constants.ON_BLUR) {

                private static final long serialVersionUID = -1107858522700306810L;

                protected void onUpdate(final AjaxRequestTarget target) {
                }
            });
        }
    }

    private void toUtf(final HospitalOrganization ho) {
        if (ho.getCode() != null) {
            ho.setCode(Encoder.toUtf(ho.getCode()));
        }
        if (ho.getName() != null) {
            String name = ho.getName();
            ho.setName(Encoder.toUtf(name.replaceAll("\"", "")));
        }
    }
}
