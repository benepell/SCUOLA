package org.duckdns.vrscuola.controllers.base;

import jakarta.servlet.http.HttpServletResponse;
import org.duckdns.vrscuola.config.BootstrapPerformanceTracker;
import org.duckdns.vrscuola.config.ConcurrentRequestFilter;
import org.duckdns.vrscuola.services.health.OperatingSystemHealthCheckService;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtils;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.jfree.chart.labels.StandardPieSectionLabelGenerator;
import org.jfree.chart.plot.PiePlot;

import java.io.IOException;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryUsage;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;

@RestController
public class PerformanceStatsController {

    private final BootstrapPerformanceTracker tracker;
    private final ConcurrentRequestFilter concurrentRequestFilter;
    private final OperatingSystemHealthCheckService healthCheckService;

    @Autowired
    public PerformanceStatsController(BootstrapPerformanceTracker tracker, ConcurrentRequestFilter concurrentRequestFilter, OperatingSystemHealthCheckService healthCheckService) {
        this.tracker = tracker;
        this.concurrentRequestFilter = concurrentRequestFilter;
        this.healthCheckService = healthCheckService;
    }

    @GetMapping("/performance/stats")
    public Map<String, Object> getBootstrapStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("bootstrapTimeInMillis", tracker.getBootstrapTime());

        // Aggiungi qui l'uso della memoria
        MemoryMXBean memoryMXBean = ManagementFactory.getMemoryMXBean();
        MemoryUsage heapMemoryUsage = memoryMXBean.getHeapMemoryUsage();
        MemoryUsage nonHeapMemoryUsage = memoryMXBean.getNonHeapMemoryUsage();

        double heapMemoryUsedMb = heapMemoryUsage.getUsed() / 1024.0 / 1024.0;
        double heapMemoryMaxMb = heapMemoryUsage.getMax() / 1024.0 / 1024.0;
        double nonHeapMemoryUsedMb = nonHeapMemoryUsage.getUsed() / 1024.0 / 1024.0;
        double nonHeapMemoryMaxMb = nonHeapMemoryUsage.getMax() == -1 ? -1 : nonHeapMemoryUsage.getMax() / 1024.0 / 1024.0;

        // Arrotondamento e formattazione come stringa con due cifre decimali
        stats.put("heapMemoryUsedMb", String.format("%.2f MB", heapMemoryUsedMb));
        stats.put("heapMemoryMaxMb", String.format("%.2f MB", heapMemoryMaxMb));
        stats.put("nonHeapMemoryUsedMb", String.format("%.2f MB", nonHeapMemoryUsedMb));
        stats.put("nonHeapMemoryMaxMb", nonHeapMemoryUsage.getMax() == -1 ? "Unlimited" : String.format("%.2f MB", nonHeapMemoryMaxMb));

        // Accessi contemporanei e statistiche negli ultimi intervalli di tempo
        stats.put("activeRequests", concurrentRequestFilter.getActiveRequests());
        stats.put("maxRequestsLast10Seconds", concurrentRequestFilter.getMaxRequestsLast10Seconds());
        stats.put("maxRequestsLast30Seconds", concurrentRequestFilter.getMaxRequestsLast30Seconds());
        stats.put("maxRequestsLast60Seconds", concurrentRequestFilter.getMaxRequestsLast60Seconds());


