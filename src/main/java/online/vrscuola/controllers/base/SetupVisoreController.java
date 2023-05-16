package online.vrscuola.controllers.base;

import online.vrscuola.models.InitParamModel;
import online.vrscuola.repositories.devices.VRDeviceInitRepository;
import online.vrscuola.services.securities.ValidateCredentialService;
import online.vrscuola.services.conf.ReadOculusServices;
import online.vrscuola.services.devices.VRDeviceInitServiceImpl;
import online.vrscuola.utilities.Utilities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.view.RedirectView;

import java.util.List;

@Controller
public class SetupVisoreController {

    @Value("${health.datasource.website.keycloak}")
    private String linkKeycloak;

    @Value("${health.datasource.website.risorse}")
    private String linkRisorse;

    @Autowired
    ReadOculusServices readOculusServices;

    @Autowired
    ValidateCredentialService validateCredentialService;

    @Autowired
    VRDeviceInitServiceImpl initService;

    @Autowired
    VRDeviceInitRepository repository;

    @Autowired
    Utilities utilities;

    @RequestMapping(value = "setup-visore")
    public String getSetupVisoreClasse(Model model) {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Gestione dei visori");

        try {
            List<String> labelsSetup = repository.labelsSetup();
            List<String> macsSetup = repository.macsSetup();

            model.addAttribute("macsSetup", String.join(",", macsSetup));
            model.addAttribute("labelsSetup", String.join(",", labelsSetup));

            model.addAttribute("utenti", linkKeycloak);
            model.addAttribute("risorse", linkRisorse);


        } catch (Exception e) {
            System.out.println("Errore: " + e.getMessage()
            );
            throw new RuntimeException(e);
        }

        return "setup-visore";
    }

    @PostMapping("/setup-visore")
    public RedirectView postScanVisoreClasse(Model model) {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Gestione dei visori");

        if (readOculusServices.existAddFile()) {
            List<InitParamModel> macs = readOculusServices.addOculus(validateCredentialService);
            String[] macsString = new String[macs.size()];
            String note = "aggiunta visore";
            for (InitParamModel p : macs) {
                macsString[macs.indexOf(p)] = p.getMacAddress();
                initService.addInit(utilities, p.getMacAddress(), note, p.getCode());
            }
        } else if (readOculusServices.existUpdateFile()) {
            List<InitParamModel> paramModels = readOculusServices.changeOculus(repository);
            for (InitParamModel p : paramModels) {
                boolean valid = initService.valid(p.getOldMacAddress(), p.getCode());
                if (valid) {
                    try {
                        String note = "modifica visore con vecchio mac: " + p.getOldMacAddress();
                        String code = validateCredentialService.generateVisorCode(p.getMacAddress());
                        initService.updateInit(utilities, p.getOldMacAddress(), p.getMacAddress(), note, code);

                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }
                }
            }
        }

        // aggiunge un timeout prima del redirect di 1 secondi
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        // Effettua il redirect al metodo GET desiderato
        return new RedirectView("/setup-visore", true);
    }

}
