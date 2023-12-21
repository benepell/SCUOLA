/**
 * Copyright (c) 2023, Benedetto Pellerito
 * Email: benedettopellerito@gmail.com
 * GitHub: https://github.com/benepell
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.duckdns.vrscuola.services.pdf;


import java.awt.Color;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
import com.lowagie.text.Image;
import org.duckdns.vrscuola.models.UserInfoModel;
import org.duckdns.vrscuola.repositories.devices.VRDeviceConnectivityRepository;
import org.duckdns.vrscuola.repositories.devices.VRDeviceDetailConnectivityRepository;
import org.duckdns.vrscuola.services.utils.MessageService;
import org.duckdns.vrscuola.utilities.Constants;
import org.duckdns.vrscuola.utilities.Utilities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class UsoVisorePdfService {

    @Value("${school.resource.ses}")
    private String resourceSes;

    @Autowired
    private VRDeviceConnectivityRepository vrRepository;

    @Autowired
    private VRDeviceDetailConnectivityRepository vrDetailRepository;

    @Autowired
    private MessageService messageService;

    private List<UserInfoModel> listUsers;

    private String classe;
    private String sezione;

    public void export(HttpServletResponse response) throws DocumentException, IOException {
        Document document = new Document(PageSize.A4);
        PdfWriter.getInstance(document, response.getOutputStream());

        document.open();

        String percorsoFile = resourceSes + "intestazione.png";
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

        Paragraph p = new Paragraph(messageService.getMessage("pdf.user.title"), font);
        p.setAlignment(Paragraph.ALIGN_CENTER);

        document.add(p);

        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100f);
        table.setWidths(new float[]{3.0f, 3.0f, 2.0f, 2.0f, 1.5f});
        table.setSpacingBefore(10);

        writeTableHeader(table);
        writeTableData(table);

        document.add(table);

        document.close();

    }

    public void save() throws DocumentException, IOException {

        boolean isError = !init();

        if (isError) {
            return;
        }

        Document document = new Document(PageSize.A4);
        try {
            Utilities utility = new Utilities();
            String fileName = resourceSes + classe + Constants.SEPARATOR + sezione + Constants.SEPARATOR + utility.strTime() + ".pdf";

            // Controlla se la directory "classe" esiste, altrimenti creala
            File classeDir = new File(resourceSes + classe);
            if (!classeDir.exists()) {
                classeDir.mkdir();
            }

            // Controlla se la directory "sezione" esiste, altrimenti creala
            File sezioneDir = new File(resourceSes + classe + Constants.SEPARATOR + sezione);
            if (!sezioneDir.exists()) {
                sezioneDir.mkdir();
            }

            File filex = new File(fileName);
            if (!filex.exists()) {
                filex.getParentFile().mkdirs(); // Crea le directory se non esistono
                filex.createNewFile(); // Crea il file
            }

            PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(filex));

            document.open();

            String percorsoFile = resourceSes + "intestazione.png";
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

            Paragraph p = new Paragraph(messageService.getMessage("pdf.user.title"), font);
            p.setAlignment(Paragraph.ALIGN_CENTER);

            document.add(p);

            PdfPTable table = new PdfPTable(6);
            table.setWidthPercentage(100f);
            table.setWidths(new float[]{2.4f, 2.4f, 1.5f, 1.5f, 2.4f, 1.3f});
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

    private boolean init() {
        List<Object[]> listUsers = vrRepository.findAllUsername();
        if (listUsers == null || listUsers.isEmpty()) {
            return false; // lista vuota
        }
        List<UserInfoModel> list = new ArrayList<>();
        String classe = "";
        String sezione = "";
        for (Object[] userData : listUsers) {
            String username = (String) userData[3];
            String[] args = username.split("-");
            classe = args[0];
            sezione = args[1].toUpperCase();
            String nome = args[2].substring(0, 1).toUpperCase() + args[2].substring(1).toLowerCase();
            String cognome = args[3].substring(0, 1).toUpperCase() + args[3].substring(1).toLowerCase();
            String materia = (String) userData[6];
            if (materia != null && !materia.isEmpty()) {
                materia = materia.substring(0, 1).toUpperCase() + materia.substring(1).toLowerCase();
            }
            Instant startDate = vrDetailRepository.findStartDate(username);
            Instant endDate = Instant.now();
            Duration duration = Duration.between(startDate, endDate);
            long minutesElapsed = duration.toMinutes();
            String strMinutesElapsed = minutesElapsed > 0 ? String.valueOf(minutesElapsed) : messageService.getMessage("pdf.user.empty");

            list.add(new UserInfoModel(nome, cognome, classe, sezione, materia, strMinutesElapsed));
        }
        this.classe = classe;
        this.sezione = sezione;
        this.listUsers = list;

        return true;
    }

    private void writeTableHeader(PdfPTable table) {

        PdfPCell cell = new PdfPCell();
        cell.setBackgroundColor(Color.GRAY);
        cell.setPadding(5);

        Font font = FontFactory.getFont(FontFactory.HELVETICA);
        font.setColor(Color.WHITE);

        cell.setPhrase(new Phrase(messageService.getMessage("pdf.user.nome"), font));
        table.addCell(cell);

        cell.setPhrase(new Phrase(messageService.getMessage("pdf.user.cognome"), font));
        table.addCell(cell);

        cell.setPhrase(new Phrase(messageService.getMessage("pdf.user.classe"), font));
        table.addCell(cell);

        cell.setPhrase(new Phrase(messageService.getMessage("pdf.user.sezione"), font));
        table.addCell(cell);

        cell.setPhrase(new Phrase(messageService.getMessage("pdf.user.argomento"), font));
        table.addCell(cell);

        cell.setPhrase(new Phrase(messageService.getMessage("pdf.user.durata"), font));
        table.addCell(cell);
    }

    private void writeTableData(PdfPTable table) {
        for (UserInfoModel user : listUsers) {
            table.addCell(String.valueOf(user.getNome()));
            table.addCell(user.getCognome());
            table.addCell(user.getClasse());
            table.addCell(user.getSezione());
            table.addCell(user.getArgomento());
            table.addCell(user.getDurata());
        }
    }

}

