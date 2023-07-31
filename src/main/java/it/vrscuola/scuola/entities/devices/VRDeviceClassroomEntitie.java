package it.vrscuola.scuola.entities.devices;

import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Entity
@Data
@Table(name = "classrooms", uniqueConstraints = @UniqueConstraint(columnNames = "classroom_number"))
public class VRDeviceClassroomEntitie {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "classroom_number", unique = true, nullable = false)
    private String classroomNumber;

    private int maximumCapacity;
    private String classroomType;
    private boolean morningAvailability;
    private boolean afternoonAvailability;
    private boolean eveningAvailability;
    private boolean enabled;
    
}
