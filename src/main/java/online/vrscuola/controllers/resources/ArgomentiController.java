package online.vrscuola.controllers.resources;

import online.vrscuola.utilities.Constants;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ArgomentiController {

    @GetMapping(value = "/argomenti/all", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<String>> getArgomentiAll(
            @RequestParam(name = "aula", defaultValue = "aula01") String aula,
            @RequestParam(name = "classe", defaultValue = "") String classe,
            @RequestParam(name = "sezione", defaultValue = "") String sezione) {
        try {
            String basePath = Constants.PATH_RESOURCE_DIR;
            List<String> argomenti = new ArrayList<>();
            File argomentiDirectory = new File(basePath, "ARGOMENTI");
            for (File argomentoDirectory : argomentiDirectory.listFiles(file -> file.isDirectory() && !file.getName().matches("^aula\\d+$"))) {
                argomenti.add(argomentoDirectory.getName());
            }
            if (argomentiDirectory.exists() && argomentiDirectory.isDirectory()) {
                File aulaDirectory = findDirectory(argomentiDirectory, aula);
                if (aulaDirectory != null) {
                    File classeDirectory = findDirectory(aulaDirectory, classe);
                    if (classeDirectory != null) {
                        File sezioneDirectory = findDirectory(classeDirectory, sezione);
                        if (sezioneDirectory != null) {
                            argomenti.addAll(getArgomentiFromDirectories(sezioneDirectory)) ;
                            return ResponseEntity.ok(argomenti);
                        }
                    }
                }
            }
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
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
                argomenti.add(argomentoDirectory.getName());
            }
        }
        return argomenti;
    }
}
