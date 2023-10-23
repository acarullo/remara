package net.tirasa.remara.core.quartz;

import java.util.Date;
import java.util.List;
import net.tirasa.remara.core.management.CaseManagement;
import net.tirasa.remara.persistence.data.MedicineCase;
import org.apache.commons.lang.time.DateUtils;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;

@Component
public class PubertaPrecoceJob extends QuartzJobBean {

    private static final Logger LOG = LoggerFactory.getLogger(PubertaPrecoceJob.class);

    @Autowired
    private CaseManagement caseManagement;

    @Override
    protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
        LOG.debug("PubertaPrecoceJob: search for MC ex PP");
        final Date TODAY = new Date();
        final List<MedicineCase> listMc = caseManagement.findAll();

        for (final MedicineCase medicineCase : listMc) {
            final Date comparisionDate = DateUtils.addYears(medicineCase.getPatient().getBirthDate(), 15);
            if (comparisionDate.after(TODAY) && medicineCase.getIllness().getId() == 7 && !medicineCase.isExPp()) {
                LOG.debug("MC {} moved to ExPP", medicineCase.getId());
                medicineCase.setExPp(true);
                caseManagement.toExPP(medicineCase);
            }
        }
    }
}
