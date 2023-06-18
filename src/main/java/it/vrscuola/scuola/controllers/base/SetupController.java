package it.vrscuola.scuola.controllers.base;


import it.vrscuola.scuola.models.SetupModel;
import it.vrscuola.scuola.services.config.SetupService;
import it.vrscuola.scuola.services.securities.ValidateCredentialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Map;

@Controller
@RequestMapping("/")
public class SetupController {

    @Autowired
    private SetupService cService;
    @Autowired
    private ValidateCredentialService vService;

    @RequestMapping(value="setup", method= RequestMethod.GET, headers="Host=localhost:5555")
    public String getIndex(Model model)
    {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Autenticati per utilizzare i servizi");

        return "setup";
    }

    @RequestMapping(value="setup-state", method= RequestMethod.GET, headers="Host=localhost:5555")
    @ResponseBody
    public Map<String, String> getSetupState() {
        return cService.checkConfigFile();
    }

    @PostMapping("/update-env")
    public String updateConfig(@ModelAttribute("setupModel") SetupModel setupModel, Model model) {

        String cod = setupModel.getCodiceDiRegistrazioneScuola();
        String c = vService.generateCredentials(setupModel.getBaseScuola());

        System.out.println( c + " " + cod);


        if(setupModel.getCodiceDiRegistrazioneScuola().equals(vService.generateCredentials(setupModel.getBaseScuola()))){
            // scrive il file di testo
            cService.writeConfig(setupModel);
            // restituiamo il nome della vista da visualizzare
            return "setup-success";
        }

        return "setup-unsuccess";

    }

    @GetMapping("/basesetup")
    public ResponseEntity<String> getSetupJson() throws IOException {
        // Leggi il contenuto del file JSON
        InputStream inputStream = new ClassPathResource("base_setup.json").getInputStream();
        byte[] bytes = inputStream.readAllBytes();
        String json = new String(bytes, StandardCharsets.UTF_8);
        return ResponseEntity.ok(json);
    }
}