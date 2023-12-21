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

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.duckdns.vrscuola.utilities.Constants;
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
