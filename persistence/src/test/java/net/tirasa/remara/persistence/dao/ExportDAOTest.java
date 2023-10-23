package net.tirasa.remara.persistence.dao;

import net.tirasa.remara.persistence.dao.ExportDAO;
import static net.tirasa.remara.persistence.dao.AbstractDAOTest.LOG;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.Date;
import net.tirasa.remara.persistence.data.Export;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class ExportDAOTest extends AbstractDAOTest {

    @Autowired
    private ExportDAO exportDAO;

    @Before
    public void populateDb() {
        LOG.debug("INITIALIZING DATABASE");
        Export test = new Export();
        test.setComment("comment");
        test.setExportdate(new Date());
        exportDAO.saveOrUpdate(test);
    }

    @Test
    public void isNotNull() {
        assertNotNull(exportDAO);
    }

    @Test
    public void saveTest() {
        // create export
        Export test3 = new Export();
        test3.setComment("export 5");
        test3.setExportdate(new Date());
        assertNotNull(exportDAO.saveOrUpdate(test3));
        assertEquals(2, exportDAO.findAll().size());
        // update export
        test3 = exportDAO.findAll().get(1);
        test3.setComment("export 4");
        exportDAO.saveOrUpdate(test3);
        assertEquals("export 4", exportDAO.findAll().get(1).getComment());
    }

    @Test
    public void findTest() {
        assertNotNull(exportDAO.findAll());
        LOG.debug("EXPORT TOTALI: {}", exportDAO.findAll().size());

    }

    @Test
    public void deleteTest() {
        assertEquals(1, exportDAO.findAll().size());
        exportDAO.delete(exportDAO.findAll().get(0));
        assertEquals(0, exportDAO.findAll().size());
    }
}
