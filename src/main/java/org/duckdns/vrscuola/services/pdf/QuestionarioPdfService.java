package org.duckdns.vrscuola.services.pdf;

import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfWriter;

import org.duckdns.vrscuola.entities.questions.AnswerEntitie;
import org.duckdns.vrscuola.entities.questions.CorrectAnswerEntitie;
import org.duckdns.vrscuola.entities.questions.QuestionEntitie;
import org.duckdns.vrscuola.repositories.questions.QuestionRepository;
import org.duckdns.vrscuola.repositories.questions.UserFileRepository;
import org.duckdns.vrscuola.services.utils.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.awt.*;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

@Service
public class QuestionarioPdfService {

    @Value("${school.resource}")
    private String resource;

    @Autowired
    private MessageService messageService;
    @Autowired
    private UserFileRepository userFileRepository;

    @Autowired
    private QuestionRepository questionRepository;

    public void generatePdfQuestionario(List<QuestionEntitie> domande, String filePath, String user, String dataInizio, String dataFine) throws DocumentException, IOException {

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
                messageService.getMessage("pdf.test-data-inizio") + ": " + dataInizio + " - " +
                messageService.getMessage("pdf.test-data-fine") + ": " + dataFine
                , FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 11));
        p.setAlignment(Paragraph.ALIGN_CENTER);

        document.add(p);

        Font fontDomande = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);
        Font fontRisposte = FontFactory.getFont(FontFactory.HELVETICA, 12);

        for (QuestionEntitie domanda : domande) {
            Paragraph pDomanda = new Paragraph(domanda.getDomanda(), fontDomande);
            document.add(pDomanda);

            PdfPTable tableRisposte = new PdfPTable(1);
            tableRisposte.setWidthPercentage(100);
            for (AnswerEntitie risposta : domanda.getRisposte()) {
                PdfPCell cellRisposta = new PdfPCell(new Phrase(risposta.getRisposta(), fontRisposte));
                cellRisposta.setBorder(PdfPCell.NO_BORDER);
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

            document.add(tableRisposte);
            document.add(new Paragraph(" ")); // Aggiunge uno spazio tra le domande
        }

        document.close();
    }

    public void generateLatestUserPdfQuestionario(String username, String filePath, String dataInizio, String dataFine) {
        // Trova l'ultimo UserFile per l'utente
        /*
        UserFileEntitie userFile = userFileRepository.findFirstByUsernameOrderByIdDesc(username)
                .orElseThrow(() -> new RuntimeException("Nessun file trovato per l'utente: " + username));
*/
        // Trova tutte le domande associate a questo UserFile
        // List<QuestionEntitie> domande = questionRepository.findByUserFileEntitieId(userFile.getId());
        List<QuestionEntitie> domande = questionRepository.findByAttemptEntitieId(1L);


        // Genera il PDF
        try {
            generatePdfQuestionario(domande, filePath, username, dataInizio, dataFine);
        } catch (DocumentException | IOException e) {
            throw new RuntimeException("Errore nella generazione del PDF", e);
        }
    }
}
