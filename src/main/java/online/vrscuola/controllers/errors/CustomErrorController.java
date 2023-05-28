package online.vrscuola.controllers.errors;

import org.springframework.boot.autoconfigure.web.servlet.error.AbstractErrorController;
import org.springframework.boot.web.servlet.error.ErrorAttributes;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

@Controller
public class CustomErrorController extends AbstractErrorController {

    public CustomErrorController(ErrorAttributes errorAttributes) {
        super(errorAttributes);
    }

    @RequestMapping("/error")
    public RedirectView handleError(HttpServletRequest request) {
        if (getStatus(request) == HttpStatus.UNAUTHORIZED && "/sso/login".equals(request.getAttribute(RequestDispatcher.ERROR_REQUEST_URI))) {
            // Esegui il redirect a login patch per error 401 per keycloak
            return new RedirectView("/login");
        }

        // Esegui un redirect di fallback a una pagina di errore generica
        return new RedirectView("/errore");
    }

    @RequestMapping("/errore")
    public String getWelcome(Model model)
    {
        model.addAttribute("intestazione", "Errore");
        return "errore";
    }
}


