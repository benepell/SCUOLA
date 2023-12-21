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

package org.duckdns.vrscuola.services.health;

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
