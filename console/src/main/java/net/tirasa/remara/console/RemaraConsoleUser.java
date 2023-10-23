package net.tirasa.remara.console;

import java.io.Serializable;

public class RemaraConsoleUser implements Serializable {

    private static final long serialVersionUID = 5624663559895525539L;

    private final String username;

    private final String name;

    private final String surname;

    private final long role;

    private final String email;

    public RemaraConsoleUser(final String username, final String name,
            final String surname, final long role, final String email) {
        this.username = username;
        this.name = name;
        this.surname = surname;
        this.role = role;
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public String getName() {
        return name;
    }

    public String getSurname() {
        return surname;
    }

    public long getRole() {
        return role;
    }

    public String getEmail() {
        return email;
    }
}
