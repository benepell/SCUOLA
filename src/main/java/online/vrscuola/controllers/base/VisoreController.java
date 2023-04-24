package online.vrscuola.controllers.base;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class VisoreController {

    @PostMapping(value = "/visore")
    public String handleClasseSelection(@RequestParam("classSelected") String classSelected,@RequestParam("sectionSelected") String sectionSelected,@RequestParam("visorSelected") String visorSelected, HttpSession session) {
        session.setAttribute("classSelected", classSelected);
        session.setAttribute("sectionSelected", sectionSelected);
        session.setAttribute("visorSelected", visorSelected);
        return "redirect:/abilita-visore";
    }

    @PostMapping(value = "argomento-visore")
    public String argomentoVisoreSelection(@RequestParam("argomento") String argomento, @RequestParam("id_argomento") String ìd_argomento, @RequestParam("visore") String visore, HttpSession session) {
        session.setAttribute("id_argomento", ìd_argomento);
        session.setAttribute("argomento", argomento);
        session.setAttribute("visore", visore);
        return "abilita-visore";
    }

}