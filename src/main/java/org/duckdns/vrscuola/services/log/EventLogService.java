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

package org.duckdns.vrscuola.services.log;

import jakarta.servlet.http.HttpSession;
import org.duckdns.vrscuola.entities.log.EventLogEntitie;
import org.duckdns.vrscuola.repositories.log.EventLogRepository;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.duckdns.vrscuola.services.config.SessionDBService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Instant;


@Service
public class EventLogService {

    private static final Logger Log = LogManager.getLogger(EventLogService.class.getName());

    @Autowired
    EventLogRepository eventLogsRepository;

    @Autowired
    SessionDBService sService;

    public void sendLog(SessionDBService se, String evt) {

        try {
            EventLogEntitie eventLogsEntitie = new EventLogEntitie();

            String username = sService.getAttribute("main_username", String.class) != null ? (String) sService.getAttribute("main_username", String.class) : null;
            if (username != null) {
                eventLogsEntitie.setUsername(username);
            }

            eventLogsEntitie.setEvent(evt);
            eventLogsEntitie.setEventDate(Instant.now());
            eventLogsRepository.save(eventLogsEntitie);

        } catch (Exception e) {
        }

    }

    public void sendLog(SessionDBService se, String evt, String note) {

        try {
            EventLogEntitie eventLogsEntitie = new EventLogEntitie();

            String username = sService.getAttribute("username", String.class) != null ? (String) sService.getAttribute("username", String.class) : null;

            if (username != null) {
                eventLogsEntitie.setUsername(username);
            }

            eventLogsEntitie.setEvent(evt);
            eventLogsEntitie.setEventDate(Instant.now());
            eventLogsEntitie.setNote(note);
            eventLogsRepository.save(eventLogsEntitie);

        } catch (Exception e) {
        }

    }
}

