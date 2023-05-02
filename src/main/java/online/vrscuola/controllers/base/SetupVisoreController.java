package online.vrscuola.controllers.base;

import online.vrscuola.models.InitParamModel;
import online.vrscuola.repositories.devices.VRDeviceInitRepository;
import online.vrscuola.services.ValidateCredentialService;
import online.vrscuola.services.conf.ReadOculusServices;
import online.vrscuola.utilities.networking.NetworkServiceManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class SetupVisoreController {
    @Autowired
    ReadOculusServices readOculusServices;

    @Autowired
    ValidateCredentialService validateCredentialService;

    @RequestMapping(value="setup-visore")
    public String getSetupVisoreClasse(Model model)
    {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Gestione dei visori");
        return "setup-visore";
    }

    @PostMapping("/setup-visore")
    public String postScanVisoreClasse(Model model)
    {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Gestione dei visori");
        List<InitParamModel> oculus = readOculusServices.addOculus(validateCredentialService);
        String[] macs = new String[oculus.size()];
        for (int i = 0; i < oculus.size(); i++) {
            macs[i] = oculus.get(i).getMacAddress();
        }
        model.addAttribute("macs", String.join(",", macs ));
        return  "setup-visore";
    }


}
