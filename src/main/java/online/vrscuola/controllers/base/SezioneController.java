package online.vrscuola.controllers.base;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/sezione")
public class SezioneController {

    @PostMapping
    public String handleClasseSelection(@RequestParam("classSelected") String classSelected,@RequestParam("sectionSelected") String sectionSelected, HttpSession session) {
        session.setAttribute("classSelected", classSelected);
        session.setAttribute("sectionSelected", sectionSelected);
        return "redirect:/abilita-visore";
    }

}