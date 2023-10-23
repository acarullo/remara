package net.tirasa.remara.core.resource;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Locale;
import javax.activation.MimetypesFileTypeMap;
import net.tirasa.remara.core.management.Encoder;
import org.apache.wicket.util.resource.IResourceStream;
import org.apache.wicket.util.resource.ResourceStreamNotFoundException;
import org.apache.wicket.util.time.Time;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class IResourceStringImpl implements IResourceStream {

    private static final Logger LOG = LoggerFactory.getLogger(IResourceStringImpl.class);

    private static final long serialVersionUID = 7237446682015359625L;

    private InputStream inputStream = null;

    private String contentType = null;

    private Locale locale = null;

    private final long size;

    public IResourceStringImpl(final String source, final Locale locale, final String nameFile) {
        size = source.length();
        contentType = new MimetypesFileTypeMap().getContentType(nameFile);
        try {
            inputStream = new ByteArrayInputStream(source.getBytes(Encoder.UTF_8));
        } catch (UnsupportedEncodingException ex) {
            LOG.error("Error on IResourceStringImpl", ex);
        }
        this.locale = locale;
    }

    public String getContentType() {
        return this.contentType;
    }

    public long length() {
        return size;
    }

    public InputStream getInputStream()
            throws ResourceStreamNotFoundException {
        return this.inputStream;
    }

    public void close()
            throws IOException {
        this.inputStream.close();
    }

    public Locale getLocale() {
        return this.locale;
    }

    public void setLocale(final Locale locale) {
        this.locale = locale;
    }

    public Time lastModifiedTime() {
        return null;
    }
}
