/**
 * Copyright (c) 2023, Benedetto Pellerito
 * Email: benedettopellerito@gmail.com
 * GitHub: https://github.com/benepell
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.duckdns.vrscuola.services.devices;

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

        if (detailService.recordExist() > 2) {
            sortArrays();
        }
    }

    private void sortArrays() {
        Integer[] indices = new Integer[username.length];
        for (int i = 0; i < indices.length; i++) {
            indices[i] = i;
        }

        Arrays.sort(indices, (a, b) -> Long.compare(minutes[a] != null ? minutes[a] : 0, minutes[b] != null ? minutes[b] : 0));

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
