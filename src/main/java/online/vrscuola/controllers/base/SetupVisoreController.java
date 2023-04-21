package online.vrscuola.controllers.base;

import online.vrscuola.utilities.networking.NetworkServiceManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SetupVisoreController {
    @Autowired
    NetworkServiceManager networkServiceManager;

    @RequestMapping(value="setup-visore")
    public String getSetupVisoreClasse(Model model)
    {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Gestione dei visori");
        return "setup-visore";
    }

    @PostMapping("/setup-visore")
    public String postScanVisoreClasse(Model model)
    {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Gestione dei visori");
        String str = String.join(",", networkServiceManager.scanOculusNetwork());

        model.addAttribute("macs", str );
        return  "setup-visore";
    }


}
