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
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.stream.Stream;

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

    public void generateSummaryPdfQuestionario(String filePath) throws DocumentException, IOException {
        // Ottieni la data odierna come stringa nel formato yyyy-MM-dd
        LocalDate today = LocalDate.now();
        String dateAsString = today.toString();

        List<ScoreEntitie> scores = scoreRepository.findScoresByDate(dateAsString);

        Document document = new Document();
        PdfWriter.getInstance(document, new FileOutputStream(filePath));

        document.open();
        // Aggiungi intestazione, immagini, ecc.
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

        Paragraph p = new Paragraph(messageService.getMessage("pdf.test-data.summary"), font);
        p.setAlignment(Paragraph.ALIGN_CENTER);

        document.add(p);

        // Creazione della tabella per i dati 'score'
        PdfPTable table = new PdfPTable(3); // 3 colonne per id, attemptId, scoreValue, totalQuestions, username
        table.setWidthPercentage(100);
        table.setSpacingBefore(10);

        // Aggiungi intestazioni di colonna
        Stream.of(
                messageService.getMessage("pdf.test-data.name"),
                messageService.getMessage("pdf.test-data.score"),
                messageService.getMessage("pdf.test-data.percent")
        ).forEach(columnTitle -> {
            PdfPCell header = new PdfPCell();
            header.setBackgroundColor(Color.LIGHT_GRAY);
            header.setBorderWidth(2);
            header.setPhrase(new Phrase(columnTitle));
            table.addCell(header);
        });

        // Aggiungi dati delle righe
        for (ScoreEntitie score : scores) {
            table.addCell(score.getUsername());
            String str = Integer.toString(score.getScoreValue()) + "/" + Integer.toString(score.getTotalQuestions());
            String perc;
            if (score.getTotalQuestions() > 0) {
                perc = Integer.toString((int) Math.round((double) score.getScoreValue() / score.getTotalQuestions() * 100));
            } else {
                perc = "0";
            }
            table.addCell(str);
            table.addCell(perc + " %");

        }

        document.add(table);

        document.close();
    }

    public void generatePdfQuestionario(List<QuestionEntitie> domande, String filePath, String user, String dataInizio, String dataFine, String score) throws DocumentException, IOException {

        try {
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

            Paragraph p = new Paragraph(messageService.getMessage("pdf.test-data.summary"), font);
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
        } catch (Exception e) {
            throw new RuntimeException("Errore nel file" + e.getMessage(), e);

        }
    }

    public void generateLatestUserPdfQuestionario(AnswerModel answerDTO) {

        // Trova tutte le domande associate a questo UserFile
        String username = answerDTO.getUsername();
        String datetime = new SimpleDateFormat(Constants.UNIQUE_TIME_FORMAT).format(new Date());
        String datetime2 = new SimpleDateFormat(Constants.UNIQUE_TIME_FORMAT3).format(new Date());
        String datefine = new SimpleDateFormat(Constants.UNIQUE_TIME_FORMAT2).format(new Date());

        UserFileEntitie userFile = userFileRepository.findFirstByUsernameOrderByIdDesc(username)
                .orElseThrow(() -> new RuntimeException("Nessun file trovato per l'utente: " + username));


        List<AttemptEntitie> attemptEntities = attemptRepository.findLatestAttemptByUserName(username);
        long attemptId = 0;
        String dataInizio = "";
        if (attemptEntities != null && !attemptEntities.isEmpty()) {
            attemptId = attemptEntities.get(0).getId();

            SimpleDateFormat sdf = new SimpleDateFormat(Constants.UNIQUE_TIME_FORMAT2);
            dataInizio = sdf.format(attemptEntities.get(0).getAttemptDate());
        }

        String filePath = txtRes + Constants.QUESTIONS_PREFIX_RISPOSTE + "/" +
                answerDTO.getAula().toLowerCase() + "/" +
                answerDTO.getClasse().toLowerCase() + "/" +
                answerDTO.getSezione().toLowerCase() + "/" +
                answerDTO.getArgomento().toLowerCase() + "/" +
                datetime + "_" + username + ".pdf";

        List<QuestionEntitie> domande = questionRepository.findByAttemptEntitieId(attemptId);


        String scorePartial;
        String scoreTotal;
        String score;

        List<ScoreEntitie> scores = scoreRepository.findByUsernameAndAttemptId(username, attemptId);

        if (scores != null && !scores.isEmpty()) {
            scorePartial = String.valueOf(scores.get(0).getScoreValue());
            scoreTotal = String.valueOf(scores.get(0).getTotalQuestions());
            score = scorePartial + " / " + scoreTotal;
        } else {
            score = "0 / 0";
        }

        String filePathSummary = txtRes + Constants.QUESTIONS_PREFIX_RISPOSTE + "/" +
                answerDTO.getAula().toLowerCase() + "/" +
                answerDTO.getClasse().toLowerCase() + "/" +
                answerDTO.getSezione().toLowerCase() + "/" +
                answerDTO.getArgomento().toLowerCase() + "/" +
                datetime2 + "_" + Constants.QUESTIONS_PREFIX_REPORT + ".pdf";


        // Genera il PDF
        try {
            generatePdfQuestionario(domande, filePath, username, dataInizio, datefine, score);
            generateSummaryPdfQuestionario(filePathSummary);
        } catch (DocumentException | IOException e) {
            throw new RuntimeException("Errore nella generazione del PDF", e);
        }
    }
}
