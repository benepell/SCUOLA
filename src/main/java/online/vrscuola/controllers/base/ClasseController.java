package online.vrscuola.controllers.base;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/classe")
public class ClasseController {

    @PostMapping
    public String handleClasseSelection(@RequestParam("classSelected") String classSelected, HttpSession session) {
        session.setAttribute("classSelected", classSelected);
        return "redirect:/abilita-sezione";
    }

}

