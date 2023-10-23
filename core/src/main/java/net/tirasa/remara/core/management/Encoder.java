package net.tirasa.remara.core.management;

import java.io.UnsupportedEncodingException;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Encoder {

    private static final Logger LOG = LoggerFactory.getLogger(Encoder.class);

    public static final String UTF_8 = "UTF-8";

    public static final String ISO_8859_1 = "iso8859-1";

    public static String toUtf(final String notUtf) {
        String utfString = "";
        try {
            utfString = new String(notUtf.getBytes(ISO_8859_1), UTF_8);
        } catch (UnsupportedEncodingException ex) {
            LOG.error("Encoding error", ex);
        }
        return utfString;
    }

    public static String encString(final String decryptedString) {
        StandardPBEStringEncryptor encryptorString = new StandardPBEStringEncryptor();
        encryptorString.setPassword("aleofW6mdP6qzJ4");
        return encryptorString.encrypt(decryptedString);
    }
}
