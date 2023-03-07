package online.vrscuola.controllers;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import online.vrscuola.utilities.FileUtils;
import org.springframework.http.MediaType;
import org.springframework.http.MediaTypeFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ResourceController {

    private static final Path RESOURCE_DIR = Paths.get("/var/lib/tomcat9/resources");

    @GetMapping(value = "/resources/files", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<ResourceInfo>> getResourcesFiles() {
        List<ResourceInfo> resources = new ArrayList<>();
        try {
            File directory = RESOURCE_DIR.toFile();
            if (directory.isDirectory()) {
                File[] files = directory.listFiles();
                if (files != null) {
                    for (File file : files) {
                        String hash = FileUtils.calculateHash(file);
                        if (file.isFile()) {
                            resources.add(new ResourceInfo(file.getName(), file.length(), getMimeType(file), hash));
                        }
                    }
                }
            }
        } catch (Exception e) {
            // Gestione dell'eccezione
        }
        return ResponseEntity.ok(resources);
    }

    private String getMimeType(File file) {
        // Recupera il tipo MIME del file a partire dal nome del file o dall'estensione
        // Utilizza la classe org.springframework.http.MediaTypeFactory per ottenere il tipo MIME
        return MediaTypeFactory.getMediaType(file.getName())
                .orElse(MediaType.APPLICATION_OCTET_STREAM)
                .toString();
    }

    public static class ResourceInfo {
        private String name;
        private long size;
        private String type;

        private String hash;

        public ResourceInfo(String name, long size, String type, String hash) {
            this.name = name;
            this.size = size;
            this.type = type;
            this.hash = hash;
        }

        public String getName() {
            return name;
        }

        public long getSize() {
            return size;
        }

        public String getType() {
            return type;
        }

        public String getHash() {
            return hash;
        }
    }
}
