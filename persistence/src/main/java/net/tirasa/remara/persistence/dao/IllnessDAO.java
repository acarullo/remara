package net.tirasa.remara.persistence.dao;

import java.util.Iterator;
import java.util.List;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import net.tirasa.remara.persistence.data.Illness;
import net.tirasa.remara.persistence.data.Patient;

public interface IllnessDAO {

    public Illness saveOrUpdate(Illness illness);

    public Illness get(Long illnessId);

    public List<Illness> findByProperty(String propertyName, String value);

    public List<Illness> findByProperty(String propertyName, Object value);

    public List<Illness> findByCode(String code, int maxResults);

    public List<Illness> findAll();

    public int deleteByProperty(String propertyName, Object value);

//    public CriteriaBuilder getCriteriaBuilder();
//
//    public Object executeCriteriaQueryUnique(CriteriaQuery criteriaQuery);
//
//    public List<Illness> executeCriteriaQuery(CriteriaQuery criteriaQuery, int first, int count);

    public List<Illness> executeQuery(TypedQuery<Illness> query);

    public Object executeQueryUnique(TypedQuery<Integer> query);

    public TypedQuery<Integer> createCountQuery(String sql);

    public TypedQuery<Illness> createQuery(String sql);

    public List<Long> executeQueryIllnessId(TypedQuery<Long> query);

    public TypedQuery<Long> createQueryIllnessId(String sql);
}
