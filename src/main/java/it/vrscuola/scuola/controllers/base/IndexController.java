package it.vrscuola.scuola.controllers.base;

import it.vrscuola.scuola.services.utils.UtilService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/")
public class IndexController {

    @Autowired
    UtilService utilService;
    @RequestMapping
    public String getWelcome(Model model, HttpServletRequest request, HttpSession session)
    {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Autenticati per utilizzare i servizi");

        session.setAttribute("isTablet", utilService.isTablet(request));

        return "index";
    }
}