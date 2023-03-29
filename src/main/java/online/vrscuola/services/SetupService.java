package online.vrscuola.services;

import online.vrscuola.models.SetupModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.servlet.ServletContext;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Map;

@Service
public class SetupService {

    @Value("${school.setup.file}")
    private String configFile;

    @Autowired
    private ServletContext context;

    // scrive un file di configurazione a partire dal modello di setupModel
    public void writeConfig(SetupModel setupModel) {
        try {
            String webInfPath = context.getRealPath("/scripts/");
            String filePath = webInfPath +  configFile;

            // file di testo in modalità scrittura
            BufferedWriter writer = new BufferedWriter(new FileWriter(configFile));

            // tutti i campi dell'oggetto "SetupModel"
            Map<String, String> fields = setupModel.toMap();

            // aggiungi riga bash
            writer.write("#!/bin/bash" + "\n");

            // riga vuota
            writer.write( "\n");

            // mapping nel file di testo
            for (Map.Entry<String, String> entry : fields.entrySet()) {
                String key = entry.getKey().replaceAll("([A-Z]+)", "_$1").toUpperCase();
                String value = entry.getValue();
                writer.write(key + "=" + '"' + value + '"' + "\n");
            }

            // chiudi file di testo
            writer.close();
        } catch (
                IOException e) {
            e.printStackTrace();
        }
    }
}
