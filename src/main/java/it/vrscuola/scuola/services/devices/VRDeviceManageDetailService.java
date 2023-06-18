package it.vrscuola.scuola.services.devices;

import it.vrscuola.scuola.repositories.devices.VRDeviceDetailConnectivityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;

@Service
public class VRDeviceManageDetailService {

    @Autowired
    VRDeviceDetailConnectivityRepository dRepository;

    public boolean startTime(String username) {
        // controlla se username  e' presente
        if (username == null) {
            return false;
        }

        boolean updating = false;

        // controlla se il visore e' gia' associato
        if (dRepository.usernameExist(username)) {
            updating = true;
        }
        // reinit dei valori start e end date
      //  dRepository.resetDate(username);

        if (updating) {
            dRepository.updateStartDate(Instant.now(),username);
        } else {
            dRepository.insertStartDate(username);
        }

        return true;
    }

    public boolean endTime(String username) {
        // controlla se username  e' presente
        if (username == null) {
            return false;
        }
        // record deve esistere solo update
        dRepository.updateEndDate(Instant.now(),username);

        // aggiunge i minuti al record
        addMinutes(username);
        return true;
    }

    public Long getMinutes(String username) {
        return username != null ? dRepository.findMinutes(username) : null;
    }

    public Long recordExist() {
        return dRepository.countRecord();
    }

    public void resetDate(String username) {
        // controlla se username  e' presente
        if (username == null) {
            return;
        }
        // record deve esistere solo update
        dRepository.resetDate(username);
    }

    public void resetAll(String username) {
        // controlla se username  e' presente
        if (username == null) {
            return;
        }
        // record deve esistere solo update
        dRepository.resetAll(username);
    }


    private void addMinutes(String username) {

        List<Object[]> results = dRepository.findValues(username);

        for (Object[] result : results) {
            Instant startDate = (Instant) result[0];
            Instant endDate = (Instant) result[1];
            Long minutes = (Long) result[2];
            Long seconds = endDate.getEpochSecond() - startDate.getEpochSecond();
            minutes += seconds > 0 ? (seconds / 60 ): 0;
            dRepository.updateMinutes(minutes, username);
        }

    }

}
