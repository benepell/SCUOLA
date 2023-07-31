package it.vrscuola.scuola.entities.devices;

import lombok.Data;

import javax.persistence.*;
import java.time.Instant;
import java.util.List;
@Entity(name = "init")
@Data
public class VRDeviceInitEntitie {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(unique = true) // Impedisce l'inserimento di valori duplicati
    private String macAddress;

    private String label;
    private Instant initDate;
    private String note;
    private String code;

    @Column(columnDefinition = "INTEGER DEFAULT 100")
    private Integer batteryLevel;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "classroom_id", referencedColumnName = "id", insertable = false, updatable = false)
    private VRDeviceClassroomEntitie classroom_id;


    @OneToMany(mappedBy = "init", fetch = FetchType.LAZY)
    private List<VRDeviceConnectivityEntitie> connectivities;

}
