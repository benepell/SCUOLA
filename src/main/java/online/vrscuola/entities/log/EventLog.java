package online.vrscuola.entities.log;


import lombok.Data;
import javax.persistence.*;
import java.time.Instant;

@SuppressWarnings("com.haulmont.jpb.LombokDataInspection")
@Entity(name = "event_logs")
@Data
public class EventLog {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String username;

    private String event;

    private Instant eventDate;

}