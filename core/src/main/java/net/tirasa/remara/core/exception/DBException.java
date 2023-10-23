package net.tirasa.remara.core.exception;

public class DBException extends Exception {

    public static final String USER_PEDIATRICIAN_EXIST = "error.user_pediatrician_exist";

    public static final String CASE_WITHOUT_EXAMS = "error.case_without_exams";

    public static final String ELEMENT_EXIST = "error.element_exist";

    public static final String DESCRIPTION_EXIST = "error.description_exist";

    public static final String SAVE = "error.save";

    public static final String DELETE = "error.delete";

    public static final String CONFIRM = "error.confirm";

    public static final String REQUEST_MODIFIE = "error.update";

    public static final String ASSIGN = "error.assign";

    public static final String WFOP_NOT_ALLOWED = "error.wfOperation.notAllowed";

    private static final long serialVersionUID = 6634986975526748276L;

    /**
     * Creates a new instance of
     * <code>DBException</code> without detail message.
     */
    public DBException() {
    }

    /**
     * Constructs an instance of
     * <code>DBException</code> with the specified detail message.
     *
     * @param msg the detail message.
     */
    public DBException(String msg) {
        super(msg);
    }
}
