package org.duckdns.vrscuola.services.pdf;


import org.duckdns.vrscuola.entities.questions.ScoreEntitie;
import org.duckdns.vrscuola.services.utils.MessageService;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtils;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.data.category.DefaultCategoryDataset;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class ChartToPDF {

    @Value("${school.resource.tmp}")
    private String tmpRes;

    @Autowired
    private MessageService messageService;

    public String generateBarChartImage(List<ScoreEntitie> scores) throws IOException {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();

        for (ScoreEntitie score : scores) {
            double percentage = score.getTotalQuestions() > 0 ?
                    (double) score.getScoreValue() / score.getTotalQuestions() * 100 : 0;
            dataset.addValue(percentage, messageService.getMessage("pdf.test-data.perc"), score.getUsername());
        }

        JFreeChart barChart = ChartFactory.createBarChart(
                messageService.getMessage("pdf.test-data.percent.allievo"),
                messageService.getMessage("pdf.test-data.allievo"),
                messageService.getMessage("pdf.test-data.perc"),
                dataset,
                PlotOrientation.VERTICAL,
                true, true, false);

        CategoryPlot plot = barChart.getCategoryPlot();
        BarRenderer renderer = (BarRenderer) plot.getRenderer();

        // Imposta la scala dell'asse Y a 100%
        NumberAxis yAxis = (NumberAxis) plot.getRangeAxis();
        yAxis.setRange(0.0, 100.0);

        // Imposta il colore blu per tutte le serie
        renderer.setSeriesPaint(0, new Color(10, 80, 255, 150));

        String filePath = tmpRes + "chart.png";
        ChartUtils.saveChartAsPNG(new File(filePath), barChart, 500, 300);

        return filePath;
    }
}
