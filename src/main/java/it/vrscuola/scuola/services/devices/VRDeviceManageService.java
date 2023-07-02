package it.vrscuola.scuola.services.devices;

import it.vrscuola.scuola.entities.devices.VRDeviceConnectivityEntitie;
import it.vrscuola.scuola.repositories.devices.VRDeviceConnectivityRepository;
import it.vrscuola.scuola.repositories.devices.VRDeviceInitRepository;
import it.vrscuola.scuola.services.securities.KeycloakUserService;
import it.vrscuola.scuola.utilities.Constants;
import it.vrscuola.scuola.utilities.Utilities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.List;

@Service
public class VRDeviceManageService {

    @Value("${school.argoment.default}")
    private String defaultArgoment;

    @Autowired
    VRDeviceInitRepository iRepository;

    @Autowired
    VRDeviceConnectivityRepository cRepository;

    @Autowired
    KeycloakUserService kService;

    @Autowired
    Utilities utilities;

    public boolean enableDevice(String label, String username, HttpSession session) {
        // controlla se macAddress ha un visore associato
        String macAddress = iRepository.findMac(label);
        if (macAddress == null) {
            return false;
        }

        boolean updating = false;

        // controlla se il visore e' gia' associato
        if (cRepository.findMac(macAddress) != null) {
            updating = true;
        }

        String note = "";

        // controlla da keycloak se l'utente esiste ed e' abilitato
        if (kService.existUser(username)) {

            String arg = null ;
            if (!label.equals("0")|| !label.equals("1")) {
                // recupera argomento del visore da session
                arg = (String) session.getAttribute("arg");
                // se non e' presente in session usa quello di default
                arg = arg != null ? arg : defaultArgoment;
            }

            if (updating) {
                if(arg != null){
                    cRepository.updateByMacAddress2(utilities.getEpoch(), username, note, macAddress, Constants.CONNECTED_IN_PENDING, arg);
                } else {
                    cRepository.updateByMacAddress(utilities.getEpoch(), username, note, macAddress, Constants.CONNECTED_IN_PENDING);
                }
            } else {
                VRDeviceConnectivityEntitie vrDeviceConnectivityEntitie = new VRDeviceConnectivityEntitie();
                vrDeviceConnectivityEntitie.setInitDate(utilities.getEpoch());
                vrDeviceConnectivityEntitie.setMacAddress(macAddress);
                vrDeviceConnectivityEntitie.setUsername(username);
                vrDeviceConnectivityEntitie.setNote(note);
                vrDeviceConnectivityEntitie.setConnected(Constants.CONNECTED_IN_PENDING);

                if(arg != null){
                    vrDeviceConnectivityEntitie.setArgoment(arg);
                }
                cRepository.save(vrDeviceConnectivityEntitie);
            }

        }
        return true;
    }

    public boolean removeDevice(String label, String username) {
        // controlla se macAddress ha un visore associato
        String macAddress = iRepository.findMac(label);
        if (macAddress == null) {
            return false;
        }

        String note = "";

        // controlla da keycloak se l'utente esiste ed e' abilitato
        if (kService.existUser(username)) {
            cRepository.updateByMacAddress(utilities.getEpoch(), username, note, macAddress, Constants.CONNECTED_IN_DISCONNECTED);
            deleteArgoment(label);
        }
        return true;
    }

    public void updateArgoment(String label, String argoment, HttpSession session) {
        // controlla se macAddress ha un visore associato
        String macAddress = iRepository.findMac(label);
        if (macAddress == null) {
            return;
        }

        String arg = "" ;
        if (argoment == null) {
            // recupera argomento del visore da session
            arg = (String) session.getAttribute("arg");
            // se non e' presente in session usa quello di default
            arg = arg != null ? arg : defaultArgoment;
        } else {
            arg = argoment;
            // imposta una variabile di sessione per l'argomento
            session.setAttribute("arg", argoment);

        }

        cRepository.updateArgomentByVisore(utilities.getEpoch(), arg, macAddress);
    }

    public boolean deleteArgoment(String label) {
        // controlla se macAddress ha un visore associato
        String macAddress = iRepository.findMac(label);
        if (macAddress == null) {
            return false;
        }

        // aggiorna argomento del visore
        String arg = "";
        cRepository.updateArgomentByVisore(utilities.getEpoch(), arg, macAddress);

        return true;
    }

    public String[] allDevices() {
        List<String> list = iRepository.labels(Constants.BATTERY_LEVEL);
        return list != null ? list.toArray(new String[list.size()]) : null;
    }
}
