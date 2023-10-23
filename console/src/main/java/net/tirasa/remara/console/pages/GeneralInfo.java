package net.tirasa.remara.console.pages;

import net.tirasa.remara.core.management.CaseManagement;
import net.tirasa.remara.core.management.PatientManagement;
import net.tirasa.remara.core.workflow.WorkflowManager;
import org.apache.wicket.authorization.strategies.role.annotations.AuthorizeInstantiation;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.spring.injection.annot.SpringBean;

@AuthorizeInstantiation("ADMIN")
public class GeneralInfo extends BasePage {

    private static final long serialVersionUID = -1240610412735066331L;

    @SpringBean
    private CaseManagement caseManagement;

    @SpringBean
    private PatientManagement patientManagement;

    public GeneralInfo() {
        super();
        add(new Label("totalPatients", String.valueOf(patientManagement.countPatients())));
        add(new Label("totalCases", String.valueOf(caseManagement.countCases())));
        add(new Label("totalApprovedCases", String.valueOf(caseManagement.countStatusCases(
                WorkflowManager.STATUS_APPROVED))));
        add(new Label("totalUnderwayCases", String.valueOf(caseManagement.countStatusCases(
                WorkflowManager.STATUS_UNDERWAY))));
        add(new Label("totalRejectedCases", String.valueOf(caseManagement.countStatusCases(
                WorkflowManager.STATUS_REJECTED))));
        add(new Label("totalQueuedCases", String.valueOf(caseManagement.countStatusCases(WorkflowManager.STATUS_QUEUED))));
        add(new Label("totalAssignedCases", String.valueOf(caseManagement.countStatusCases(
                WorkflowManager.STATUS_ASSIGNED))));
        add(new Label("totalExPPCases", String.valueOf(caseManagement.countExPP())));
        add(new Label("totalFemalePatients", String.valueOf(patientManagement.countSexPatients("F"))));
        add(new Label("totalMalePatients", String.valueOf(patientManagement.countSexPatients("M"))));
        add(new Label("totalAdultPatients", String.valueOf(patientManagement.countAdultPatients())));
        add(new Label("totalMinorPatients", String.valueOf(patientManagement.countMinorPatients())));
    }
}
