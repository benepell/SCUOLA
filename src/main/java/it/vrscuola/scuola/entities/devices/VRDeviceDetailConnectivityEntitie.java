package it.vrscuola.scuola.entities.devices;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.io.Serializable;
import java.time.Instant;

@Entity(name = "detailconnect")
@Data
public class VRDeviceDetailConnectivityEntitie implements Serializable {

    private static final long serialVersionUID = -6059344138919853465L;
    @Id
    private String username;
    private Instant startDate;
    private Instant endDate;
    private long minutes;

}
