package online.vrscuola.controllers.base;

import online.vrscuola.services.ArgomentiDirService;
import online.vrscuola.services.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class VisoreController {

    @Autowired
    StudentService studentService;

    @PostMapping(value = "/visore-selection")
    @ResponseBody
    public Map<String, String> handleVisoreSelection(@RequestParam("allievo") String allievo, HttpSession session) {
        studentService.setVisore(allievo);
        Optional<String> res = studentService.getVisore(allievo);

        Map<String, String> response = new HashMap<>();
        if (res.isPresent()) {
            response.put("visore", res.get());
            response.put("allievo", allievo);
            response.put("num_visore", studentService.getNumVisori());
            response.put("num_visore_disp", studentService.getNumVisoriLiberi());
            response.put("num_visore_occup", studentService.getNumVisoriOccupati());
            response.put("primo_visore", studentService.getFirstVisore());

        } else {
            response.put("visore", "0");
        }

        return response;
    }

    @PostMapping(value = "/visore-remove")
    @ResponseBody
    public Map<String, String> handleVisoreRemove(@RequestParam("allievo") String allievo, HttpSession session) {
        studentService.freeVisore(allievo);
        Optional<String> res = studentService.getVisore(allievo);

        Map<String, String> response = new HashMap<>();
        if (res.isPresent()) {
            response.put("visore", res.get());
            response.put("allievo", allievo);
            response.put("num_visore", studentService.getNumVisori());
            response.put("num_visore_disp", studentService.getNumVisoriLiberi());
            response.put("num_visore_occup", studentService.getNumVisoriOccupati());
        } else {
            response.put("visore", "-1");
        }

        return response;
    }

    @PostMapping(value = "/allievo-visore")
    public String handleAllievoVisoreSelection(@RequestParam("classSelected") String classSelected, @RequestParam("sectionSelected") String sectionSelected, @RequestParam("visorSelected") String visorSelected, HttpSession session) {
        session.setAttribute("classSelected", classSelected);
        session.setAttribute("sectionSelected", sectionSelected);
        session.setAttribute("visorSelected", visorSelected);

        return "abilita-visore";
    }

    @PostMapping(value = "argomento-visore")
    public String argomentoVisoreSelection(@RequestParam("argomento") String argomento, @RequestParam("id_argomento") String ìd_argomento, @RequestParam("visore") String visore, HttpSession session) {
        session.setAttribute("id_argomento", ìd_argomento);
        session.setAttribute("argomento", argomento);
        session.setAttribute("visore", visore);
        return "abilita-visore";
    }

}