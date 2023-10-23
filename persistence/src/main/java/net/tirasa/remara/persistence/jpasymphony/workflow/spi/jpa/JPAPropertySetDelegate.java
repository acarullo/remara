package net.tirasa.remara.persistence.jpasymphony.workflow.spi.jpa;

import com.opensymphony.module.propertyset.PropertySet;
import com.opensymphony.module.propertyset.PropertySetManager;
import com.opensymphony.workflow.util.PropertySetDelegate;
import java.util.HashMap;
import java.util.Map;
import net.tirasa.remara.persistence.dao.JPAPropertySetItemDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class JPAPropertySetDelegate implements PropertySetDelegate {

    final public static String DAO = "propertySetItemDAO";

    final public static String ENTRY_ID = "entryId";

    @Autowired
    private JPAPropertySetItemDAO propertySetItemDAO;

    @Override
    public PropertySet getPropertySet(long entryId) {
        Map<String, Object> args = new HashMap<>();
        args.put(ENTRY_ID, Long.valueOf(entryId));
        args.put(DAO, propertySetItemDAO);

        return PropertySetManager.getInstance("jpa", args);
    }
}
