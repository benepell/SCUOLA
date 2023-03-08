package online.vrscuola.controllers.health;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.json.JSONObject;

public class ResourceDirectoryHealthCheck {

    private static final Path RESOURCE_DIR = Paths.get("/var/lib/tomcat9/resources");

    public static JSONObject checkResourceDirectory() {
        JSONObject response = new JSONObject();
        if (Files.exists(RESOURCE_DIR) && Files.isDirectory(RESOURCE_DIR) && Files.isReadable(RESOURCE_DIR)) {
            response.put("status", "ok");
            File file = RESOURCE_DIR.toFile();
            long totalSpace = file.getTotalSpace();
            long freeSpace = file.getFreeSpace();
            long usableSpace = file.getUsableSpace();
            double freeSpacePercent = ((double)freeSpace / totalSpace) * 100;
            response.put("usable_space", usableSpace);
            response.put("free_space_percent", freeSpacePercent);
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
