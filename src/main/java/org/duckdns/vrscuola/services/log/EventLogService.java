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

package org.duckdns.vrscuola.services.log;

import org.duckdns.vrscuola.entities.log.EventLogEntitie;
import org.duckdns.vrscuola.repositories.log.EventLogRepository;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.time.Instant;


@Service
public class EventLogService {

    private static final Logger Log = LogManager.getLogger(EventLogService.class.getName());

    @Autowired
    EventLogRepository eventLogsRepository;

    public void sendLog(HttpSession session, String evt){
        EventLogEntitie eventLogsEntitie = new EventLogEntitie();

        String username = (String) session.getAttribute("main_username");
        if (username != null) {
            eventLogsEntitie.setUsername(username);
        } else {
            eventLogsEntitie.setUsername("anonymous");
        }

        eventLogsEntitie.setEvent(evt);
        eventLogsEntitie.setEventDate(Instant.now());
        eventLogsRepository.save(eventLogsEntitie);

    }
    public void sendLog(HttpSession session, String evt, String note){
        EventLogEntitie eventLogsEntitie = new EventLogEntitie();

        String username = (String) session.getAttribute("username");
        if (username != null) {
            eventLogsEntitie.setUsername(username);
        } else {
            eventLogsEntitie.setUsername("anonymous");
        }

        eventLogsEntitie.setEvent(evt);
        eventLogsEntitie.setEventDate(Instant.now());
        eventLogsEntitie.setNote(note);
        eventLogsRepository.save(eventLogsEntitie);

    }
}

