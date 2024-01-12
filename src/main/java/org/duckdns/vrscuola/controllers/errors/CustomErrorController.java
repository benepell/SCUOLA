package org.duckdns.vrscuola.controllers.errors;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.autoconfigure.web.servlet.error.AbstractErrorController;
import org.springframework.boot.web.error.ErrorAttributeOptions;
import org.springframework.boot.web.servlet.error.ErrorAttributes;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@Controller
public class CustomErrorController extends AbstractErrorController {

    public CustomErrorController(ErrorAttributes errorAttributes) {
        super(errorAttributes);
    }

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, Model model) {
        HttpStatus status = getStatus(request);
        if (status == HttpStatus.UNAUTHORIZED && "/sso/login".equals(request.getAttribute(RequestDispatcher.ERROR_REQUEST_URI))) {
            // Esegui il redirect a login patch per error 401 per keycloak
            return "redirect:/login";
        }

        // Aggiungi i dettagli dell'errore al modello
        Map<String, Object> errorDetails = getErrorAttributes(request, ErrorAttributeOptions.defaults());
        model.addAttribute("errorStatus", status.value());
        model.addAttribute("errorMessage", errorDetails.get("message"));

        model.addAttribute("intestazione", "Errore");
        model.addAttribute("titolo", "Errore in VrScuola");
        model.addAttribute("content", "/WEB-INF/view/errore.jsp");

        return "errore"; // Utilizza una vista di errore invece di un redirect
    }
}
