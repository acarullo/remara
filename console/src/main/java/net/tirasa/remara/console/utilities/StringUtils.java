package net.tirasa.remara.console.utilities;

import java.io.UnsupportedEncodingException;
import java.util.regex.Pattern;

public class StringUtils {

    public static String toUtf(final String notUtf) {
        String utfString = "";
        try {
            utfString = new String(notUtf.getBytes("iso8859-1"), "UTF-8");
        } catch (UnsupportedEncodingException ex) {
        }
        return utfString;
    }

    public static boolean containsLowerCase(final String string) {
        final Pattern LOWER_CASE = Pattern.compile("\\p{Lu}");

        boolean returnValue = true;
        if (string != null) {
            returnValue = LOWER_CASE.matcher(string).find();
        }
        return returnValue;
    }
}
