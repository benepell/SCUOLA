package online.vrscuola.controllers.base;


import online.vrscuola.models.SetupModel;
import online.vrscuola.services.SetupService;
import online.vrscuola.services.ValidateCredentialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

@Controller
@RequestMapping("/")
public class SetupController {

    @Autowired
    private SetupService cService;
    @Autowired
    private ValidateCredentialService vService;

    @RequestMapping(value="setup")
    public String getIndex(Model model)
    {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Autenticati per utilizzare i servizi");

        return "setup";
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