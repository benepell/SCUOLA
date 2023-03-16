package online.vrscuola.services.init;

import online.vrscuola.entities.init.Init;
import online.vrscuola.repositories.init.InitRepository;
import online.vrscuola.utilities.Utilities;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

public interface InitService {
    void addInit(Utilities utilities, String macAddress);

    void updateInit(Utilities utilities, String macAddress, String oldMacAddress, String note);


}
