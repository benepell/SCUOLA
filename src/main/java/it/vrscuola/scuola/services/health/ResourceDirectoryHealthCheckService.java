package it.vrscuola.scuola.services.health;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import it.vrscuola.scuola.utilities.Constants;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

@Service
public class ResourceDirectoryHealthCheckService {

    private final Path RESOURCE_DIR = Paths.get(Constants.PATH_RESOURCE_DIR);

    public JSONObject checkResourceDirectory() {
        JSONObject response = new JSONObject();
        if (Files.exists(RESOURCE_DIR) && Files.isDirectory(RESOURCE_DIR) && Files.isReadable(RESOURCE_DIR)) {
            response.put("status", "ok");
        } else {
            response.put("status", "error");
            if (!Files.exists(RESOURCE_DIR)) {
                response.put("message", "Resource directory does not exist");
            } else if (!Files.isDirectory(RESOURCE_DIR)) {
                response.put("message", "Resource directory is not a directory");
            } else if (!Files.isReadable(RESOURCE_DIR)) {
                response.put("message", "Resource directory is not readable");
            }
        }
        return response;
    }

}
