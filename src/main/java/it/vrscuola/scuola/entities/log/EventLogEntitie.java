package it.vrscuola.scuola.entities.log;


import lombok.Data;
import javax.persistence.*;
import java.io.Serializable;
import java.time.Instant;

@SuppressWarnings("com.haulmont.jpb.LombokDataInspection")
@Entity(name = "event_logs")
@Data
public class EventLogEntitie  implements Serializable {

    private static final long serialVersionUID = 8887469343276838988L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String username;

    private String event;

    private Instant eventDate;

    private String note;

}