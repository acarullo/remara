package net.tirasa.remara.core.resource;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Locale;
import javax.activation.MimetypesFileTypeMap;
import net.tirasa.remara.persistence.data.FileCase;
import org.apache.wicket.util.resource.IResourceStream;
import org.apache.wicket.util.resource.ResourceStreamNotFoundException;
import org.apache.wicket.util.time.Time;

public class IResourceStreamImpl implements IResourceStream {

    private static final long serialVersionUID = -5526499641907235854L;

    private Locale locale = null;

    private String contentType = null;

    private InputStream inputStream = null;

    private final long size;

    /**
     * @param file
     */
    public IResourceStreamImpl(final FileCase file) {
        inputStream = new ByteArrayInputStream(file.getFile());
        size = file.getFile().length;
        contentType = new MimetypesFileTypeMap().getContentType(file.getName());
        locale = new Locale("en");
    }

    public void close() throws IOException {
        this.inputStream.close();
    }

    public InputStream getInputStream()
            throws ResourceStreamNotFoundException {
        return this.inputStream;
    }

    public String getContentType() {
        return (this.contentType);
    }

    public Locale getLocale() {
        return (this.locale);
    }

    public long length() {
        return this.size;
    }

    public void setLocale(final Locale locale) {
        this.locale = locale;
    }

    public Time lastModifiedTime() {
        return null;
    }
}
