package net.tirasa.remara.persistence.jpasymphony.workflow.spi.jpa;

import com.opensymphony.workflow.FactoryException;
import com.opensymphony.workflow.Workflow;
import com.opensymphony.workflow.basic.BasicWorkflow;
import com.opensymphony.workflow.config.SpringConfiguration;
import com.opensymphony.workflow.loader.XMLWorkflowFactory;
import com.opensymphony.workflow.util.SpringTypeResolver;
import java.util.Properties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class SpringWorkflowFactory extends XMLWorkflowFactory {

    private static final long serialVersionUID = -4498206705177254649L;

    private static final Logger LOG = LoggerFactory.getLogger(JPAWorkflowStore.class);

    @Autowired
    private SpringConfiguration osworkflowConfiguration;

    @Autowired
    private SpringTypeResolver workflowTypeResolver;

    private String resource;

    public void setReload(String reload) {
        this.reload = Boolean.valueOf(reload).booleanValue();
    }

    public void setResource(String resource) {
        this.resource = resource;
    }

    public void init() {
        try {
            Properties props = new Properties();
            props.setProperty("reload", getReload());
            props.setProperty("resource", getResource());

            super.init(props);
            initDone();
        } catch (FactoryException e) {
            throw new RuntimeException(e);
        }
    }

    private String getReload() {
        return String.valueOf(reload);
    }

    private String getResource() {
        return resource;
    }

    public BasicWorkflow workflow(final String username) {
        BasicWorkflow workflow = null;
        try {
            workflow = new BasicWorkflow(username);
            workflow.setConfiguration(osworkflowConfiguration);
            workflow.setResolver(workflowTypeResolver);
        } catch (Exception e) {
            LOG.error("Error creating workflow", e);
        }
        return workflow;
    }
}
