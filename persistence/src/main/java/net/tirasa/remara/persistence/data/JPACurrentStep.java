/*
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *  under the License.
 */
package net.tirasa.remara.persistence.data;

import com.opensymphony.workflow.spi.Step;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "os_currentstep")
@SequenceGenerator(name = "jcs_seq", sequenceName = "JPACurrentStep_seq", initialValue = 95000, allocationSize = 1)
public class JPACurrentStep implements Serializable, Step {

    private static final long serialVersionUID = -3662582760248954945L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "jcs_seq")
    private Long id;

    @Column(name = "action_Id")
    private Integer actionId;

    @Column(name = "step_Id")
    private Integer stepId;

    private String caller;

    @Column(name = "finish_Date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date finishDate;

    @Column(name = "start_Date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date startDate;

    @Column(name = "due_Date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dueDate;

    @Column
    private String owner;

    private String status;

    @ManyToOne(fetch = FetchType.EAGER)
    @Column(name = "entry_id", nullable = false)
    private JPAWorkflowEntry jPAWorkflowEntry;

    public JPAWorkflowEntry getWorkflowEntry() {
        return jPAWorkflowEntry;
    }

    public void setWorkflowEntry(JPAWorkflowEntry workflowEntry) {
        this.jPAWorkflowEntry = workflowEntry;
    }

    public void setActionId(Integer actionId) {
        this.actionId = actionId;
    }

    @Override
    public int getActionId() {
        return actionId;
    }

    public void setCaller(String caller) {
        this.caller = caller;
    }

    @Override
    public String getCaller() {
        return caller;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    @Override
    public Date getDueDate() {
        return dueDate;
    }

    @Override
    public long getEntryId() {
        return jPAWorkflowEntry.getId();
    }

    public void setFinishDate(Date finishDate) {
        this.finishDate = finishDate;
    }

    @Override
    public Date getFinishDate() {
        return finishDate;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    @Override
    public String getOwner() {
        return owner;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    @Override
    public Date getStartDate() {
        return startDate;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String getStatus() {
        return status;
    }

    public void setStepId(Integer stepId) {
        this.stepId = stepId;
    }

    @Override
    public int getStepId() {
        return stepId;
    }

    /**
     * This is for backward compatibility, but current Store doesn't persist this collection, nor is such property
     * visibile outside OSWF internal classes.
     *
     * @return an empty long[]
     */
    @Override
    public final long[] getPreviousStepIds() {
        return new long[0];
    }

    @Override
    public long getId() {
        return id;
    }
}
