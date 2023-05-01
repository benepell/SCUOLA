package online.vrscuola.services.devices;

import org.springframework.stereotype.Service;

import java.util.Arrays;

@Service
public class VRDeviceManagerOrderService {
    private String[] alunni;
    private String[] username;
    private Long[] minutes;
    private VRDeviceManageDetailService detailService;

    public void initOrder(String[] alunni, String[] username, VRDeviceManageDetailService detailService) {
        this.alunni = alunni;
        this.username = username;
        this.detailService = detailService;
        this.minutes = new Long[alunni.length];
        addMinutes();
    }

    private void addMinutes() {
        for (int i = 0; i < this.username.length; i++) {
            minutes[i] = detailService.getMinutes(username[i]);
        }

        // Creazione di un array di indici ordinati
        Integer[] indices = new Integer[minutes.length];
        for (int i = 0; i < indices.length; i++) {
            indices[i] = i;
        }

        // Ordinamento degli indici in base ai valori dei minuti
        Arrays.sort(indices, (a, b) -> Long.compare(minutes[a], minutes[b]));

        // Utilizzo degli indici ordinati per riordinare gli array
        String[] sortedAlunni = new String[alunni.length];
        String[] sortedUsername = new String[username.length];
        Long[] sortedMinutes = new Long[minutes.length];

        for (int i = 0; i < indices.length; i++) {
            int index = indices[i];
            sortedAlunni[i] = alunni[index];
            sortedUsername[i] = username[index];
            sortedMinutes[i] = minutes[index];
        }

        // Aggiornamento degli array originali con gli array ordinati
        alunni = sortedAlunni;
        username = sortedUsername;
        minutes = sortedMinutes;
    }

    public String[] getAlunni() {
        return alunni;
    }

    public String[] getUsername() {
        return username;
    }

    public Long[] getMinutes() {
        return minutes;
    }
}
