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

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.*;
import java.util.stream.Collectors;

import org.duckdns.vrscuola.models.DeviceInfo;
import org.duckdns.vrscuola.services.devices.VRDeviceConnectivityServiceImpl;
import org.duckdns.vrscuola.utilities.Constants;
import org.duckdns.vrscuola.utilities.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.MediaTypeFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ResourceController {

    @Value("${school.resource.base}")
    private String resBase;

    @Value("${health.datasource.website.risorse}")
    private String resResources;

    @Autowired
    private ExecutorService taskExecutor;

    @Autowired
    private VRDeviceConnectivityServiceImpl cService;
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
                        if (!file.getAbsolutePath().contains(Constants.RESOURCE_TRASH) &&
                                !file.getAbsolutePath().contains(Constants.RESOURCE_TMB)) {
                            Thread thread = new Thread(() -> {
                                String hash = FileUtils.calculateHash(file);
                                if (file.isFile()) {
                                    ResourceInfo resource = new ResourceInfo(file.getName(), file.length(), getMimeType(file), hash, directory.getPath(),
                                            getUrlFromDir(directory.getPath(), file.getName()));
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
                        if (!file.getAbsolutePath().contains(Constants.RESOURCE_TRASH) &&
                                !file.getAbsolutePath().contains(Constants.RESOURCE_TMB)) {
                            Callable<List<ResourceInfo>> task = () -> {
                                List<ResourceInfo> results = new ArrayList<>();
                                String hash = FileUtils.calculateHash(file);
                                if (file.isFile()) {
                                    results.add(new ResourceInfo(file.getName(), file.length(), getMimeType(file), hash, directory.getPath(),
                                            getUrlFromDir(directory.getPath(), file.getName())));
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

    @GetMapping(value = "/resources/arg-filter", produces = "application/json")
    public CompletableFuture<ResponseEntity<?>> getFilterResources(
            @RequestParam(name = "macAddress", defaultValue = "") String mac
    ) {
        return CompletableFuture.supplyAsync(() -> {
            List<DeviceInfo> dev = cService.getInfo(mac);
            List<ResourceInfo> allResources = getAllResources().getBody();
            String pathToFilter = dev.size() > 0 ?
                    ("/ARGOMENTI/" + dev.get(0).getLab() + "/" + dev.get(0).getClasse() + "/" + dev.get(0).getSezione() + "/" + dev.get(0).getArg()) : "";
            List<ResourceInfo> filteredResources = filterResourcesByPath(allResources, pathToFilter);

            Map<String, Object> argsMap = new HashMap<>();
            argsMap.put("message", filteredResources);

            return ResponseEntity.ok(argsMap);

        }, taskExecutor);
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
                        if (!file.getAbsolutePath().contains(Constants.RESOURCE_TRASH) &&
                                !file.getAbsolutePath().contains(Constants.RESOURCE_TMB)) {
                            Callable<List<ResourceInfo>> task = () -> {
                                List<ResourceInfo> results = new ArrayList<>();
                                String hash = FileUtils.calculateHash(file);
                                if (file.isFile()) {
                                    results.add(new ResourceInfo(file.getName(), file.length(), getMimeType(file), hash,
                                            directory.getPath(), getUrlFromDir(directory.getPath(), file.getName())));
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
        private String url;


        public ResourceInfo(String name, long size, String type, String hash, String dir, String url) {
            this.name = name;
            this.size = size;
            this.type = type;
            this.hash = hash;
            this.dir = dir;
            this.url = url;
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

        public String getUrl() {
            return url;
        }
    }

    private String getUrlFromDir(String dir, String name) {
        return dir != null ? dir.replaceAll(resBase.substring(0, resBase.length() - 1 - "/files".length()), resResources) + "/" + name : "";
    }

    private List<ResourceInfo> filterResourcesByPath(List<ResourceInfo> resources, String path) {
        return resources.stream()
                .filter(resource -> resource.getDir().contains(path))
                .collect(Collectors.toList());
    }
}
