package it.vrscuola.scuola.repositories.devices;

import it.vrscuola.scuola.entities.devices.VRDeviceClassroomEntitie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VRDeviceClassroomRepository extends JpaRepository<VRDeviceClassroomEntitie, Long> {
}
