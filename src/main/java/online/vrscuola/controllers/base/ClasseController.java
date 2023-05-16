package online.vrscuola.controllers.base;

import online.vrscuola.services.securities.KeycloakUserService;
import online.vrscuola.services.securities.ValidateCredentialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/classe")
public class ClasseController {

    @Autowired
    KeycloakUserService keycloakUserService;

    @Autowired
    ValidateCredentialService v;

    @PostMapping
    public String handleClasseSelection(@RequestParam("classSelected") String classSelected, HttpSession session) throws Exception {
        session.setAttribute("classSelected", classSelected);
        session.setAttribute("allSections",keycloakUserService.filterClasses(classSelected));
        return "redirect:/abilita-sezione";
    }

}

