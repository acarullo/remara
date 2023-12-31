package net.tirasa.remara.persistence.dao;

import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:persistenceJUnitTestContext.xml"})
public abstract class AbstractDAOTest {

    protected static final Logger LOG = LoggerFactory.getLogger(AbstractDAOTest.class);

}
