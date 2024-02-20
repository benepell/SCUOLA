package org.duckdns.vrscuola.services.questions;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.duckdns.vrscuola.entities.questions.ResponseEntitie;
import org.duckdns.vrscuola.entities.questions.QuestionEntitie;
import org.duckdns.vrscuola.models.AnswerModel;
import org.duckdns.vrscuola.repositories.questions.ResponseRepository;
import org.duckdns.vrscuola.repositories.questions.QuestionRepository;
import org.duckdns.vrscuola.repositories.questions.AnswerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;


@Service
public class AnswerService {

    @Autowired
    private ResponseRepository responseRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private AnswerRepository answerRepository;


    @PersistenceContext
    private EntityManager entityManager;

    @Transactional
    public boolean isCorrectAnswer(Long answerId) {
        String sqlQuery = "SELECT COUNT(*) " +
                "FROM answer a " +
                "INNER JOIN correct_answer ca ON a.question_id = ca.question_id " +
                "WHERE ca.corretta = a.posizione AND a.id = :answerId";

        Query query = entityManager.createNativeQuery(sqlQuery);
        query.setParameter("answerId", answerId);

        int count = ((Number) query.getSingleResult()).intValue();
        return count > 0;
    }

    @Transactional
    public ResponseEntitie initAndSave(AnswerModel answerModel) {
        // Crea e imposta l'entità di risposta basata sui dati ricevuti
        ResponseEntitie response = new ResponseEntitie();
        response.setAula(answerModel.getAula());
        response.setClasse(answerModel.getClasse());
        response.setSezione(answerModel.getSezione());
        response.setArgomento(answerModel.getArgomento());
        response.setText(answerModel.getText());
        response.setUsername(answerModel.getUsername());
        response.setData(Instant.now());


        // Salva l'entità di risposta per ottenere un ID generato
        ResponseEntitie savedResponse = responseRepository.save(response);

        // Per ogni coppia domanda-risposta nel modello
        for (AnswerModel.QuestionAnswerPair pair : answerModel.getQuestionAnswers()) {
            Long questionId = Long.parseLong(pair.getQuestionId());
            QuestionEntitie question = questionRepository.findById(questionId)
                    .orElseThrow(() -> new RuntimeException("Question not found: " + pair.getQuestionId()));

            for (String answerId : pair.getAnswerIds()) {
                boolean correctAnswer = isCorrectAnswer(Long.parseLong(answerId));
                answerRepository.updateCorrettoById(Long.parseLong(answerId), questionId, correctAnswer);
            }
        }

        return savedResponse;
    }


}
