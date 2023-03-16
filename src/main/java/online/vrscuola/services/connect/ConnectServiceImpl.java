package online.vrscuola.services.connect;

import online.vrscuola.payload.response.ConnectResponse;
import online.vrscuola.repositories.connect.ConnectRepository;
import online.vrscuola.repositories.init.InitRepository;
import online.vrscuola.utilities.Utilities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class ConnectServiceImpl implements  ConnectService{

    @Value("${keycloak.credentials.secret}")
    private String code;

    @Autowired
    ConnectRepository cRepository;

    @Autowired
    InitRepository iRepository;

    @Override
    public String viewConnect(Utilities utilities, String macAddress, String note) {
        return cRepository.existsUsername(macAddress);
    }

    @Override
    public boolean valid(String macAddress, String code) {
        // codice di verifica
        if(!this.code.equals(code)){
            return false;
        }
        // apparato registrato
        if(!iRepository.existsByMacAddress(macAddress)){
            return false;
        }
        // ultima condizione verificata allora true
        // collegamento professore aggionamento campo username in base a macaddress
        if(cRepository.existsByMacAddress(macAddress)){
            return true;
        }

        return false;
    }
}
