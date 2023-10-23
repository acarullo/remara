package net.tirasa.remara.core.resource;

import net.tirasa.remara.core.management.PDFCase;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Locale;
import javax.activation.MimetypesFileTypeMap;
import net.tirasa.remara.persistence.data.MedicineCase;
import net.tirasa.remara.persistence.data.Patient;
import org.apache.wicket.util.resource.IResourceStream;
import org.apache.wicket.util.resource.ResourceStreamNotFoundException;
import org.apache.wicket.util.time.Time;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class IResourcePDFImpl implements IResourceStream {

    private static final long serialVersionUID = 6792203077396231245L;

    @Autowired
    private PDFCase pdf;

    private long size;

    private InputStream inputStream;

    private Locale locale;

    public IResourcePDFImpl iResourcePDFImpl(Object o, boolean patient) {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        if (o instanceof Patient) {
            out = pdf.createPatientDetailsPDF((Patient) o);
        } else if (o instanceof MedicineCase) {
            if (patient) {
                out = pdf.createPatientPDF((MedicineCase) o);
            } else {
                out = pdf.createPDF((MedicineCase) o);
            }
        }
        byte[] b = out.toByteArray();
        inputStream = new ByteArrayInputStream(b);
        size = b.length;
        return this;
    }

    public String getContentType() {
        return new MimetypesFileTypeMap().getContentType("certificato.pdf");
    }

    public Locale getLocale() {
        return Locale.ITALY;
    }

    public long length() {
        return this.size;
    }

    public Time lastModifiedTime() {
        return null;
    }

    public InputStream getInputStream() throws ResourceStreamNotFoundException {
        return this.inputStream;
    }

    public void close() throws IOException {
        inputStream.close();
    }

    public void setLocale(Locale locale) {
        this.locale = locale;
    }
}
