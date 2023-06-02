package online.vrscuola.repositories.log;

import online.vrscuola.entities.log.EventLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import online.vrscuola.entities.log.EventLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.Instant;
import java.util.List;

@SuppressWarnings("unused")
@Repository
public interface EventLogRepository extends JpaRepository<EventLog, Long> {
    List<EventLog> findByUsername(String username);
    List<EventLog> findByEvent(String event);
    List<EventLog> findByEventDate(Instant eventDate);
    List<EventLog> findByUsernameAndEvent(String username, String event);
    List<EventLog> findByUsernameAndEventDate(String username, Instant eventDate);
    List<EventLog> findByEventAndEventDate(String event, Instant eventDate);
    List<EventLog> findByUsernameAndEventAndEventDate(String username, String event, Instant eventDate);
    List<EventLog> findAll();

}