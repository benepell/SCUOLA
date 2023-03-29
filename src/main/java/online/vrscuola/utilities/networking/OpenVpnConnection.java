package online.vrscuola.utilities.networking;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStreamReader;

@Component
public class OpenVpnConnection {

    @Value("${openvpn.school.path}") // percorso del file openvpn
    private String openVpnPath;

    @Value("${openvpn.school.config}") // percorso del file di configurazione per la scuola A
    private String schoolConfigPath;

    private Process openVpnProcess;

    public void connect() {
        // crea un nuovo thread per la connessione OpenVPN
        Thread vpnThread = new Thread(() -> {
            // esegui il comando per avviare la connessione OpenVPN
            String command = openVpnPath + " --config " + schoolConfigPath;
            try {
                openVpnProcess = Runtime.getRuntime().exec(command);
                // attendi che la connessione sia stabilita (verificando lo stato del processo OpenVPN)
                BufferedReader in = new BufferedReader(new InputStreamReader(openVpnProcess.getInputStream()));
                String line;
                while ((line = in.readLine()) != null) {
                    if (line.contains("Initialization Sequence Completed")) {
                        // la connessione è stabilita
                        break;
                    }
                }
                in.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
        vpnThread.start();
    }

    public void disconnect() {
        // invia il segnale SIGTERM al processo OpenVPN per disconnettere il client
        if (openVpnProcess != null) {
            openVpnProcess.destroy();
        }
    }
}
