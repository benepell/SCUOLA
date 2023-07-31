package it.vrscuola.scuola.controllers.base;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/classroom")
public class ClassroomController {
    @PostMapping
    public String handleClasseSelection(@RequestParam("classroomSelected") String classroomSelected, HttpSession session) throws Exception {
        session.setAttribute("classroomSelected", classroomSelected);
        return "redirect:/abilita-sezione";
    }
}
