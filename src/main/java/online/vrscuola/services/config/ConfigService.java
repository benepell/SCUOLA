package online.vrscuola.services.config;

import online.vrscuola.entities.config.ConfigEntitie;
import online.vrscuola.repositories.config.ConfigRepository;
import online.vrscuola.utilities.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ConfigService {
    @Autowired
    private ConfigRepository cRepository;
    public void eventLogPdf(String value){
        if(cRepository.existsByName(Constants.CONFIG_EVENT_LOG_PDF)) {
            cRepository.updateValue(value, "eventLogPdf");
        }else{
            try {
                ConfigEntitie config = new ConfigEntitie();
                config.setName(Constants.CONFIG_EVENT_LOG_PDF);
                config.setValue(value);
                config.setId(1L);
                cRepository.save(config);
            }catch (Exception e){
                e.printStackTrace();
            }

        }
    }
    public String getEventLogPdf(){
        if(cRepository.existsByName(Constants.CONFIG_EVENT_LOG_PDF)) {
            return cRepository.findByName(Constants.CONFIG_EVENT_LOG_PDF);
        }else{
            return null;
        }
    }
}
