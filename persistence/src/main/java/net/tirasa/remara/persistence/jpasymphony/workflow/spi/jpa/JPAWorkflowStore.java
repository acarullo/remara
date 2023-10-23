package net.tirasa.remara.persistence.jpasymphony.workflow.spi.jpa;

import com.opensymphony.module.propertyset.PropertySet;
import com.opensymphony.workflow.QueryNotSupportedException;
import com.opensymphony.workflow.StoreException;
import com.opensymphony.workflow.query.Expression;
import com.opensymphony.workflow.query.FieldExpression;
import com.opensymphony.workflow.query.NestedExpression;
import com.opensymphony.workflow.query.WorkflowExpressionQuery;
import com.opensymphony.workflow.query.WorkflowQuery;
import com.opensymphony.workflow.spi.Step;
import com.opensymphony.workflow.spi.WorkflowEntry;
import com.opensymphony.workflow.spi.WorkflowStore;
import com.opensymphony.workflow.util.PropertySetDelegate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceContextType;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import net.tirasa.remara.persistence.dao.JPACurrentStepDAO;
import net.tirasa.remara.persistence.dao.JPAWorkflowEntryDAO;
import net.tirasa.remara.persistence.data.JPACurrentStep;
import net.tirasa.remara.persistence.data.JPAHistoryStep;
import net.tirasa.remara.persistence.data.JPAWorkflowEntry;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * JPA implementation of OSWorkflow's WorkflowStore. Still using Hibernate's criteria API (available since JPA 2.0).
 */
public class JPAWorkflowStore implements WorkflowStore {

    private static final Logger LOG = LoggerFactory.getLogger(JPAWorkflowStore.class);

    @PersistenceContext(type = PersistenceContextType.TRANSACTION)
    private EntityManager entityManager;

    @Autowired
    private JPAWorkflowEntryDAO workflowEntryDAO;

    @Autowired
    private JPACurrentStepDAO jPACurrentStepDAO;

    @Autowired
    private PropertySetDelegate propertySetDelegate;

    public JPAWorkflowStore() {
    }

    public JPAWorkflowStore(
            final EntityManager entityManager,
            final JPAWorkflowEntryDAO workflowEntryDAO,
            final PropertySetDelegate propertySetDelegate) {
        this.entityManager = entityManager;
        this.workflowEntryDAO = workflowEntryDAO;
        this.propertySetDelegate = propertySetDelegate;
    }

    private JPAWorkflowEntry getEntry(final long entryId) throws StoreException {

        JPAWorkflowEntry entry = workflowEntryDAO.find(entryId);
        if (entry == null) {
            throw new StoreException("Could not find workflow entry " + entryId);
        }

        return entry;
    }

    @Override
    public void setEntryState(final long entryId, final int state) throws StoreException {

        LOG.debug("Set state {} to entry {}", state, entryId);

        JPAWorkflowEntry entry = getEntry(entryId);

        entry.setWorkflowState(state);

        workflowEntryDAO.save(entry);
    }

    @Override
    public PropertySet getPropertySet(final long entryId) throws StoreException {

        if (propertySetDelegate == null) {
            throw new StoreException("PropertySetDelegate is not properly configured");
        }

        return propertySetDelegate.getPropertySet(entryId);
    }

    @Override
    public Step createCurrentStep(final long entryId,
            final int stepId,
            final String owner,
            final Date startDate,
            final Date dueDate,
            final String status,
            final long[] previousIds)
            throws StoreException {

        LOG.debug("Create current step for entryId {}", entryId);
        JPAWorkflowEntry entry = getEntry(entryId);

        JPACurrentStep step = new JPACurrentStep();
        step.setWorkflowEntry(entry);
        step.setStepId(stepId);

        step.setOwner(owner);
        step.setStartDate(startDate);
        step.setStatus(status);
        step.setActionId(0);

        return jPACurrentStepDAO.save(step);
    }

    @Override
    public WorkflowEntry createEntry(final String workflowName) throws StoreException {

        LOG.debug("Create entry with this workflow {}", workflowName);

        JPAWorkflowEntry entry = new JPAWorkflowEntry();
        entry.setWorkflowState(WorkflowEntry.CREATED);
        entry.setWorkflowName(workflowName);
        entry.setVersion(1);

        return workflowEntryDAO.save(entry);
    }

