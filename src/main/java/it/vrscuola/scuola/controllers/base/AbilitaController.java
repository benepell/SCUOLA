package it.vrscuola.scuola.controllers.base;

import it.vrscuola.scuola.services.StudentService;
import it.vrscuola.scuola.services.devices.VRDeviceManageService;
import it.vrscuola.scuola.services.log.EventLogService;
import it.vrscuola.scuola.services.utils.UtilService;
import it.vrscuola.scuola.utilities.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
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

    @Autowired
    EventLogService logService;

    @Autowired
    UtilService utilService;

    @RequestMapping(value = "abilita-classe")
    public String getAbilitaClasse(Model model, HttpServletRequest request, HttpSession session) {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Autenticati per utilizzare i servizi");
        model.addAttribute("response", "stringaresponse");

        model.addAttribute("utenti", linkKeycloak);
        model.addAttribute("risorse", linkRisorse);

        session.setAttribute("isTablet", utilService.isTablet(request));

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

        session.setAttribute("isCloseVisorLogout", true);

        model.addAttribute("utenti", linkKeycloak);
        model.addAttribute("risorse", linkRisorse);

        String classroom = session != null && session.getAttribute("classroomSelected") != null ?  session.getAttribute("classroomSelected").toString() : "";

        String[] alu = (String[]) session.getAttribute("alunni");
        String[] vis = manageService.allDevices(classroom);
        String[] users = session.getAttribute("usernameSelected") != null ? session.getAttribute("usernameSelected").toString().split(",") : null;

        model.addAttribute("username", users);

        String[] resume = manageService.resume(classroom);
        if (resume != null && resume.length == 2) {
            model.addAttribute("resumeUsers", resume[0]);
            model.addAttribute("resumeLabels", resume[1]);
        }

        if (alu == null || vis == null) {
            return "redirect:/abilita-classe";
        }


        studentService.init(Arrays.asList(alu), Arrays.asList(vis), classroom);

        logService.sendLog(session, Constants.EVENT_LOG_ENABLE_VISOR);

        return "abilita-visore";
    }

}