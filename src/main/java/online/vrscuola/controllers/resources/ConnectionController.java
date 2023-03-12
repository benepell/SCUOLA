package online.vrscuola.controllers.resources;

import online.vrscuola.utilities.networking.OpenVpnConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ConnectionController {

    @Autowired
    private OpenVpnConnection openVpnConnection;

    @GetMapping("/vpnconnect")
    public ConnectionStatus getConnectionStatus() {
        openVpnConnection.connect();
        return new ConnectionStatus(true);
    }

    @GetMapping("/vpndisconnect")
    public ConnectionStatus getDisconnectionStatus() {
        openVpnConnection.disconnect();
        return new ConnectionStatus(true); // invia sempre che disconnesso
    }
    private static class ConnectionStatus {
        private boolean connected;

        public ConnectionStatus(boolean connected) {
            this.connected = connected;
        }

        public boolean isConnected() {
            return connected;
        }
    }
}
