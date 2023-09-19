/**
 * Copyright (c) 2023, Benedetto Pellerito
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

package it.vrscuola.scuola.services.health;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.json.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;


@Service
public class DatabaseHealthCheckService {

    public JSONObject checkDatabase(String url, String username, String password) {
        JSONObject response = new JSONObject();
        try (Connection conn = DriverManager.getConnection(url, username, password)) {
            if (conn.isValid(5)) {
                response.put("status", "ok");
            } else {
                response.put("status", "error");
            }
        } catch (SQLException e) {
            response.put("status", "error");
            response.put("message", e.getMessage());
        }
        return response;
    }

}
