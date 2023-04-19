package online.vrscuola.controllers.base;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SetupVisoreController {

    @RequestMapping(value="setup-visore")
    public String getSetupVisoreClasse(Model model)
    {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Gestione dei visori");
        return "setup-visore";
    }
}
