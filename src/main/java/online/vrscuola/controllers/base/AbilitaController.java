package online.vrscuola.controllers.base;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class AbilitaController
{
    @RequestMapping(value="abilita-classe")
    public String getAbilitaClasse(Model model)
    {

        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Autenticati per utilizzare i servizi");
        model.addAttribute("response", "stringaresponse");
        return "abilita-classe";
    }
    @RequestMapping(value="abilita-sezione")
    public String getAbilitaSezione(Model model)
    {

        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Autenticati per utilizzare i servizi");
        model.addAttribute("response", "stringaresponse");
        return "abilita-sezione";
    }

    @RequestMapping(value="abilita-visore")
    public String getAbilitaVisore(Model model)
    {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Autenticati per utilizzare i servizi");
        model.addAttribute("response", "stringaresponse");
        return "abilita-visore";
    }

}