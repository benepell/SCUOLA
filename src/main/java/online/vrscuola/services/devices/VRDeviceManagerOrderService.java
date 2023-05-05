package online.vrscuola.services.devices;

import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@Service
public class VRDeviceManagerOrderService {
    private String[] alunni;
    private String[] username;
    private Long[] minutes;
    private VRDeviceManageDetailService detailService;
    private ExecutorService executorService;

    public void initOrder(String[] alunni, String[] username, VRDeviceManageDetailService detailService) {
        this.alunni = alunni;
        this.username = username;
        this.detailService = detailService;
        this.minutes = new Long[username.length];
        addMinutesAsync();
    }

    private void addMinutesAsync() {
        executorService = Executors.newFixedThreadPool(Runtime.getRuntime().availableProcessors());

        CompletableFuture<Void>[] futures = new CompletableFuture[username.length];

        for (int i = 0; i < username.length; i++) {
            final int index = i;
            futures[i] = CompletableFuture.supplyAsync(() -> detailService.getMinutes(username[index]), executorService)
                    .thenAccept(min -> minutes[index] = min);
        }

        CompletableFuture.allOf(futures).join();

        executorService.shutdown();

        if(detailService.recordExist() > 2){
            sortArrays();
        }
    }

    private void sortArrays() {
        Integer[] indices = new Integer[username.length];
        for (int i = 0; i < indices.length; i++) {
            indices[i] = i;
        }

        Arrays.sort(indices, (a, b) -> Long.compare(minutes[a] != null ? minutes[a] : 0 , minutes[b] != null ? minutes[b] : 0));

        String[] sortedAlunni = new String[alunni.length];
        String[] sortedUsername = new String[username.length];
        Long[] sortedMinutes = new Long[minutes.length];

        for (int i = 0; i < indices.length; i++) {
            int index = indices[i];
            sortedAlunni[i] = alunni[index];
            sortedUsername[i] = username[index];
            sortedMinutes[i] = minutes[index];
        }

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
