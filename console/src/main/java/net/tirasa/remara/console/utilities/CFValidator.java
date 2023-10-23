package net.tirasa.remara.console.utilities;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CFValidator {

    public static boolean validate(final String cf) {
        String codiceFiscale = cf.toUpperCase();
        Pattern pattern = Pattern.compile("[A-Z]{6}[0-9]{2}[A-Z]{1}[0-9]{2}[A-Z]{1}[0-9]{3}[A-Z]{1}");
        Matcher matcher = pattern.matcher(codiceFiscale);
        return matcher.matches();
    }
}
