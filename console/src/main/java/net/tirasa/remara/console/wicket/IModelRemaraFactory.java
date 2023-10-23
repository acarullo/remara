package net.tirasa.remara.console.wicket;

import net.tirasa.remara.core.management.CaseManagement;
import java.io.Serializable;
import java.util.List;
import net.tirasa.remara.persistence.data.Municipality;
import net.tirasa.remara.persistence.data.Patient;
import net.tirasa.remara.persistence.data.Province;
import org.apache.wicket.model.AbstractReadOnlyModel;
import org.apache.wicket.model.IModel;
import org.apache.wicket.model.LoadableDetachableModel;
import org.apache.wicket.spring.injection.annot.SpringBean;

public class IModelRemaraFactory implements Serializable {

    private static final long serialVersionUID = 7915722765288340786L;
    
    @SpringBean
    private CaseManagement caseManagement;

    public IModelRemaraFactory() {
    }

    public IModel municipalityIModelWithLivingProvince(final Patient patient) {
        return new AbstractReadOnlyModel() {

            private static final long serialVersionUID = -2583290457773357445L;

            @Override
            public List<Municipality> getObject() {
                return caseManagement.getMunicipality(patient.getLivingProvince());
            }
        };
    }

    public IModel municipalityIModelWithBirthProvince(final Patient patient) {
        return new AbstractReadOnlyModel() {

            private static final long serialVersionUID = -2583290457773357445L;

            @Override
            public List<Municipality> getObject() {
                return caseManagement.getMunicipality(patient.getBirthProvince());
            }
        };
    }

    public IModel provinceIModelWithLivingProvince(final Patient patient) {
        return new AbstractReadOnlyModel() {

            private static final long serialVersionUID = -2583290457773357445L;

            @Override
            public List<Province> getObject() {
                return caseManagement.getProvince(patient.getLivingRegion());
            }
        };
    }

    public IModel provinceIModelWithBirthProvince(final Patient patient) {
        return new AbstractReadOnlyModel() {

            private static final long serialVersionUID = -2583290457773357445L;

            @Override
            public List<Province> getObject() {
                return caseManagement.getProvince(patient.getBirthRegion());
            }
        };
    }

    public IModel cadastreModel(final Patient patient) {
        return new LoadableDetachableModel() {

            private static final long serialVersionUID = 1881223977635673509L;

            @Override
            public String getObject() {
                if (patient.getBirthMunicipality() != null) {
                    return patient.getBirthMunicipality().getCadastre();
                }
                return "";
            }

            @Override
            protected Object load() {
                if (patient.getBirthMunicipality() != null) {
                    return patient.getBirthMunicipality().getCadastre();
                }
                return "";
            }
        };
    }
}
