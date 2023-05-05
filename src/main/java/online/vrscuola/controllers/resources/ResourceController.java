package online.vrscuola.controllers.resources;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import online.vrscuola.utilities.Constants;
import online.vrscuola.utilities.FileUtils;
import org.apache.http.impl.client.RedirectLocations;
import org.springframework.http.MediaType;
import org.springframework.http.MediaTypeFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.reactive.result.view.RedirectView;

@RestController
public class ResourceController {

    private static final Path RESOURCE_DIR = Paths.get(Constants.PATH_RESOURCE_DIR);

    @GetMapping(value = "/resources/files", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<ResourceInfo>> getResourcesFiles() {
        List<ResourceInfo> resources = new ArrayList<>();
        try {
            File directory = RESOURCE_DIR.toFile();
            if (directory.isDirectory()) {
                File[] files = directory.listFiles();
                if (files != null) {
                    List<Thread> threads = new ArrayList<>();
                    for (File file : files) {
                        if(!file.getAbsolutePath().contains(Constants.RESOURCE_TRASH) &&
                                !file.getAbsolutePath().contains(Constants.RESOURCE_TMB)) {
                            Thread thread = new Thread(() -> {
                                String hash = FileUtils.calculateHash(file);
                                if (file.isFile()) {
                                    ResourceInfo resource = new ResourceInfo(file.getName(), file.length(), getMimeType(file), hash, directory.getPath());
                                    synchronized (resources) {
                                        resources.add(resource);
                                    }
                                }
                            });
                            threads.add(thread);
                            thread.start();
                        }
                    }
                    for (Thread thread : threads) {
                        thread.join();
                    }
                }
            }
        } catch (Exception e) {
            // Gestione dell'eccezione
        }
        return ResponseEntity.ok(resources);
    }

    @GetMapping(value = "/resources/all", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<ResourceInfo>> getAllResources() {
        List<ResourceInfo> resources = new ArrayList<>();
        try {
            File directory = RESOURCE_DIR.toFile();
            if (directory.isDirectory()) {
                File[] files = directory.listFiles();
                if (files != null) {
                    // Creazione del pool di thread
                    ExecutorService executorService = Executors.newFixedThreadPool(Runtime.getRuntime().availableProcessors());

                    List<Callable<List<ResourceInfo>>> tasks = new ArrayList<>();
                    for (File file : files) {
                        if(!file.getAbsolutePath().contains(Constants.RESOURCE_TRASH) &&
                                !file.getAbsolutePath().contains(Constants.RESOURCE_TMB)) {
                            Callable<List<ResourceInfo>> task = () -> {
                                List<ResourceInfo> results = new ArrayList<>();
                                String hash = FileUtils.calculateHash(file);
                                if (file.isFile()) {
                                    results.add(new ResourceInfo(file.getName(), file.length(), getMimeType(file), hash, directory.getPath()));
                                } else if (file.isDirectory()) {
                                    results.addAll(getAllResourcesInDirectory(file));
                                }
                                return results;
                            };
                            tasks.add(task);
                        }
                    }
                    // Esecuzione dei task in parallelo
                    List<Future<List<ResourceInfo>>> futures = executorService.invokeAll(tasks);
                    for (Future<List<ResourceInfo>> future : futures) {
                        resources.addAll(future.get());
                    }
                    // Shutdown del pool di thread
                    executorService.shutdown();
                }
            }
        } catch (Exception e) {
            // Gestione dell'eccezione
        }
        return ResponseEntity.ok(resources);
    }

    private List<ResourceInfo> getAllResourcesInDirectory(File directory) {
        List<ResourceInfo> resources = new ArrayList<>();
        try {
            if (directory.isDirectory()) {
                File[] files = directory.listFiles();
                if (files != null) {
                    // Creazione del pool di thread
                    ExecutorService executorService = Executors.newFixedThreadPool(Runtime.getRuntime().availableProcessors());

                    List<Callable<List<ResourceInfo>>> tasks = new ArrayList<>();
                    for (File file : files) {
                        if(!file.getAbsolutePath().contains(Constants.RESOURCE_TRASH) &&
                                !file.getAbsolutePath().contains(Constants.RESOURCE_TMB)) {
                            Callable<List<ResourceInfo>> task = () -> {
                                List<ResourceInfo> results = new ArrayList<>();
                                String hash = FileUtils.calculateHash(file);
                                if (file.isFile()) {
                                    results.add(new ResourceInfo(file.getName(), file.length(), getMimeType(file), hash, directory.getPath()));
                                } else if (file.isDirectory()) {
                                    results.addAll(getAllResourcesInDirectory(file));
                                }
                                return results;
                            };
                            tasks.add(task);
                        }
                    }
                    // Esecuzione dei task in parallelo
                    List<Future<List<ResourceInfo>>> futures = executorService.invokeAll(tasks);
                    for (Future<List<ResourceInfo>> future : futures) {
                        resources.addAll(future.get());
                    }
                    // Shutdown del pool di thread
                    executorService.shutdown();
                }
            }
        } catch (Exception e) {
            // Gestione dell'eccezione
        }
        return resources;
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

        private String dir;

        public ResourceInfo(String name, long size, String type, String hash, String dir) {
            this.name = name;
            this.size = size;
            this.type = type;
            this.hash = hash;
            this.dir = dir;
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

        public String getDir() {
            return dir;
        }
    }
}
