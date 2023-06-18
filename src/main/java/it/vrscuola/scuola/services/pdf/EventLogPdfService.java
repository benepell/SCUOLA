package it.vrscuola.scuola.services.pdf;


import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import it.vrscuola.scuola.entities.log.EventLogEntitie;
import it.vrscuola.scuola.utilities.Utilities;
import it.vrscuola.scuola.models.EventLogInfoModel;
import it.vrscuola.scuola.repositories.log.EventLogRepository;
import it.vrscuola.scuola.services.config.ConfigService;
import it.vrscuola.scuola.services.utils.MessageService;
import it.vrscuola.scuola.utilities.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.awt.*;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;

@Service
public class EventLogPdfService {

    @Value("${school.resource.elog}")
    private String resourceElog;

    @Autowired
    private EventLogRepository eRepository;

    @Autowired
    private MessageService messageService;

    @Autowired
    private ConfigService configService;

    private List<EventLogInfoModel> listLogs;

    public CompletableFuture<Void> saveAsync() {
        return CompletableFuture.runAsync(this::save);
    }

    private List<EventLogInfoModel> init() {
        Long id = configService.getEventLogPdf() != null ? Long.valueOf(configService.getEventLogPdf()) : 1;
        Long finalId = 0L;
        List<EventLogEntitie> ls = eRepository.findAll();

        if (ls == null || ls.isEmpty()) {
            return null; // lista vuota
        }

        List<EventLogInfoModel> list = new ArrayList<>();
        for (EventLogEntitie data : ls) {
            Long idx = data.getId();
            if (idx > id) {
                list.add(new EventLogInfoModel(idx, data.getUsername(), data.getEvent(), data.getEventDate(), data.getNote()));
                finalId = idx;
            }
        }
        if (finalId > 0) {
            configService.eventLogPdf(String.valueOf(finalId));
        }

        return list;
    }

    protected void writeTableData(PdfPTable table) {
        for (EventLogInfoModel e : listLogs) {
            table.addCell(String.valueOf(e.getId()));
            // Format the date in the format dd/MM/yyyy HH:mm:ss
            Instant instant = e.getEventDate();
            LocalDateTime ldt = LocalDateTime.ofInstant(instant, ZoneId.systemDefault());
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern(Constants.EVENT_LOG_DATE_FORMAT);
            table.addCell(ldt.format(formatter));
            table.addCell(e.getUsername());
            table.addCell(e.getEvent());
            table.addCell(e.getNote());
        }
    }

    public void save() {
        listLogs = init();

        if (listLogs == null || listLogs.isEmpty()) {
            return;
        }

        Document document = new Document(PageSize.A4);
        try {
            Utilities utility = new Utilities();
            String fileName = resourceElog + utility.strTime() + ".pdf";

            PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(fileName));

            document.open();

            String percorsoFile = resourceElog + "intestazione.png";
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

            Paragraph p = new Paragraph(messageService.getMessage("pdf.log.title"), font);
            p.setAlignment(Paragraph.ALIGN_CENTER);

            document.add(p);

            PdfPTable table = new PdfPTable(5);
            table.setWidthPercentage(100f);
            table.setWidths(new float[]{1.0f, 2.0f, 2.0f, 3.0f, 3.5f});
            table.setSpacingBefore(10);

            writeTableData(table);

            document.add(table);

            document.close();
            writer.close();
        } catch (IOException | DocumentException e) {
            e.printStackTrace();
        }
    }
}