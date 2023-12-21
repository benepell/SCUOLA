/**
 * Copyright (c) 2023, Benedetto Pellerito
 * Email: benedettopellerito@gmail.com
 * GitHub: https://github.com/benepell
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.duckdns.vrscuola.services;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;

@Service
public class ProcessService {

    @Value("${school.setup.pathcmdsh}")
    private String pathcmd;

    @Value("${school.setup.path}")
    private String path;

    public void initProcess(String passwordRoot) {
        if (passwordRoot.isEmpty()) {
            throw new RuntimeException("password vuota");
        }

        try {
            // Esegue il comando dos2unix sul file cmd per rimuovere eventuali caratteri di ritorno a capo Windows
            ProcessBuilder dos2unixBuilder = new ProcessBuilder("dos2unix", pathcmd);
            dos2unixBuilder.directory(new File(path));
            Process dos2unixProcess = dos2unixBuilder.start();
            int dos2unixExitCode = dos2unixProcess.waitFor();

            if (dos2unixExitCode != 0) {
                throw new RuntimeException("dos2unix ha terminato con un codice di uscita non nullo: " + dos2unixExitCode);
            }

            // Imposta il permesso di esecuzione per l'utente corrente sul file cmd
            ProcessBuilder chmodBuilder = new ProcessBuilder("chmod", "+x", pathcmd);
            chmodBuilder.directory(new File(path));
            Process chmodProcess = chmodBuilder.start();
            int chmodExitCode = chmodProcess.waitFor();

            if (chmodExitCode != 0) {
                throw new RuntimeException("chmod ha terminato con un codice di uscita non nullo: " + chmodExitCode);
            }

            // Avvia il processo con il comando sudo
            ProcessBuilder processBuilder = new ProcessBuilder("sudo", "-u", "root", "-p", passwordRoot, pathcmd);
            processBuilder.directory(new File(path));
            Process process = processBuilder.start();
            int exitCode = process.waitFor();

            if (exitCode != 0) {
                throw new RuntimeException("Il comando e' uscito con codice di errore: " + exitCode);
            }
        } catch (IOException e) {
            throw new RuntimeException("Errore durante l'avvio del processo", e);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new RuntimeException("Il thread è stato interrotto", e);
        }
    }


}
