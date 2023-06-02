package online.vrscuola.services.pdf;


import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import online.vrscuola.entities.log.EventLog;
import online.vrscuola.models.EventLogInfoModel;
import online.vrscuola.models.UserInfoModel;
import online.vrscuola.repositories.devices.VRDeviceConnectivityRepository;
import online.vrscuola.repositories.devices.VRDeviceDetailConnectivityRepository;
import online.vrscuola.repositories.log.EventLogRepository;
import online.vrscuola.services.utils.MessageService;
import online.vrscuola.utilities.Constants;
import online.vrscuola.utilities.Utilities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.Duration;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Service
public class EventLogPdfService {

    @Value("${school.resource.elog}")
    private String resourceElog;

    @Autowired
    private EventLogRepository eRepository;

    @Autowired
    private MessageService messageService;

    private List<EventLogInfoModel> listLogs;

    public void save() throws DocumentException, IOException {

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

            writeTableHeader(table);
            writeTableData(table);

            document.add(table);

            document.close();
            writer.close();

        } catch (IOException | DocumentException e) {
            e.printStackTrace();

        }

    }

    private List<EventLogInfoModel> init() {
        List<EventLog> ls= eRepository.findAll();
        if (ls == null || ls.isEmpty()) {
            return null; // lista vuota
        }
        List<EventLogInfoModel> list = new ArrayList<>();
        for (EventLog data : ls) {
            list.add(new EventLogInfoModel(data.getId(), data.getUsername(), data.getEvent(), data.getEventDate(), data.getNote()));
        }

        return list;
    }

    private void writeTableHeader(PdfPTable table) {

        PdfPCell cell = new PdfPCell();
        cell.setBackgroundColor(Color.GRAY);
        cell.setPadding(5);

        Font font = FontFactory.getFont(FontFactory.HELVETICA);
        font.setColor(Color.WHITE);

        cell.setPhrase(new Phrase(messageService.getMessage("pdf.log.id"), font));
        table.addCell(cell);

        cell.setPhrase(new Phrase(messageService.getMessage("pdf.log.date"), font));
        table.addCell(cell);

        cell.setPhrase(new Phrase(messageService.getMessage("pdf.log.username"), font));
        table.addCell(cell);

        cell.setPhrase(new Phrase(messageService.getMessage("pdf.log.event"), font));
        table.addCell(cell);

        cell.setPhrase(new Phrase(messageService.getMessage("pdf.log.note"), font));
        table.addCell(cell);
    }

    private void writeTableData(PdfPTable table) {
        for (EventLogInfoModel e : listLogs) {
            table.addCell(String.valueOf(e.getId()));
            // formatto la data nel formato dd/MM/yyyy HH:mm:ss
            Instant instant = e.getEventDate();
            LocalDateTime ldt = LocalDateTime.ofInstant(instant, ZoneId.systemDefault());
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern(Constants.EVENT_LOG_DATE_FORMAT);
            table.addCell(ldt.format(formatter));
            table.addCell(e.getUsername());
            table.addCell(e.getEvent());
            table.addCell(e.getNote());
        }
    }

}

