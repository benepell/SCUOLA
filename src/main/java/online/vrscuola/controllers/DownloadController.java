package online.vrscuola.controllers;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@RestController
public class DownloadController {

    @GetMapping("/resources/{fileName:.+}")
    public ResponseEntity<Resource> downloadFile(@PathVariable String fileName, HttpServletRequest request) throws IOException, IOException {

        // Ottieni il path assoluto del file da scaricare
        String filePath = "/var/lib/tomcat9/resources/" + fileName;

        // Crea un oggetto Resource che rappresenta il file
        Resource fileResource = new FileSystemResource(filePath);

        // Verifica se il file esiste
        if (!fileResource.exists()) {
            throw new RuntimeException("File non trovato");
        }

        // Imposta il content type della risposta HTTP in base all'estensione del file
        String contentType = request.getServletContext().getMimeType(fileResource.getFile().getPath());

        // Crea la risposta HTTP con il contenuto del file
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileResource.getFilename() + "\"")
                .body(fileResource);
    }
}
