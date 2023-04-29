package online.vrscuola.controllers.base;

import online.vrscuola.services.ArgomentiDirService;
import online.vrscuola.services.KeycloakUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/sezione")
public class SezioneController {

    @Autowired
    KeycloakUserService keycloakUserService;
    @Autowired
    private ArgomentiDirService argomentiDirService;
    @PostMapping
    public String handleClasseSelection(@RequestParam("classSelected") String classSelected,@RequestParam("sectionSelected") String sectionSelected, HttpSession session) {
        session.setAttribute("classSelected", classSelected);
        session.setAttribute("sectionSelected", sectionSelected);
        keycloakUserService.initFilterSections(classSelected,sectionSelected);
        String[] alunni = keycloakUserService.filterSectionsAllievi();
        String[] username = keycloakUserService.filterSectionsUsername();
        session.setAttribute("alunni",alunni);
        session.setAttribute("username",username);
        session.setAttribute("argoments", argomentiDirService.getArgomentiAll("aula01",classSelected,sectionSelected));
        return "redirect:/abilita-visore";
    }

}