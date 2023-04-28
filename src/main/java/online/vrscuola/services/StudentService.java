package online.vrscuola.services;

import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class StudentService {
    private List<String> allievi;
    private List<String> visori;
    private Map<String, String> visoreAllievo;

    public void init(List<String> allievi, List<String> visori) {
        this.allievi = allievi;
        this.visori = visori;
        visoreAllievo = new HashMap<>();
    }

    public Optional<String> setVisore(String allievo) {
        if (!allievi.contains(allievo)) {
            return Optional.empty(); // student not found
        }

        Optional<String> visore = visori.stream().filter(v -> !visoreAllievo.containsValue(v)).findFirst();

        if (visore.isPresent()) {
            visoreAllievo.put(allievo, visore.get());
            return visore;
        } else {
            return Optional.empty(); // no available headset
        }
    }

    public boolean freeVisore(String allievo) {
        return visoreAllievo.remove(allievo) != null;
    }

    public Optional<String> getVisore(String allievo) {
        return Optional.ofNullable(visoreAllievo.get(allievo));
    }

    public String getNumVisori(){
        return String.valueOf(visori.size());
    }

    public String getNumVisoriOccupati(){
        return String.valueOf(visoreAllievo.size());
    }

    public String getNumVisoriLiberi(){
        return String.valueOf(visori.size()-visoreAllievo.size());
    }
}
