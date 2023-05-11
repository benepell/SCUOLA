package online.vrscuola.services;

import online.vrscuola.repositories.devices.VRDeviceConnectivityRepository;
import online.vrscuola.repositories.devices.VRDeviceInitRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
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

    private List<String> allievi;
    private List<String> visori;

    public void init(List<String> allievi, List<String> visori) {
        this.allievi = allievi;
        this.visori = visori;
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
        if (session != null && session.getAttribute("visoreAllievo") != null){
            session.removeAttribute("visoreAllievo");
        }
    }

    // primo visore
    public String getFirstVisore() {
        return visori.stream().findFirst().get();
    }

    public String dbVisori(String username) {
            return iRepository.findLabelByUsername(username);
    }

    public String dbFirstVisore() {
        // while su tutti i visori
        // se non è occupato, ritorna il primo
        int i = 0;
        while (visori.size() > 0) {
            if (iRepository.findLabelAvailable(visori.get(i)) != null) {
                i++;
            } else {
                return visori.get(i);
            }
        }
        return null;
    }

    public int deleteUserNotClass(String username) {
        if(username != null) {
           String [] cs = username.split("-");
           if(cs.length > 1) {
               String classe = cs[0];
               String sezione = cs[1];
               String str = classe + "-" + sezione + "-" + "%";
               return cRepository.deleteByUsernameNotLike(str);
           }
        }
        return 0;
    }
}
