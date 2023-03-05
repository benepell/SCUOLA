package online.vrscuola.services.log;

import online.vrscuola.entities.log.EventLog;
import online.vrscuola.repositories.log.EventLogsRepository;
import online.vrscuola.utilities.Utilities;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class EventLogsService {

    private static final Logger Log = LogManager.getLogger(EventLogsService.class.getName());

    @Autowired
    EventLogsRepository eventLogsRepository;

    public void sendLog(Utilities utilities, String username, String evt){
        EventLog eventLogs = new EventLog();
        eventLogs.setUsername(username);
        eventLogs.setEvent(evt);
        eventLogs.setEventDate(utilities.getEpoch());
        eventLogsRepository.save(eventLogs);
    }
}

