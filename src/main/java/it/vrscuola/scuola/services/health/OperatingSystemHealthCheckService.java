package it.vrscuola.scuola.services.health;

import org.json.JSONObject;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

@Service
public class OperatingSystemHealthCheckService {

    public static JSONObject checkOperatingSystem() {
        JSONObject response = new JSONObject();
        try {
            // get available memory
            Runtime runtime = Runtime.getRuntime();
            long freeMemory = runtime.freeMemory();
            long maxMemory = runtime.maxMemory();
            long totalMemory = runtime.totalMemory();
            response.put("free_memory", freeMemory);
            response.put("max_memory", maxMemory);
            response.put("total_memory", totalMemory);

            // get disk space
            Process process = Runtime.getRuntime().exec("df -h /");
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.contains("/")) {
                    String[] parts = line.split("\\s+");
                    response.put("disk_space_used", parts[2]);
                    response.put("disk_space_available", parts[3]);
                    response.put("disk_space_percent", parts[4]);
                    break;
                }
            }

            // get system load
            process = Runtime.getRuntime().exec("cat /proc/loadavg");
            reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            line = reader.readLine();
            if (line != null) {
                String[] loadAvg = line.split("\\s+");
                response.put("system_load_1_min", loadAvg[0]);
                response.put("system_load_5_min", loadAvg[1]);
                response.put("system_load_15_min", loadAvg[2]);
            }

            response.put("status", "ok");
        } catch (IOException e) {
            response.put("status", "error");
            response.put("message", "Error checking operating system: " + e.getMessage());
        }
        return response;
    }

}
