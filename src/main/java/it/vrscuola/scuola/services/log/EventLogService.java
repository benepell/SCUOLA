package it.vrscuola.scuola.services.log;

import it.vrscuola.scuola.entities.log.EventLogEntitie;
import it.vrscuola.scuola.repositories.log.EventLogRepository;
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

