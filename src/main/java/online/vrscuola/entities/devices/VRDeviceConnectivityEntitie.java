package online.vrscuola.entities.devices;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.time.Instant;

@SuppressWarnings("com.haulmont.jpb.LombokDataInspection")
@Entity(name = "connect")
@Data
public class VRDeviceConnectivityEntitie {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String macAddress;
    private Instant initDate;
    private String username;
    private String note;
    private String connected;
    private String argoment;

}