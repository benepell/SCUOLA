package org.duckdns.vrscuola.services.questions;

import jakarta.transaction.Transactional;
import org.duckdns.vrscuola.entities.questions.AnswerEntitie;
import org.duckdns.vrscuola.entities.questions.AttemptEntitie;
import org.duckdns.vrscuola.entities.questions.ScoreEntitie;
import org.duckdns.vrscuola.models.AnswerModel;
import org.duckdns.vrscuola.repositories.questions.AnswerRepository;
import org.duckdns.vrscuola.repositories.questions.AttemptRepository;
import org.duckdns.vrscuola.repositories.questions.ScoreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ScoreService {

    @Autowired
    private ScoreRepository scoreRepository;

    @Autowired
    private AnswerRepository answerRepository;

    @Autowired
    private AttemptRepository attemptRepository;

    @Transactional
    public void calculateAndSaveTotalScore(AnswerModel answerModel) {
        int totalCorrectAnswersCount = 0;
        int totalQuestions = answerModel.getQuestionAnswers().size();

        String username = answerModel.getUsername();
        if (username == null) {
            return;
        }
        Optional<AttemptEntitie> latestAttempt = attemptRepository.findLatestAttemptByUserName(username).stream().findFirst();
        AttemptEntitie attempt = new AttemptEntitie();

        latestAttempt.ifPresent(att -> {
            attempt.setId(att.getId());
        });

        // Calcola il totale delle risposte corrette per tutte le domande
        for (AnswerModel.QuestionAnswerPair pair : answerModel.getQuestionAnswers()) {
            Long questionId = Long.valueOf(pair.getQuestionId());

            List<Long> userAnswerIds = pair.getAnswerIds().stream().map(Long::valueOf).collect(Collectors.toList());

            List<AnswerEntitie> userAnswers = answerRepository.findByQuestionIdAndAttemptIdAndIdIn(questionId, attempt, userAnswerIds);

            long correctAnswersCount = userAnswers.stream().filter(AnswerEntitie::getCorretto).count();

            totalCorrectAnswersCount += correctAnswersCount;
        }

        if (attempt != null) {
            // Crea e salva un unico punteggio totale solo se abbiamo un attemptId valido
            ScoreEntitie totalScore = new ScoreEntitie();
            totalScore.setScoreValue(totalCorrectAnswersCount);
            totalScore.setTotalQuestions(totalQuestions);
            totalScore.setUsername(username);
            totalScore.setAttemptId(attempt.getId());
            scoreRepository.save(totalScore);
        }
    }
}
