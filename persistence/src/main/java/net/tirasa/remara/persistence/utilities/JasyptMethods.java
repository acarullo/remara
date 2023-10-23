package net.tirasa.remara.persistence.utilities;

import java.io.Serializable;
import java.util.ResourceBundle;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.jasypt.encryption.pbe.PBEByteEncryptor;
import org.jasypt.encryption.pbe.StandardPBEByteEncryptor;
import org.jasypt.salt.FixedStringSaltGenerator;

public class JasyptMethods implements Serializable {

    private static final long serialVersionUID = 7028353278286565170L;

    private ResourceBundle prop;

    private StandardPBEStringEncryptor encryptorString;

    private PBEByteEncryptor encryptorByte;

    private FixedStringSaltGenerator fixedStringSaltGenerator;

    private static JasyptMethods istanza = null;

    private JasyptMethods() {
        init();
    }

    public static synchronized JasyptMethods getJasyptMethods() {
        if (istanza == null) {
            istanza = new JasyptMethods();
        }
        return istanza;
    }

    private void init() {
        prop = ResourceBundle.getBundle("jasyptConfig");

        final String s = prop.getString("jasypt.key");

        encryptorString = new StandardPBEStringEncryptor();
        fixedStringSaltGenerator = new FixedStringSaltGenerator();
        fixedStringSaltGenerator.setSalt("salt salt");
        fixedStringSaltGenerator.setCharset("UTF-8");
        encryptorString.setPassword(s);
        encryptorString.setSaltGenerator(fixedStringSaltGenerator);
        encryptorByte = new StandardPBEByteEncryptor();
        encryptorByte.setPassword(s);
    }

    public String encrypt(final String decryptedString) {
        return encryptorString.encrypt(decryptedString);
    }

    public String decrypt(final String encryptedString) {
        return encryptorString.decrypt(encryptedString);
    }

    public byte[] bencrypt(final byte[] decryptedByteArr) {
        return encryptorByte.encrypt(decryptedByteArr);
    }

    public byte[] bdecrypt(final byte[] encryptedByteArr) {
        return encryptorByte.decrypt(encryptedByteArr);
    }
}
