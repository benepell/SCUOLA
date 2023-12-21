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

package org.duckdns.vrscuola.repositories.log;

import org.duckdns.vrscuola.entities.log.EventLogEntitie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.Instant;
import java.util.List;
@Repository
public interface EventLogRepository extends JpaRepository<EventLogEntitie, Long> {
    List<EventLogEntitie> findByUsername(String username);
    List<EventLogEntitie> findByEvent(String event);
    List<EventLogEntitie> findByEventDate(Instant eventDate);
    List<EventLogEntitie> findByUsernameAndEvent(String username, String event);
    List<EventLogEntitie> findByUsernameAndEventDate(String username, Instant eventDate);
    List<EventLogEntitie> findByEventAndEventDate(String event, Instant eventDate);
    List<EventLogEntitie> findByUsernameAndEventAndEventDate(String username, String event, Instant eventDate);
    List<EventLogEntitie> findAll();

}