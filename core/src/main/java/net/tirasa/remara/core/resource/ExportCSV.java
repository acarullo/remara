package net.tirasa.remara.core.resource;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ExportCSV {

    public String getAN(final String s, final int len) {
        String result = s;
        if (result == null) {
            result = "";
        }
        if (result.length() > len) {
            return result.substring(0, len);
        }
        if (result.length() < len) {
            int n = len - result.length();
            for (int i = 0; i < n; i++) {
                result += " ";
            }
        }
        return result;
    }

    public String getDT(final Date d) {
        if (d == null) {
            return "        ";
        }
        return new SimpleDateFormat("ddMMyyyy").format(d);
    }

    public String getFG(Boolean b) {
        if (b == null) {
            return "0";
        }
        if (b) {
            return "1";
        }
        return "0";
    }

    public String getNU(final int number, final int len) {
        String result = String.valueOf(number);
        if (result == null) {
            result = "";
        }
        if (result.length() > len) {
            return result.substring(0, len);
        }
        if (result.length() < len) {
            int n = len - result.length();
            for (int i = 0; i < n; i++) {
                result = "0" + result;
            }
        }
        return result;
    }
}
