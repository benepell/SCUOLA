package online.vrscuola.controllers.resources;

import online.vrscuola.services.ArgomentiDirService;
import online.vrscuola.utilities.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ArgomentiController {

    @Autowired
    ArgomentiDirService argomentiDirService;

    @GetMapping(value = "/argomenti/all", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<String>> getArgomentiAll(
            @RequestParam(name = "aula", defaultValue = "aula01") String aula,
            @RequestParam(name = "classe", defaultValue = "") String classe,
            @RequestParam(name = "sezione", defaultValue = "") String sezione) {

        try {
            List<String> args = argomentiDirService.getArgomentiAll(aula, classe, sezione);
            return ResponseEntity.ok(args);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }


}
