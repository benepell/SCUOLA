package online.vrscuola.controllers.resources;

import online.vrscuola.models.Config;
import online.vrscuola.services.ConfigService;
import online.vrscuola.services.ValidateCredentialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class ConfigController {

    @Autowired
    private ConfigService cService;

    @Autowired
    private ValidateCredentialService vService;




    @PostMapping("/update-env")
    public String updateConfig(@ModelAttribute("config") Config config, Model model) {

        String cod = config.getCodiceDiRegistrazioneScuola();
        String c = vService.generateCredentials(config.getBaseScuola());

        System.out.println( c + " " + cod);


        if(config.getCodiceDiRegistrazioneScuola().equals(vService.generateCredentials(config.getBaseScuola()))){
            // scrive il file di testo
            cService.writeConfig(config);
            // restituiamo il nome della vista da visualizzare
            return "config-success";
        }

        return "config-unsuccess";

    }
}