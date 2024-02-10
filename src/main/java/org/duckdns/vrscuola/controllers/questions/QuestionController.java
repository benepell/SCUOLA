package org.duckdns.vrscuola.controllers.questions;

import org.duckdns.vrscuola.models.QuestionModel;
import org.duckdns.vrscuola.services.questions.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@RestController
public class QuestionController {

    @Value("${school.resource.arg}")
    private String arg;

    @Autowired
    private QuestionService questionarioService;

    @GetMapping("/questions")
    public ResponseEntity<List<QuestionModel>> getDomande(
            @RequestParam(required = true) String aula,
            @RequestParam(required = true) String classe,
            @RequestParam(required = true) String sezione,
            @RequestParam(required = true) String argomento,
            @RequestParam(required = false) String text
    ) {
        try {
            String fileDomande = arg + aula + "/" + classe + "/" + sezione + "/" + argomento + "/" +
                    "test_" + (text != null ? text : "finale" ) + ".txt";
            List<QuestionModel> domande = questionarioService.leggiDomandeDaFile(fileDomande);
            return ResponseEntity.ok(domande);
        } catch (IOException e) {
           return ResponseEntity.ok(new ArrayList<>());
        }
    }

}