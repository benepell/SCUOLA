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

package org.duckdns.vrscuola.services;

import org.duckdns.vrscuola.utilities.Constants;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

@Service
public class ArgomentiDirService {
    public List<String> getArgomentiAll(String aula, String classe, String sezione) {
        String basePath = Constants.PATH_RESOURCE_DIR;
        List<String> argomenti = new ArrayList<>();
        File argomentiDirectory = new File(basePath, "ARGOMENTI");
        if (argomentiDirectory != null && argomentiDirectory.isDirectory()) {
            for (File argomentoDirectory : argomentiDirectory.listFiles(file -> file.isDirectory() && !file.getName().startsWith("-") && !file.getName().matches("^lab\\d+$"))) {
                argomenti.add(argomentoDirectory.getName());
            }
        }
        if (argomentiDirectory.exists() && argomentiDirectory.isDirectory()) {
            File aulaDirectory = findDirectory(argomentiDirectory, aula.toLowerCase());
            if (aulaDirectory != null) {
                File classeDirectory = findDirectory(aulaDirectory, classe.toLowerCase());
                if (classeDirectory != null) {
                    File sezioneDirectory = findDirectory(classeDirectory, sezione.toLowerCase());
                    if (sezioneDirectory != null) {
                        argomenti.addAll(getArgomentiFromDirectories(sezioneDirectory));
                        return argomenti;
                    }
                }
            }
        }

        return argomenti;
    }

    private File findDirectory(File directory, String name) {
        File[] directories = directory.listFiles(file -> file.isDirectory() && !file.getName().startsWith("-") && file.getName().equals(name));
        if (directories != null && directories.length > 0) {
            return directories[0];
        } else {
            for (File subdirectory : directory.listFiles(file -> file.isDirectory() && !file.getName().startsWith("-"))) {
                File foundDirectory = findDirectory(subdirectory, name);
                if (foundDirectory != null) {
                    return foundDirectory;
                }
            }
        }
        return null;
    }

    private List<String> getArgomentiFromDirectories(File directory) {
        List<String> argomenti = new ArrayList<>();
        File[] argomentiDirectories = directory.listFiles(file -> file.isDirectory() && !file.getName().startsWith("-"));
        if (argomentiDirectories != null) {
            for (File argomentoDirectory : argomentiDirectories) {
                if (argomentoDirectory.isDirectory() && !argomentoDirectory.getName().startsWith("-")) {
                    argomenti.add(argomentoDirectory.getName());
                }
            }
        }
        return argomenti;
    }
}
