package net.tirasa.remara.persistence.dao;

import com.opensymphony.workflow.InvalidInputException;
import com.opensymphony.workflow.WorkflowException;
import com.opensymphony.workflow.basic.BasicWorkflow;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import net.tirasa.remara.persistence.data.JPACurrentStep;
import net.tirasa.remara.persistence.jpasymphony.workflow.spi.jpa.SpringWorkflowFactory;
import org.junit.Assert;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:persistenceWithoutSqlContext.xml"})
public class JpaWorkflowTest {

    @Autowired
    private SpringWorkflowFactory springWorkflowFactory;

    @Autowired
    private JPAWorkflowEntryDAO workflowEntryDAO;

    @Autowired
    private JPACurrentStepDAO jPACurrentStepDAO;

    private static final Map emptyMap = new HashMap();

    private long workflowId = 0;

    @Test
    public void testNotNull() {
        Assert.assertNotNull(springWorkflowFactory);
        Assert.assertNotNull(workflowEntryDAO);
        Assert.assertNotNull(jPACurrentStepDAO);
    }

    @Ignore
    @Test
    public void test() throws InvalidInputException, WorkflowException {
        BasicWorkflow workflow = springWorkflowFactory.workflow("massimiliano");

        workflowId = workflow.initialize("case", 100, emptyMap);

        workflow.doAction(workflowId, 1, emptyMap);

        List<JPACurrentStep> jpacsList = jPACurrentStepDAO.findByEntryId(15000L);

        JPACurrentStep jpacs = jpacsList.get(0);

        Assert.assertNotNull(jpacs);

        Assert.assertEquals(15000L, jpacs.getEntryId());

    }
}
