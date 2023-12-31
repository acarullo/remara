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

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

@Entity
@Table(name = "os_propertyset", uniqueConstraints = @UniqueConstraint(columnNames = {"workflowEntryId", "propertyKey"}))
@SequenceGenerator(name = "jps_seq", sequenceName = "jps_seq", initialValue = 10, allocationSize = 1)
public class JPAPropertySetItem implements Serializable {

    private static final long serialVersionUID = 782563951868624467L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "jps_seq")
    private Long id;

    @Column(nullable = false)
    private Integer type;

    @Column(nullable = false)
    private Long workflowEntryId;

    @Column(nullable = false)
    private String propertyKey;

    private Boolean booleanValue;

    private Integer intValue;

    private Long longValue;

    private Double doubleValue;

    private String stringValue;

    @Lob
    private String textValue;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dateValue;

    @Basic
    @Lob
    private byte[] dataValue;

    public Long getId() {
        return id;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getPropertyKey() {
        return propertyKey;
    }

    public void setPropertyKey(String propertyKey) {
        this.propertyKey = propertyKey;
    }

    public String getStringValue() {
        return stringValue;
    }

    public void setStringValue(String stringValue) {
        this.stringValue = stringValue;
    }

    public Long getWorkflowEntryId() {
        return workflowEntryId;
    }

    public void setWorkflowEntryId(Long workflowEntryId) {
        this.workflowEntryId = workflowEntryId;
    }

    public Date getDateValue() {
        return dateValue;
    }

    public void setDateValue(Date dateValue) {
        this.dateValue = dateValue;
    }

    public Boolean getBooleanValue() {
        return booleanValue;
    }

    public void setBooleanValue(Boolean booleanValue) {
        this.booleanValue = booleanValue;
    }

    public Double getDoubleValue() {
        return doubleValue;
    }

    public void setDoubleValue(Double doubleValue) {
        this.doubleValue = doubleValue;
    }

    public Integer getIntValue() {
        return intValue;
    }

    public void setIntValue(Integer intValue) {
        this.intValue = intValue;
    }

    public Long getLongValue() {
        return longValue;
    }

    public void setLongValue(Long longValue) {
        this.longValue = longValue;
    }

    public String getTextValue() {
        return textValue;
    }

    public void setTextValue(String textValue) {
        this.textValue = textValue;
    }

    public byte[] getDataValue() {
        return dataValue;
    }

    public void setDataValue(byte[] dataValue) {
        this.dataValue = dataValue;
    }
}
