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

import org.duckdns.vrscuola.entities.questions.AttemptEntitie;
import org.duckdns.vrscuola.entities.questions.ResponseEntitie;
import org.duckdns.vrscuola.models.AnswerModel;
import org.duckdns.vrscuola.models.DeviceInfo;
import org.duckdns.vrscuola.repositories.questions.AttemptRepository;
import org.duckdns.vrscuola.services.devices.VRDeviceConnectivityServiceImpl;
import org.duckdns.vrscuola.services.pdf.QuestionarioPdfService;
import org.duckdns.vrscuola.services.questions.AnswerService;
import org.duckdns.vrscuola.services.questions.ScoreService;
import org.duckdns.vrscuola.services.securities.KeycloakUserService;
import org.duckdns.vrscuola.utilities.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Optional;

@RestController
public class AnswerController {
    private final AnswerService answerService;
    private final ScoreService scoreService;
    private final QuestionarioPdfService questionarioPdfService;
    private final VRDeviceConnectivityServiceImpl cService;

    @Autowired
    public AnswerController(AnswerService answerService, ScoreService scoreService, QuestionarioPdfService questionarioPdfService, VRDeviceConnectivityServiceImpl cService) {
        this.answerService = answerService;
        this.scoreService = scoreService;
        this.questionarioPdfService = questionarioPdfService;
        this.cService = cService;
    }

    @PostMapping("/answers")
    public ResponseEntity<?> submitAnswer(@RequestBody AnswerModel answerDTO) {

        List<DeviceInfo> dev = cService.getInfo(answerDTO.getMacAddress());
        if (!dev.isEmpty()) {
            DeviceInfo firstDevice = dev.get(0);
            answerDTO.setAula(firstDevice.getLab());
            answerDTO.setSezione(firstDevice.getSezione());
            answerDTO.setClasse(firstDevice.getClasse());
            answerDTO.setArgomento(firstDevice.getArg());
            answerDTO.setUsername(firstDevice.getUsername());
        }

        try {
            ResponseEntitie savedAnswer = answerService.initAndSave(answerDTO);
            scoreService.calculateAndSaveTotalScore(answerDTO);

            questionarioPdfService.generateLatestUserPdfQuestionario(answerDTO);

            return ResponseEntity.ok(savedAnswer);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred while saving the answer. " + e.getMessage());
        }
    }


}