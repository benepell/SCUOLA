package online.vrscuola.services;

import online.vrscuola.utilities.Constants;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
            for (File argomentoDirectory : argomentiDirectory.listFiles(file -> file.isDirectory()&& !file.getName().startsWith("-") && !file.getName().matches("^aula\\d+$"))) {
                argomenti.add(argomentoDirectory.getName());
            }
            if (argomentiDirectory.exists() && argomentiDirectory.isDirectory()) {
                File aulaDirectory = findDirectory(argomentiDirectory, aula.toLowerCase());
                if (aulaDirectory != null) {
                    File classeDirectory = findDirectory(aulaDirectory, classe.toLowerCase());
                    if (classeDirectory != null) {
                        File sezioneDirectory = findDirectory(classeDirectory, sezione.toLowerCase());
                        if (sezioneDirectory != null) {
                            argomenti.addAll(getArgomentiFromDirectories(sezioneDirectory)) ;
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
