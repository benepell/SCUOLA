package online.vrscuola.services.log;

import online.vrscuola.entities.log.EventLog;
import online.vrscuola.repositories.log.EventLogRepository;
import online.vrscuola.utilities.Utilities;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class EventLogService {

    private static final Logger Log = LogManager.getLogger(EventLogService.class.getName());

    @Autowired
    EventLogRepository eventLogsRepository;

    public void sendLog(Utilities utilities, String username, String evt){
        EventLog eventLogs = new EventLog();
        eventLogs.setUsername(username);
        eventLogs.setEvent(evt);
        eventLogs.setEventDate(utilities.getEpoch());
        eventLogsRepository.save(eventLogs);
    }
}

