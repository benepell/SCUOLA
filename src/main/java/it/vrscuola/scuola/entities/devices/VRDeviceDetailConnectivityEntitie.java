package it.vrscuola.scuola.entities.devices;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.time.Instant;

@Entity(name = "detailconnect")
@Data
public class VRDeviceDetailConnectivityEntitie {
    @Id
    private String username;
    private Instant startDate;
    private Instant endDate;
    private long minutes;

}
