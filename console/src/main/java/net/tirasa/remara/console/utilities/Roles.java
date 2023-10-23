package net.tirasa.remara.console.utilities;

public enum Roles {

    ADMINISTRATOR(1),
    REFERENT(2),
    COMPILER(3);

    private final int code;

    private Roles(final int c) {
        code = c;
    }

    public int getCode() {
        return code;
    }
}