        return stats;
    }

    @GetMapping("/performance/memoryUsageChart")
    public void generateMemoryUsageChart(HttpServletResponse response) {
        MemoryMXBean memoryMXBean = ManagementFactory.getMemoryMXBean();
        MemoryUsage heapMemoryUsage = memoryMXBean.getHeapMemoryUsage();
        double heapMemoryUsedMb = heapMemoryUsage.getUsed() / 1024.0 / 1024.0;
        double heapMemoryMaxMb = heapMemoryUsage.getMax() / 1024.0 / 1024.0;

        // Crea il dataset
        DefaultPieDataset dataset = new DefaultPieDataset();
        dataset.setValue("Usata (" + String.format("%.2f MB", heapMemoryUsedMb) + ")", heapMemoryUsedMb);
        dataset.setValue("Libera (" + String.format("%.2f MB", heapMemoryMaxMb - heapMemoryUsedMb) + ")", heapMemoryMaxMb - heapMemoryUsedMb);

        // Crea il grafico
        JFreeChart chart = ChartFactory.createPieChart(
                "Utilizzo Memoria Heap (MB)", // Titolo del grafico
                dataset,
                true, // Legenda
                true,
                false);

        PiePlot plot = (PiePlot) chart.getPlot();
        // Formattatore per le etichette: visualizza il valore numerico e la descrizione
        plot.setLabelGenerator(new StandardPieSectionLabelGenerator("{0}: {1} MB ({2})", new DecimalFormat("0.00"), new DecimalFormat("0.00%")));

        response.setContentType("image/png");
        try {
            ChartUtils.writeChartAsPNG(response.getOutputStream(), chart, 400, 310);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @GetMapping("/performance/requestsChart")
    public void generateRequestStatsChart(HttpServletResponse response) {
        // Ottieni i valori, assicurandoti che siano non negativi
        int activeRequests = Math.max(concurrentRequestFilter.getActiveRequests(), 0);
        int max10s = Math.max(concurrentRequestFilter.getMaxRequestsLast10Seconds(), 0);
        int max30s = Math.max(concurrentRequestFilter.getMaxRequestsLast30Seconds(), 0);
        int max60s = Math.max(concurrentRequestFilter.getMaxRequestsLast60Seconds(), 0);

        DefaultCategoryDataset dataset = new DefaultCategoryDataset();

        // Aggiungi i valori al dataset, che saranno 0 o positivi
        dataset.addValue(activeRequests, "Richieste", "Attive");
        dataset.addValue(max10s, "Richieste", "Ultimi 10s");
        dataset.addValue(max30s, "Richieste", "Ultimi 30s");
        dataset.addValue(max60s, "Richieste", "Ultimi 60s");

        // Crea il grafico a barre
        JFreeChart barChart = ChartFactory.createBarChart(
                "Statistiche Richieste", // Titolo del grafico
                "Intervallo", // Dominio assi
                "Numero di Richieste", // Range assi
                dataset,
                PlotOrientation.VERTICAL,
                true, true, false);

        // Imposta il tipo di contenuto della risposta a "image/png"
        response.setContentType("image/png");

        // Invia il grafico come PNG
        try {
            ChartUtils.writeChartAsPNG(response.getOutputStream(), barChart, 400, 310);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @GetMapping("/performance/diskSpaceChart")
    public void generateDiskSpaceChart(HttpServletResponse response) {
        JSONObject osHealth = healthCheckService.checkOperatingSystem();
        DefaultPieDataset dataset = new DefaultPieDataset();

        // Assumendo che i valori siano in un formato comprensibile, ad es., "10G" per 10 GB
        // Eseguire il parsing per estrarre solo la parte numerica
        String diskSpaceUsedStr = osHealth.optString("disk_space_used", "0G").replaceAll("[^\\d.]", "");
        String diskSpaceAvailableStr = osHealth.optString("disk_space_available", "0G").replaceAll("[^\\d.]", "");
        double diskSpaceUsed = Double.parseDouble(diskSpaceUsedStr);
        double diskSpaceAvailable = Double.parseDouble(diskSpaceAvailableStr);

        // Aggiungere i valori al dataset
        dataset.setValue("Spazio Usato", diskSpaceUsed);
        dataset.setValue("Spazio Disponibile", diskSpaceAvailable);

        // Creare il grafico
        JFreeChart chart = ChartFactory.createPieChart(
                "Spazio su Disco (GB)", // Titolo del grafico
                dataset,
                true, // Legenda
                true,
                false);

        PiePlot plot = (PiePlot) chart.getPlot();
        plot.setLabelGenerator(new StandardPieSectionLabelGenerator("{0}: {1} GB ({2})", new DecimalFormat("0.00"), new DecimalFormat("0.00%")));

        response.setContentType("image/png");
        try {
            ChartUtils.writeChartAsPNG(response.getOutputStream(), chart, 400, 310);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
