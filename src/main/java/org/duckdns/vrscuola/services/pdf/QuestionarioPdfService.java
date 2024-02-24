package org.duckdns.vrscuola.services.pdf;

import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfWriter;

import org.duckdns.vrscuola.entities.questions.*;
import org.duckdns.vrscuola.models.AnswerModel;
import org.duckdns.vrscuola.repositories.questions.*;
import org.duckdns.vrscuola.services.utils.MessageService;
import org.duckdns.vrscuola.utilities.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.awt.*;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class QuestionarioPdfService {

    @Value("${school.resource}")
    private String resource;

    @Value("${school.resource.txt}")
    private String txtRes;

    @Autowired
    private MessageService messageService;
    @Autowired
    private UserFileRepository userFileRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private AnswerRepository answerRepository;

    @Autowired
    private ScoreRepository scoreRepository;

    @Autowired
    private AttemptRepository attemptRepository;

    public void generatePdfQuestionario(List<QuestionEntitie> domande, String filePath, String user, String dataInizio, String dataFine, String score) throws DocumentException, IOException {

        Document document = new Document();
        PdfWriter.getInstance(document, new FileOutputStream(filePath));

        document.open();

        String percorsoFile = resource + "intestazione.png";
        File file = new File(percorsoFile);

        if (file.exists()) {
            Image png = Image.getInstance(file.getAbsolutePath());
            png.setAlignment(Image.ALIGN_CENTER);
            png.scaleToFit(PageSize.A4.getWidth(), PageSize.A4.getHeight());
            document.add(png);
        }

        Font font = FontFactory.getFont(FontFactory.HELVETICA_BOLD);
        font.setSize(18);
        font.setColor(Color.BLACK);

        Paragraph p = new Paragraph(messageService.getMessage("pdf.test-finale.title"), font);
        p.setAlignment(Paragraph.ALIGN_CENTER);

        document.add(p);

        p = new Paragraph(messageService.getMessage("pdf.test-finale.user") + ": " + user + " - " +
                messageService.getMessage("pdf.test-data.score") + ": " + score + " - " +
                messageService.getMessage("pdf.test-data-inizio") + ": " + dataInizio + " - " +
                messageService.getMessage("pdf.test-data-fine") + ": " + dataFine
                , FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 10));
        //p.setAlignment(Paragraph.ALIGN_CENTER);

        document.add(p);

        // Aggiungi una linea vuota
        Paragraph lineBreak = new Paragraph("\n");
        document.add(lineBreak);

        Font fontDomande = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);
        Font fontRisposte = FontFactory.getFont(FontFactory.HELVETICA, 12);

        int i = 1;
        for (QuestionEntitie domanda : domande) {
            Paragraph pDomanda = new Paragraph(i + ") " + domanda.getDomanda(), fontDomande);
            document.add(pDomanda);

            PdfPTable tableRisposte = new PdfPTable(1);
            tableRisposte.setWidthPercentage(100);
            int r = 1;
            for (AnswerEntitie risposta : domanda.getRisposte()) {

                List<AnswerEntitie> answerEntities = answerRepository.findAnswersByQuestionId(domanda.getId());
                boolean segnaCorretta = risposta.getCorretto() != null;

                Paragraph pRisposta = new Paragraph();

                // Aggiungi la risposta data "X"
                String strCorretto = segnaCorretta ? "[X] " : "[ ]  ";
                Chunk chunkX = new Chunk(strCorretto, new Font(Font.HELVETICA, 8));
                pRisposta.add(chunkX);


                // Aggiungi il numero della risposta e chiudi la parentesi come testo normale
                Chunk chunkNumero = new Chunk(String.valueOf(r) + ")", fontRisposte);
                pRisposta.add(chunkNumero);

                // Aggiungi il testo della risposta
                pRisposta.add(new Chunk(" " + risposta.getRisposta(), fontRisposte));

                PdfPCell cellRisposta = new PdfPCell(pRisposta);
                cellRisposta.setBorder(PdfPCell.NO_BORDER);

                r++;
                tableRisposte.addCell(cellRisposta);
            }

            // Gestisci le risposte corrette
            if (domanda.getCorrette() != null && !domanda.getCorrette().isEmpty()) {
                StringBuilder risposteCorretteBuilder = new StringBuilder("Risposta corretta: ");
                for (CorrectAnswerEntitie corretta : domanda.getCorrette()) {
                    if (risposteCorretteBuilder.length() > 19) { // 19 è la lunghezza di "Risposta corretta: "
                        risposteCorretteBuilder.append(", ");
                    }
                    risposteCorretteBuilder.append(corretta.getCorretta());
                }
                PdfPCell cellCorretta = new PdfPCell(new Phrase(risposteCorretteBuilder.toString(), fontRisposte));
                cellCorretta.setBorder(PdfPCell.NO_BORDER);
                tableRisposte.addCell(cellCorretta);
            }
            i++;
            document.add(tableRisposte);
            document.add(new Paragraph(" ")); // Aggiunge uno spazio tra le domande
        }

        document.close();
    }

    public void generateLatestUserPdfQuestionario(AnswerModel answerDTO) {
        // Trova l'ultimo UserFile per l'utente


        /*
        UserFileEntitie userFile = userFileRepository.findFirstByUsernameOrderByIdDesc(username)
                .orElseThrow(() -> new RuntimeException("Nessun file trovato per l'utente: " + username));
*/
        // Trova tutte le domande associate a questo UserFile
        String username = answerDTO.getUsername();
        String datetime = new SimpleDateFormat(Constants.UNIQUE_TIME_FORMAT).format(new Date());
        String datefine = new SimpleDateFormat(Constants.UNIQUE_TIME_FORMAT2).format(new Date());

        UserFileEntitie userFile = userFileRepository.findFirstByUsernameOrderByIdDesc(username)
                .orElseThrow(() -> new RuntimeException("Nessun file trovato per l'utente: " + username));
        

        List<AttemptEntitie> attemptEntities = attemptRepository.findLatestAttemptByUserName(username);
        long attemptId = 0;
        String dataInizio = "";
        if (attemptEntities != null && !attemptEntities.isEmpty()){
            attemptId = attemptEntities.get(0).getId();

            SimpleDateFormat sdf = new SimpleDateFormat(Constants.UNIQUE_TIME_FORMAT2);
            dataInizio = sdf.format(attemptEntities.get(0).getAttemptDate());
        }

        String filePath = txtRes + Constants.QUESTIONS_PREFIX_RISPOSTE + "/" +
                answerDTO.getAula() + "/" +
                answerDTO.getClasse() + "/" +
                answerDTO.getSezione() + "/" +
                answerDTO.getArgomento() + "/" +
                datetime + "_" + username + ".pdf";

        List<QuestionEntitie> domande = questionRepository.findByAttemptEntitieId(attemptId);


        String scorePartial;
        String scoreTotal;
        String score;

        List<ScoreEntitie> scores = scoreRepository.findByUsernameAndAttemptId(username, 1L);

        if (scores != null && !scores.isEmpty()) {
            scorePartial = String.valueOf(scores.get(0).getScoreValue());
            scoreTotal = String.valueOf(scores.get(0).getTotalQuestions());
            score = scorePartial + " / " + scoreTotal;
        } else {
            score = "0 / 0";
        }

        // Genera il PDF
        try {
            generatePdfQuestionario(domande, filePath, username, dataInizio, datefine, score);
        } catch (DocumentException | IOException e) {
            throw new RuntimeException("Errore nella generazione del PDF", e);
        }
    }
}