    @Override
    public List findCurrentSteps(final long entryId) throws StoreException {

        LOG.debug("Search current step with entryId {}", entryId);
        return jPACurrentStepDAO.findByEntryId(entryId);
    }

    @Override
    public WorkflowEntry findEntry(final long entryId) throws StoreException {
        LOG.debug("Search entry with id {}", entryId);
        return getEntry(entryId);
    }

    @Override
    public List findHistorySteps(final long entryId) throws StoreException {
        LOG.debug("Search historyStep with entryId {}", entryId);
        JPAWorkflowEntry entry = getEntry(entryId);

        return entry.getHistorySteps();
    }

    @Override
    public void init(final Map props) throws StoreException {
        LOG.debug("INIT WORKFLOW");
    }

    @Override
    public Step markFinished(final Step step, final int actionId, final Date finishDate, final String status,
            final String caller) throws StoreException {

        LOG.debug("MARK FINISH");

        final JPACurrentStep currentStep = (JPACurrentStep) step;

        currentStep.setActionId(actionId);
        currentStep.setFinishDate(finishDate);
        currentStep.setCaller(caller);

        workflowEntryDAO.save(currentStep.getWorkflowEntry());

        return currentStep;
    }

    @Override
    public void moveToHistory(final Step step) throws StoreException {

        LOG.debug("Move to history step with id {} and owner {}", step.getId(), step.getOwner());

        final JPACurrentStep currentStep = (JPACurrentStep) step;
        final JPAWorkflowEntry entry = currentStep.getWorkflowEntry();

        final JPAHistoryStep historyStep = new JPAHistoryStep();
        historyStep.setActionId(currentStep.getActionId());
        historyStep.setCaller(currentStep.getCaller());
        historyStep.setDueDate(currentStep.getDueDate());
        historyStep.setFinishDate(currentStep.getFinishDate());
        historyStep.setOwner(currentStep.getOwner());
        historyStep.setStartDate(currentStep.getStartDate());
        historyStep.setStatus(currentStep.getStatus());
        historyStep.setStepId(currentStep.getStepId());
        historyStep.setWorkflowEntry(entry);

        entry.removeCurrentStep(currentStep);
        workflowEntryDAO.deleteCurrentStep(currentStep.getId());

        entry.addHistoryStep(historyStep);
        workflowEntryDAO.save(entry);
    }

    @Override
    @Deprecated
    public List query(final WorkflowQuery query) throws StoreException {
        LOG.error("Deprecated query {}", query);
        throw new UnsupportedOperationException("Deprecated");
    }

    /**
     * @param query
     * @return
     * @throws com.opensymphony.workflow.StoreException
     * @see com.opensymphony.workflow.spi.WorkflowStore #query(com.opensymphony.workflow.query.WorkflowExpressionQuery)
     */
    @Override
    public List query(final WorkflowExpressionQuery query) throws StoreException {

        LOG.debug("Execute query {}", query.getExpression().toString());

        Class entityClass = getQueryClass(query.getExpression(), null);

        CriteriaQuery criteria = entityManager.getCriteriaBuilder().createQuery(
                getQueryClass(query.getExpression(), null));
        Root from = criteria.from(entityClass);

        Predicate expr = query.getExpression().isNested()
                ? buildNested((NestedExpression) query.getExpression(), from)
                : queryComp((FieldExpression) query.getExpression(), from);

        criteria.where(expr);

        TypedQuery criteriaQuery = entityManager.createQuery(criteria);

        List<Long> results = new ArrayList<Long>();
        Object next;
        Long item;
        for (Iterator iter = criteriaQuery.getResultList().iterator(); iter.hasNext();) {

            next = iter.next();

            if (next instanceof JPACurrentStep) {
                JPACurrentStep step = (JPACurrentStep) next;
                item = Long.valueOf(step.getId());
            } else if (next instanceof JPAHistoryStep) {
                JPAHistoryStep step = (JPAHistoryStep) next;
                item = Long.valueOf(step.getId());
            } else {
                WorkflowEntry entry = (WorkflowEntry) next;
                item = Long.valueOf(entry.getId());
            }

            results.add(item);
        }
        return results;
    }

