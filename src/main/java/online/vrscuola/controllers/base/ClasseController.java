package online.vrscuola.controllers.base;

import online.vrscuola.controllers.securities.KeycloakUserController;
import online.vrscuola.services.KeycloakUserService;
import online.vrscuola.services.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/classe")
public class ClasseController {

    @Autowired
    KeycloakUserService keycloakUserService;



    @PostMapping
    public String handleClasseSelection(@RequestParam("classSelected") String classSelected, HttpSession session) {
        session.setAttribute("classSelected", classSelected);
        session.setAttribute("allSections",keycloakUserService.filterClasses(classSelected));
        return "redirect:/abilita-sezione";
    }

}

