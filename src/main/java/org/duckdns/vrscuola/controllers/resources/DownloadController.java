/**
 * Copyright (c) 2023, Benedetto Pellerito
 * Email: benedettopellerito@gmail.com
 * GitHub: https://github.com/benepell
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.duckdns.vrscuola.controllers.resources;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.concurrent.TimeUnit;

import org.duckdns.vrscuola.utilities.Constants;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

@RestController
public class DownloadController {

    private static final Path RESOURCE_DIR = Paths.get(Constants.PATH_RESOURCE_DIR);
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

    /*
    @RestControllerAdvice
    public static class ExceptionHandlerAdvice {

        @ExceptionHandler(IOException.class)
        @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
        public String handleIOException(IOException e) {
            return "Errore durante il download del file: " + e.getMessage();
        }

    }
    */
}
