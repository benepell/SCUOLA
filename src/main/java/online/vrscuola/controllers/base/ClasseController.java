package online.vrscuola.controllers.base;

import online.vrscuola.controllers.securities.KeycloakUserController;
import online.vrscuola.services.KeycloakUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/classe")
public class ClasseController {

    @Autowired
    KeycloakUserController keycloakUserService;


    @PostMapping
    public String handleClasseSelection(@RequestParam("classSelected") String classSelected, HttpSession session) {
        session.setAttribute("classSelected", classSelected);
        List<Map<String, String>> users = keycloakUserService.getUsers("filter", classSelected, null);

        String[] letters = users.stream()
                .map(user -> user.get("sezione"))
                .toArray(String[]::new);
        session.setAttribute("allSections",letters);
        return "redirect:/abilita-sezione";
    }

}