    private Class getQueryClass(Expression expr, Collection classesCache) {
        if (classesCache == null) {
            classesCache = new HashSet();
        }

        if (expr instanceof FieldExpression) {
            FieldExpression fieldExpression = (FieldExpression) expr;

            switch (fieldExpression.getContext()) {
                case FieldExpression.CURRENT_STEPS:
                    classesCache.add(JPACurrentStep.class);

                    break;

                case FieldExpression.HISTORY_STEPS:
                    classesCache.add(JPAHistoryStep.class);

                    break;

                case FieldExpression.ENTRY:
                    classesCache.add(JPAWorkflowEntry.class);

                    break;

                default:
                    throw new QueryNotSupportedException(
                            "Query for unsupported context " + fieldExpression.getContext());
            }
        } else {
            NestedExpression nestedExpression = (NestedExpression) expr;

            for (int i = 0; i < nestedExpression.getExpressionCount(); i++) {
                Expression expression = nestedExpression.getExpression(i);

                if (expression.isNested()) {
                    classesCache.add(getQueryClass(nestedExpression.getExpression(i), classesCache));
                } else {
                    classesCache.add(getQueryClass(expression, classesCache));
                }
            }
        }

        if (classesCache.size() > 1) {
            throw new QueryNotSupportedException(
                    "Store does not support nested queries of different types "
                    + "(types found:" + classesCache + ")");
        }

        return (Class) classesCache.iterator().next();
    }

    private Predicate buildNested(NestedExpression nestedExpression,
            Root from) {

        Predicate full = null;

        for (int i = 0; i < nestedExpression.getExpressionCount(); i++) {
            Predicate expr;
            Expression expression = nestedExpression.getExpression(i);

            if (expression.isNested()) {
                expr = buildNested((NestedExpression) nestedExpression.getExpression(i), from);
            } else {
                FieldExpression sub = (FieldExpression) nestedExpression.getExpression(i);
                expr = queryComp(sub, from);

                if (sub.isNegate()) {
                    expr = entityManager.getCriteriaBuilder().not(expr);
                }
            }

            if (full == null) {
                full = expr;
            } else {
                switch (nestedExpression.getExpressionOperator()) {
                    case NestedExpression.AND:
                        full = entityManager.getCriteriaBuilder().
                                and(full, expr);
                        break;

                    case NestedExpression.OR:
                        full = entityManager.getCriteriaBuilder().
                                or(full, expr);
                        break;

                    default:
                }
            }
        }

        return full;
    }

    private Predicate queryComp(FieldExpression expression, Root from) {
        switch (expression.getOperator()) {
            default:
            case FieldExpression.EQUALS:
                return entityManager.getCriteriaBuilder().equal(
                        from.get(getFieldName(expression.getField())),
                        expression.getValue());

            case FieldExpression.NOT_EQUALS:
                return entityManager.getCriteriaBuilder().notEqual(
                        from.get(getFieldName(expression.getField())),
                        expression.getValue());

            case FieldExpression.GT:
                return entityManager.getCriteriaBuilder().gt(
                        from.get(getFieldName(expression.getField())),
                        (Number) (expression.getValue()));

            case FieldExpression.LT:
                return entityManager.getCriteriaBuilder().lt(
                        from.get(getFieldName(expression.getField())),
                        (Number) (expression.getValue()));
        }
    }

    private String getFieldName(int field) {
        switch (field) {
            case FieldExpression.ACTION: // actionId
                return "actionId";

            case FieldExpression.CALLER:
                return "caller";

            case FieldExpression.FINISH_DATE:
                return "finishDate";

            case FieldExpression.OWNER:
                return "owner";

            case FieldExpression.START_DATE:
                return "startDate";

            case FieldExpression.STEP: // stepId
                return "stepId";

            case FieldExpression.STATUS:
                return "status";

            case FieldExpression.STATE:
                return "workflowState";

            case FieldExpression.NAME:
                return "workflowName";

            case FieldExpression.DUE_DATE:
                return "dueDate";

            default:
                return "1";
        }
    }
}
