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

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.duckdns.vrscuola.utilities.Constants;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
public class UploadController {

    private static final String UPLOAD_DIR = Constants.PATH_RESOURCE_DIR;

    @PostMapping("/upload")
    public ResponseEntity<String> handleFileUpload(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return ResponseEntity.badRequest().body("Il file è vuoto");
        }

        try {
            String originalFileName = StringUtils.cleanPath(file.getOriginalFilename());
            String fileName = originalFileName;
            Path filePath = Paths.get(UPLOAD_DIR).resolve(fileName);

            if (!Files.exists(Paths.get(UPLOAD_DIR))) {
                Files.createDirectories(Paths.get(UPLOAD_DIR));
            }

            try (BufferedOutputStream outputStream = new BufferedOutputStream(new FileOutputStream(new File(filePath.toString())))) {
                byte[] bytes = file.getBytes();
                outputStream.write(bytes);
            }

            return ResponseEntity.status(HttpStatus.CREATED).body("File caricato con successo: " + fileName);
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Errore durante il caricamento del file: " + e.getMessage());
        }
    }

    @DeleteMapping("/upload/{fileName:.+}")
    public ResponseEntity<String> deleteFile(@PathVariable String fileName) {
        Path filePath = Paths.get(UPLOAD_DIR).resolve(fileName);

        if (!Files.exists(filePath)) {
            return ResponseEntity.notFound().build();
        }

        try {
            Files.delete(filePath);
            return ResponseEntity.ok("File eliminato con successo: " + fileName);
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Errore durante l'eliminazione del file: " + e.getMessage());
        }
    }

}
