package online.vrscuola.controllers.base;

import online.vrscuola.repositories.devices.VRDeviceConnectivityRepository;
import online.vrscuola.services.StudentService;
import online.vrscuola.services.devices.VRDeviceManageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.Arrays;

@Controller
@RequestMapping("/")
public class AbilitaController {

    @Value("${health.datasource.website.keycloak}")
    private String linkKeycloak;

    @Value("${health.datasource.website.risorse}")
    private String linkRisorse;

    @Autowired
    StudentService studentService;

    @Autowired
    VRDeviceManageService manageService;

    @RequestMapping(value = "abilita-classe")
    public String getAbilitaClasse(Model model) {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Autenticati per utilizzare i servizi");
        model.addAttribute("response", "stringaresponse");

        model.addAttribute("utenti", linkKeycloak);
        model.addAttribute("risorse", linkRisorse);

        return "abilita-classe";
    }

    @RequestMapping(value = "abilita-sezione")
    public String getAbilitaSezione(Model model) {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Autenticati per utilizzare i servizi");
        model.addAttribute("response", "stringaresponse");

        model.addAttribute("utenti", linkKeycloak);
        model.addAttribute("risorse", linkRisorse);

        return "abilita-sezione";
    }

    @RequestMapping(value = "abilita-visore")
    public String getAbilitaVisore(Model model, HttpSession session) {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Autenticati per utilizzare i servizi");
        model.addAttribute("response", "stringaresponse");

        model.addAttribute("utenti", linkKeycloak);
        model.addAttribute("risorse", linkRisorse);

        String[] alu = (String[]) session.getAttribute("alunni");
        String[] vis = manageService.allDevices();
        String[] users = session.getAttribute("usernameSelected") != null ? session.getAttribute("usernameSelected").toString().split(",") : null;

        model.addAttribute("username", users);
        if (alu == null || vis == null) {
            return "redirect:/abilita-classe";
        }
        studentService.init(Arrays.asList(alu), Arrays.asList(vis));

        return "abilita-visore";
    }

}