package org.duckdns.vrscuola.controllers.base;

import org.duckdns.vrscuola.config.BootstrapPerformanceTracker;
import org.duckdns.vrscuola.config.ConcurrentRequestFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryUsage;
import java.util.HashMap;
import java.util.Map;

@RestController
public class PerformanceStatsController {

    private final BootstrapPerformanceTracker tracker;
    private final ConcurrentRequestFilter concurrentRequestFilter;

    @Autowired
    public PerformanceStatsController(BootstrapPerformanceTracker tracker, ConcurrentRequestFilter concurrentRequestFilter) {
        this.tracker = tracker;
        this.concurrentRequestFilter = concurrentRequestFilter;
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
}
