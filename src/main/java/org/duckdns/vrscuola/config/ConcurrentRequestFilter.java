package org.duckdns.vrscuola.config;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import java.io.IOException;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;

import org.springframework.stereotype.Component;

@Component
public class ConcurrentRequestFilter implements Filter {
    private final AtomicInteger requestsThisSecond = new AtomicInteger(0);
    private final ConcurrentLinkedQueue<Integer> requestsLast10Seconds = new ConcurrentLinkedQueue<>();
    private final ConcurrentLinkedQueue<Integer> requestsLast30Seconds = new ConcurrentLinkedQueue<>();
    private final ConcurrentLinkedQueue<Integer> requestsLast60Seconds = new ConcurrentLinkedQueue<>();

    // Scheduler per aggiornare le code ogni secondo
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

    @Override
    public void init(FilterConfig filterConfig) {
        scheduler.scheduleAtFixedRate(() -> {
            // Aggiorna le code ogni secondo con il conteggio delle richieste dell'ultimo secondo
            int requestsLastSecond = requestsThisSecond.getAndSet(0); // Prende il numero di richieste dell'ultimo secondo e resetta il contatore
            updateQueue(requestsLast10Seconds, 10, requestsLastSecond);
            updateQueue(requestsLast30Seconds, 30, requestsLastSecond);
            updateQueue(requestsLast60Seconds, 60, requestsLastSecond);
        }, 0, 1, TimeUnit.SECONDS);
    }

    private void updateQueue(ConcurrentLinkedQueue<Integer> queue, int maxSize, int currentValue) {
        if (queue.size() >= maxSize) {
            queue.poll(); // Rimuove l'elemento più vecchio se la coda è piena
        }
        queue.offer(currentValue); // Aggiunge il valore corrente alla coda
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        requestsThisSecond.incrementAndGet(); // Incrementa per ogni richiesta
        try {
            chain.doFilter(request, response);
        } finally {
            // Non necessario decrementare qui poiché tracciamo le richieste per secondo, non le richieste attive
        }
    }

    @Override
    public void destroy() {
        scheduler.shutdownNow(); // Termina lo scheduler all'eliminazione del filtro
    }

    public int getActiveRequests() {
        return requestsThisSecond.get();
    }

    public int getMaxRequestsLast10Seconds() {
        return requestsLast10Seconds.stream().max(Integer::compare).orElse(0);
    }

    public int getMaxRequestsLast30Seconds() {
        return requestsLast30Seconds.stream().max(Integer::compare).orElse(0);
    }

    public int getMaxRequestsLast60Seconds() {
        return requestsLast60Seconds.stream().max(Integer::compare).orElse(0);
    }
}
