package online.vrscuola.services.log;

import online.vrscuola.entities.log.EventLog;
import online.vrscuola.repositories.log.EventLogRepository;
import online.vrscuola.utilities.Utilities;
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
        EventLog eventLogs = new EventLog();

        String username = (String) session.getAttribute("main_username");
        if (username != null) {
            eventLogs.setUsername(username);
        } else {
            eventLogs.setUsername("anonymous");
        }

        eventLogs.setEvent(evt);
        eventLogs.setEventDate(Instant.now());
        eventLogsRepository.save(eventLogs);

    }
    public void sendLog(HttpSession session, String evt, String note){
        EventLog eventLogs = new EventLog();

        String username = (String) session.getAttribute("username");
        if (username != null) {
            eventLogs.setUsername(username);
        } else {
            eventLogs.setUsername("anonymous");
        }

        eventLogs.setEvent(evt);
        eventLogs.setEventDate(Instant.now());
        eventLogs.setNote(note);
        eventLogsRepository.save(eventLogs);

    }
}

