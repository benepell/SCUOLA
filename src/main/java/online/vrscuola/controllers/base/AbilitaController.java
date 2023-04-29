package online.vrscuola.controllers.base;

import online.vrscuola.services.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.Arrays;

@Controller
@RequestMapping("/")
public class AbilitaController
{

    @Autowired
    StudentService studentService;

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
    public String getAbilitaVisore(Model model, HttpSession session)
    {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Autenticati per utilizzare i servizi");
        model.addAttribute("response", "stringaresponse");

        String[] alu = (String[]) session.getAttribute("alunni");
        String[] vis = new String[]{
                "1", "2"
                // , "3", "4",
                //"5", "6", "7", "8"
        };
        studentService.init(Arrays.asList(alu),Arrays.asList(vis));

        return "abilita-visore";
    }

}