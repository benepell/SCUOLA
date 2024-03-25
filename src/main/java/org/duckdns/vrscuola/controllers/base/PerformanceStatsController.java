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

        stats.put("heapMemoryUsed", heapMemoryUsage.getUsed());
        stats.put("heapMemoryMax", heapMemoryUsage.getMax());
        stats.put("nonHeapMemoryUsed", nonHeapMemoryUsage.getUsed());
        stats.put("nonHeapMemoryMax", nonHeapMemoryUsage.getMax());


        // Accessi contemporanei e statistiche negli ultimi intervalli di tempo
        stats.put("activeRequests", concurrentRequestFilter.getActiveRequests());
        stats.put("maxRequestsLast10Seconds", concurrentRequestFilter.getMaxRequestsLast10Seconds());
        stats.put("maxRequestsLast30Seconds", concurrentRequestFilter.getMaxRequestsLast30Seconds());
        stats.put("maxRequestsLast60Seconds", concurrentRequestFilter.getMaxRequestsLast60Seconds());


        return stats;
    }
}
