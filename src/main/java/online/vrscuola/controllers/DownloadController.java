package online.vrscuola.controllers;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.concurrent.TimeUnit;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

@RestController
public class DownloadController {

    private static final Path RESOURCE_DIR = Paths.get("/var/lib/tomcat9/resources");
    private static final CacheControl CACHE_CONTROL = CacheControl.maxAge(10, TimeUnit.MINUTES);

    @GetMapping("/resources/{fileName:.+}")
    @Cacheable("fileContentCache")
    public ResponseEntity<byte[]> downloadFile(@PathVariable String fileName) throws IOException {
        Path filePath = RESOURCE_DIR.resolve(fileName);

        if (!Files.exists(filePath)) {
            return ResponseEntity.notFound().build();
        }

        MediaType mediaType = MediaTypeFactory.getMediaType(filePath.toString())
                .orElse(MediaType.APPLICATION_OCTET_STREAM);

        byte[] fileContent = Files.readAllBytes(filePath);
        long contentLength = Files.size(filePath);

        return ResponseEntity.ok()
                .cacheControl(CACHE_CONTROL)
                .contentType(mediaType)
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileName + "\"")
                .header(HttpHeaders.CONTENT_LENGTH, Long.toString(contentLength))
                .body(fileContent);
    }

    @RestControllerAdvice
    public static class ExceptionHandlerAdvice {

        @ExceptionHandler(IOException.class)
        @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
        public String handleIOException(IOException e) {
            return "Errore durante il download del file: " + e.getMessage();
        }

        @ExceptionHandler(Exception.class)
        @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
        public String handleException(Exception e) {
            return "Errore generico durante il download del file: " + e.getMessage();
        }
    }
}
