package it.vrscuola.scuola.entities.devices;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.time.Instant;

@SuppressWarnings("com.haulmont.jpb.LombokDataInspection")
@Entity(name = "connect")
@Data
public class VRDeviceConnectivityEntitie implements Serializable {

    private static final long serialVersionUID = -2449476168160441991L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(unique = true) // Impedisce l'inserimento di valori duplicati a macAddress
    private String macAddress;

    private Instant initDate;

    @Column(unique = true) // Impedisce l'inserimento di valori duplicati a username
    private String username;

    private String note;
    private String connected;
    private String argoment;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "init_id")
    private VRDeviceInitEntitie init;

    // Metodi getter e setter
}
