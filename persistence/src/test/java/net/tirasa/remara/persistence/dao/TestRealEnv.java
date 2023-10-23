package net.tirasa.remara.persistence.dao;

import static org.junit.Assert.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.junit.Test;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class TestRealEnv extends AbstractDAOTest {

    @PersistenceContext
    private EntityManager entityManager;

    @Test
    public void isNotNull() {
        assertNotNull(entityManager);
    }
}
