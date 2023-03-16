package online.vrscuola.entities.init;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.time.Instant;

@SuppressWarnings("com.haulmont.jpb.LombokDataInspection")
@Entity(name = "init")
@Data
public class Init {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String macAddress;
    private Instant initDate;

    private String note;
}