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

package org.duckdns.vrscuola;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.duckdns.vrscuola.utilities.Constants;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import java.time.Duration;

@SpringBootApplication
public class Application extends SpringBootServletInitializer {

    @Value("${server.servlet.session.timeout}")
    private String sessionTimeout;

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(Application.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Component
    class DatabaseInitializer {

        @PersistenceContext
        private EntityManager entityManager;

        @EventListener(ApplicationReadyEvent.class)
        @Transactional
        public void initializeDatabase() {
            if (Constants.DB_CLEAN_STARTUP) {
                String sqlFormattedTimeout = convertToSqlInterval(sessionTimeout);
                String deleteQuery = String.format("DELETE FROM custom_session WHERE sessionDate < NOW() - INTERVAL %s", sqlFormattedTimeout);
                entityManager.createNativeQuery(deleteQuery).executeUpdate();
                entityManager.createNativeQuery("DELETE FROM connect").executeUpdate();
                entityManager.createNativeQuery("UPDATE init SET eraOnline = null").executeUpdate();
            }

        }

        private String convertToSqlInterval(String sessionTimeout) {
            // Initialize variables to hold the amounts of time
            long hours = 0;
            long minutes = 0;

            // Try to extract hours and minutes from the sessionTimeout string
            try {
                if (sessionTimeout.endsWith("m")) {
                    minutes = Long.parseLong(sessionTimeout.replace("m", ""));
                } else if (sessionTimeout.endsWith("h")) {
                    hours = Long.parseLong(sessionTimeout.replace("h", ""));
                    minutes = hours * 60; // Convert hours to minutes
                } else {
                    // Assume default or log an error/warning if the format is unrecognized
                    // For simplicity, defaulting to 30 minutes here
                    minutes = 30;
                }
            } catch (NumberFormatException e) {
                // Log error or use a default value
                minutes = 30; // Default to 30 minutes if parsing fails
            }

            return String.format("%d MINUTE", minutes);
        }
    }
}
