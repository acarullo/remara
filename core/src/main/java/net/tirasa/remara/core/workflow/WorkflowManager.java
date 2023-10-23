package net.tirasa.remara.core.workflow;

import com.opensymphony.workflow.InvalidActionException;
import com.opensymphony.workflow.WorkflowException;
import com.opensymphony.workflow.basic.BasicWorkflow;
import com.opensymphony.workflow.query.Expression;
import com.opensymphony.workflow.query.FieldExpression;
import com.opensymphony.workflow.query.NestedExpression;
import com.opensymphony.workflow.query.WorkflowExpressionQuery;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import net.tirasa.remara.persistence.jpasymphony.workflow.spi.jpa.SpringWorkflowFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class WorkflowManager {

    @Autowired
    private SpringWorkflowFactory springWorkflowFactory;

    private static final Map emptyMap = new HashMap();

    protected String caller = "";

    protected long workflowId = 0;

    public static final int ACTION_SAVE = 1;

    public static final int ACTION_CONFIRM = 2;

    public static final int ACTION_ASSIGN = 3;

    public static final int ACTION_APPROVE = 4;

    public static final int ACTION_REQUEST_MODIFIE = 5;

    public static final int ACTION_REJECT = 7;

    public static final String STATUS_UNDERWAY = "Underway";

    public static final String STATUS_QUEUED = "Queued";

    public static final String STATUS_ASSIGNED = "Assigned";

    public static final String STATUS_APPROVED = "Approved";

    public static final String STATUS_REJECTED = "Rejected";

    public long getIdWorkflow() {
        return workflowId;
    }

    public void setIdWorkflow(final long idWorkflow) {
        this.workflowId = idWorkflow;
    }

    public synchronized void initialize() throws InvalidActionException, WorkflowException {
        BasicWorkflow workflow = springWorkflowFactory.workflow(caller);
        workflowId = workflow.initialize("case", 100, emptyMap);
    }

    public void doAction(final int step) throws WorkflowException {
        BasicWorkflow workflow = springWorkflowFactory.workflow(caller);
        workflow.doAction(workflowId, step, emptyMap);
    }

    public void doAction(final int step, final Map map) throws WorkflowException {
        BasicWorkflow workflow = springWorkflowFactory.workflow(caller);
        workflow.doAction(workflowId, step, map);
    }

    public void doAction(final Long wfId, final int step, final Map map) throws WorkflowException {
        BasicWorkflow workflow = springWorkflowFactory.workflow(caller);
        workflow.doAction(wfId, step, map);
    }

    /**
     * Searches for all workflows identified by status
     *
     * @param status
     * @return List
     * @throws com.opensymphony.workflow.WorkflowException
     */
    public List<Long> findWfByStatus(final String status) throws WorkflowException {

        BasicWorkflow workflow = springWorkflowFactory.workflow(caller);

        Expression queryStatus = new FieldExpression(FieldExpression.STATUS,
                FieldExpression.CURRENT_STEPS,
                FieldExpression.EQUALS, status);

        WorkflowExpressionQuery weq = new WorkflowExpressionQuery(queryStatus);

        weq.setOrderBy(FieldExpression.START_DATE);
        weq.setSortOrder(WorkflowExpressionQuery.SORT_DESC);

        return workflow.query(weq);
    }

    /**
     * Searches for all workflows identified by status and owner
     *
     * @param status
     * @return List
     * @throws com.opensymphony.workflow.WorkflowException
     */
    public List findWfByStatusOwner(final String status) throws WorkflowException {
        
        BasicWorkflow workflow = springWorkflowFactory.workflow(caller);
        Expression queryOwner = new FieldExpression(
                FieldExpression.OWNER,
                FieldExpression.CURRENT_STEPS,
                FieldExpression.EQUALS, caller);

        Expression queryStatus = new FieldExpression(
                FieldExpression.STATUS,
                FieldExpression.CURRENT_STEPS,
                FieldExpression.EQUALS, status);

        WorkflowExpressionQuery weq = null;

        if (caller != null && status == null) {
            weq = new WorkflowExpressionQuery(queryOwner);
        }
        if (caller != null && status != null) {
            weq = new WorkflowExpressionQuery(
                    new NestedExpression(new Expression[]{queryOwner, queryStatus},
                    NestedExpression.AND));
        }

        weq.setOrderBy(FieldExpression.START_DATE);
        weq.setSortOrder(WorkflowExpressionQuery.SORT_DESC);

        return workflow.query(weq);
    }

    public void setCaller(final String caller) {
        this.caller = caller;
    }
}
