package online.vrscuola.controllers.base;

import online.vrscuola.services.ArgomentiDirService;
import online.vrscuola.services.StudentService;
import online.vrscuola.services.devices.VRDeviceManageDetailService;
import online.vrscuola.services.devices.VRDeviceManageService;
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

    @Autowired
    VRDeviceManageService manageService;

    @Autowired
    VRDeviceManageDetailService manageDetailService;

    @PostMapping(value = "/visore-selection")
    @ResponseBody
    public Map<String, String> handleVisoreSelection(@RequestParam("username") String username, @RequestParam("allievo") String allievo, HttpSession session) {
        Map<String, String> response = new HashMap<>();
        String dbVisore = studentService.dbVisori(username);

        if (dbVisore != null) {
            response.put("visore", dbVisore);
            response.put("allievo", allievo);
            response.put("num_visore", studentService.getNumVisori());
            response.put("num_visore_disp", studentService.getNumVisoriLiberi(session));
            response.put("num_visore_occup", studentService.getNumVisoriOccupati(session));

            String firstVisore = studentService.getFirstVisore();
            if (firstVisore != null) {
                response.put("primo_visore", firstVisore);
            } else {
                response.put("primo_visore", "0");
            }

        }else {
            studentService.setVisore(allievo, session);
            Optional<String> res = studentService.getVisore(allievo, session);

            String visore = res.isPresent() ? res.get() : "0";

            boolean state = manageService.enableDevice(visore, username, session);
            if (state) {
                manageDetailService.startTime(username);
            }

            if (res.isPresent() && state) {
                response.put("visore", visore);
                response.put("allievo", allievo);
                response.put("num_visore", studentService.getNumVisori());
                response.put("num_visore_disp", studentService.getNumVisoriLiberi(session));
                response.put("num_visore_occup", studentService.getNumVisoriOccupati(session));
                response.put("primo_visore", studentService.getFirstVisore());

            } else {
                response.put("visore", "0");
            }
        }

        return response;
    }

    @PostMapping(value = "/visore-remove")
    @ResponseBody
    public Map<String, String> handleVisoreRemove(@RequestParam("username") String username, @RequestParam("allievo") String allievo, HttpSession session) {

        Optional<String> res = studentService.getVisore(allievo, session);
        String visore = res.isPresent() ? res.get() : "0";

        if(visore.equals("0")) {
            String dbVisore = studentService.dbVisori(username);
            if (dbVisore != null) {
                visore = dbVisore;
            }
        }
        studentService.freeVisore(allievo, session);

        boolean state = manageService.removeDevice(visore, username);
        if (state) {
            manageDetailService.endTime(username);
        }

        Map<String, String> response = new HashMap<>();
        if (res.isPresent() && state) {
            response.put("visore", "0");
            response.put("allievo", allievo);
            response.put("num_visore", studentService.getNumVisori());
            response.put("num_visore_disp", studentService.getNumVisoriLiberi(session));
            response.put("num_visore_occup", studentService.getNumVisoriOccupati(session));
        } else {
            response.put("visore", "0");
        }

        return response;
    }

    @PostMapping(value = "/chiudi-visore")
    public String handleCloseAllVisor(@RequestParam("username") String username, HttpSession session) {
        if (username != null) {
            String [] users = username.split(",");
            studentService.closeAllVisor(users, manageDetailService, session);
        }

        return "abilita-classe";
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
        manageService.updateArgoment(visore, argomento, session);
        return "abilita-visore";
    }

}