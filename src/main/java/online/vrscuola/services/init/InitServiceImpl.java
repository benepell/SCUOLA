package online.vrscuola.services.init;

import online.vrscuola.entities.init.Init;
import online.vrscuola.repositories.init.InitRepository;
import online.vrscuola.utilities.Utilities;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class InitServiceImpl implements InitService {

    private static final Logger Log = LogManager.getLogger(InitServiceImpl.class.getName());

    @Autowired
    InitRepository initRepository;

    @Override
    public void addInit(Utilities utilities, String macAddress){
        Init init = new Init();
        init.setMacAddress(macAddress);
        init.setInitDate(utilities.getEpoch());
        initRepository.save(init);
    }

    @Override
    public void updateInit(Utilities utilities, String macAddress, String oldMacAddress, String note) {
        initRepository.updateByMacAddress(macAddress,oldMacAddress,note);
    }

}
