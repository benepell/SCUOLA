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

package org.duckdns.vrscuola.services;

import jakarta.servlet.http.HttpSession;
import org.duckdns.vrscuola.repositories.devices.VRDeviceConnectivityRepository;
import org.duckdns.vrscuola.repositories.devices.VRDeviceInitRepository;
import org.duckdns.vrscuola.services.devices.VRDeviceInitServiceImpl;
import org.duckdns.vrscuola.services.devices.VRDeviceManageDetailService;
import org.duckdns.vrscuola.utilities.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class StudentService {

    @Autowired
    VRDeviceInitRepository iRepository;

    @Autowired
    VRDeviceConnectivityRepository cRepository;

    @Autowired
    VRDeviceInitServiceImpl initService;

    private List<String> allievi;
    private List<String> visori;

    private String classroom;

    public void init(List<String> allievi, List<String> visori, String classroom) {
        this.allievi = allievi;

        if (Constants.ENABLED_ONLINE) {
            List<String> visoriOnline = initService.strOnline(visori, classroom);
            this.visori = visoriOnline;
        } else {
            this.visori = visori;
        }

        this.classroom = classroom;
    }

    public Optional<String> setVisore(String allievo, HttpSession session) {
        if (!allievi.contains(allievo)) {
            return Optional.empty(); // student not found
        }

        Map<String, String> visoreAllievo = (Map<String, String>) session.getAttribute("visoreAllievo");
        if (visoreAllievo == null) {
            visoreAllievo = new HashMap<>();
        }

        Map<String, String> finalVisoreAllievo = visoreAllievo;
        Optional<String> visore = visori.stream().filter(v -> !finalVisoreAllievo.containsValue(v)).findFirst();

        if (visore.isPresent()) {
            visoreAllievo.put(allievo, visore.get());
            session.setAttribute("visoreAllievo", visoreAllievo);
            return visore;
        } else {
            return Optional.empty(); // no available headset
        }
    }

    public boolean freeVisore(String allievo, HttpSession session) {
        Map<String, String> visoreAllievo = (Map<String, String>) session.getAttribute("visoreAllievo");
        if (visoreAllievo == null) {
            return false;
        }
        return visoreAllievo.remove(allievo) != null;
    }

    public Optional<String> getVisore(String allievo, HttpSession session) {
        Map<String, String> visoreAllievo = (Map<String, String>) session.getAttribute("visoreAllievo");
        if (visoreAllievo == null) {
            return Optional.empty();
        }
        return Optional.ofNullable(visoreAllievo.get(allievo));
    }

    public String getNumVisori() {
        return visori != null ? String.valueOf(visori.size()) : "";
    }

    public String getNumVisoriOccupati(HttpSession session) {
        Map<String, String> visoreAllievo = (Map<String, String>) session.getAttribute("visoreAllievo");
        return visoreAllievo != null ? String.valueOf(visoreAllievo.size()) : "";
    }

    public String getNumVisoriLiberi(HttpSession session) {
        Map<String, String> visoreAllievo = new HashMap<>();
        visoreAllievo = (Map<String, String>) session.getAttribute("visoreAllievo");
        if (visoreAllievo == null) {
            visoreAllievo = new HashMap<>();
        }
        return visori != null && visoreAllievo != null ? String.valueOf(visori.size() - visoreAllievo.size()) : "";
    }

    public void cleanVisori(HttpSession session) {
        if (session != null && session.getAttribute("visoreAllievo") != null) {
            session.removeAttribute("visoreAllievo");
        }
    }

    // primo visore
    public String getFirstVisore() {
        return visori.stream().findFirst().get();
    }

    public String dbVisori(String username) {
        return iRepository.findLabelByUsername(username, classroom);
    }

    public int deleteUserNotClass(String username) {
        if (username != null) {
            String[] cs = username.split("-");
            if (cs.length > 1) {
                String classe = cs[0];
                String sezione = cs[1];
                String str = classe + "-" + sezione + "-" + "%";
                return cRepository.deleteByUsernameNotLike(str);
            }
        }
        return 0;
    }

    public void closeAllVisor(String[] users, VRDeviceManageDetailService detailService, HttpSession session) {

        if (users == null || users.length == 0) {
            return;
        }

        for (String user : users) {
            // aggiorna orario di fine utilizzo e monteore in dettaglio connessione
            detailService.endTime(user);
        }

        // rimuove gli allievi da sessione
        session.removeAttribute("visoreAllievo");

        // rimuove i visori da connect
        cRepository.removeAll();
    }


}
