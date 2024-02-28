/**
 * Copyright (c) 2023, Benedetto Pellerito
 * Email: benedettopellerito@gmail.com
 * GitHub: https://github.com/benepell
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.duckdns.vrscuola.controllers.questions;

import jakarta.servlet.http.HttpServletResponse;
import org.duckdns.vrscuola.models.QuestionModel;
import org.duckdns.vrscuola.payload.response.QuestionModelResponse;
import org.duckdns.vrscuola.services.pdf.QuestionarioPdfService;
import org.duckdns.vrscuola.services.questions.QuestionService;
import org.duckdns.vrscuola.services.securities.KeycloakUserService;
import org.duckdns.vrscuola.utilities.Constants;
import org.duckdns.vrscuola.utilities.FileUtils;
import org.duckdns.vrscuola.utilities.Utilities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@RestController
public class QuestionController {

    @Autowired
    KeycloakUserService kService;

    @Value("${school.resource.txt}")
    private String txtRes;

    @Value("${health.datasource.website.risorse}")
    private String linkRes;

    @Autowired
    private QuestionService questionarioService;

    @Autowired
    private Utilities utilities;

    @Autowired
    private QuestionarioPdfService questionarioPdfService;

    @GetMapping("/questions")
    public ResponseEntity<List<QuestionModelResponse>> getDomande(Authentication authentication, HttpServletResponse response,
                                                                  @RequestParam(required = true) String aula,
                                                                  @RequestParam(required = true) String classe,
                                                                  @RequestParam(required = true) String sezione,
                                                                  @RequestParam(required = true) String argomento,
                                                                  @RequestParam(required = true) String username,
                                                                  @RequestParam(required = false) String text
    ) {
        try {

            String textName = Constants.QUESTIONS_PREFIX_FILENAME + "_" + (text != null ? text : "finale") + ".txt";

            String fileDomande = txtRes + Constants.QUESTIONS_PREFIX_DOMANDE + "/" +
                    aula + "/" +
                    classe + "/" +
                    sezione + "/" +
                    argomento + "/" + textName;

            String baselink = linkRes + "/" +
                    Constants.QUESTIONS_PREFIX_FILES + "/" +
                    Constants.QUESTIONS_PREFIX_TEST + "/" +
                    Constants.QUESTIONS_PREFIX_DOMANDE + "/" +
                    aula + "/" +
                    classe + "/" +
                    sezione + "/" +
                    argomento + "/";

            List<QuestionModel> domandeConRisposta = questionarioService.leggiDomandeDaFile(fileDomande, baselink);

            String hash = FileUtils.calculateHash(new File(fileDomande));
            List<QuestionModel> tmpResponse = questionarioService.scriviDomandeInDb(domandeConRisposta, username, hash, textName);

            // Trasformare tmpResponse  per rimuovere rispostecorrette dalla lista
            List<QuestionModelResponse> responses = tmpResponse.stream()
                    .map(question -> new QuestionModelResponse(
                            question.getId(),
                            question.getDomanda(),
                            question.getMedia(),
                            question.getRisposte()
                    ))
                    .collect(Collectors.toList());

            return ResponseEntity.ok(responses);

        } catch (IOException e) {
            return ResponseEntity.ok(new ArrayList<>());
        }
    }

    @GetMapping("/list-questions")
    public ResponseEntity<List<String>> listQuestionnaires(
            @RequestParam(required = true) String aula,
            @RequestParam(required = true) String classe,
            @RequestParam(required = true) String sezione,
            @RequestParam(required = true) String argomento,
            @RequestParam(required = false) String text
    ) {
        try {

            String questionnairesPath = txtRes + Constants.QUESTIONS_PREFIX_DOMANDE + "/" +
                    aula + "/" +
                    classe + "/" +
                    sezione + "/" +
                    argomento + "/";

            List<String> fileNames = Files.walk(Paths.get(questionnairesPath))
                    .filter(Files::isRegularFile)
                    .map(path -> path.getFileName().toString())
                    .filter(fileName -> fileName.startsWith(Constants.QUESTIONS_PREFIX_FILENAME.concat("_"))) // Aggiunto filtro per nomi che iniziano con "test_"
                    .collect(Collectors.toList());

            return ResponseEntity.ok(fileNames);

        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body(null);
        }
    }

    @GetMapping("/list-media")
    public ResponseEntity<List<String>> listMedia(
            @RequestParam(required = true) String aula,
            @RequestParam(required = true) String classe,
            @RequestParam(required = true) String sezione,
            @RequestParam(required = true) String argomento,
            @RequestParam(required = false) String text
    ) {
        try {

            String questionnairesPath = txtRes + Constants.QUESTIONS_PREFIX_DOMANDE + "/" +
                    aula + "/" +
                    classe + "/" +
                    sezione + "/" +
                    argomento + "/";

            List<String> fileNames = Files.walk(Paths.get(questionnairesPath))
                    .filter(Files::isRegularFile)
                    .map(path -> path.getFileName().toString())
                    .filter(fileName -> !fileName.startsWith(Constants.QUESTIONS_PREFIX_FILENAME.concat("_"))) // Aggiunto filtro per nomi che iniziano con "test_"
                    .collect(Collectors.toList());

            return ResponseEntity.ok(fileNames);

        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body(null);
        }
    }

    @GetMapping("/questions-view")
    public ModelAndView getQuestionsForJsp(Authentication authentication,
                                           @RequestParam(required = true) String aula,
                                           @RequestParam(required = true) String classe,
                                           @RequestParam(required = true) String sezione,
                                           @RequestParam(required = true) String argomento,
                                           @RequestParam(required = true) String username,
                                           @RequestParam(required = false) String text) throws IOException {
        ModelAndView modelAndView = new ModelAndView("questions"); // Indica il nome della tua pagina JSP (senza l'estensione .jsp)

        // Aggiungi qui la logica per recuperare i dati che vuoi passare alla tua pagina JSP
        String textName = Constants.QUESTIONS_PREFIX_FILENAME + "_" + (text != null ? text : "finale") + ".txt";

        String fileDomande = txtRes + Constants.QUESTIONS_PREFIX_DOMANDE + "/" +
                aula + "/" +
                classe + "/" +
                sezione + "/" +
                argomento + "/" + textName;

        String baselink = linkRes + "/" +
                Constants.QUESTIONS_PREFIX_FILES + "/" +
                Constants.QUESTIONS_PREFIX_TEST + "/" +
                Constants.QUESTIONS_PREFIX_DOMANDE + "/" +
                aula + "/" +
                classe + "/" +
                sezione + "/" +
                argomento + "/";

        List<QuestionModel> domandeConRisposta = questionarioService.leggiDomandeDaFile(fileDomande, baselink);

        String hash = FileUtils.calculateHash(new File(fileDomande));
        List<QuestionModel> tmpResponse = questionarioService.scriviDomandeInDb(domandeConRisposta, username, hash, textName);


        // Passa i valori alla vista
        modelAndView.addObject("aula", aula);
        modelAndView.addObject("classe", classe);
        modelAndView.addObject("sezione", sezione);
        modelAndView.addObject("argomento", argomento);
        modelAndView.addObject("username", username);
        modelAndView.addObject("text", textName);
        modelAndView.addObject("questions", tmpResponse);

        return modelAndView; // Restituisce il modello e il nome della vista
    }


}