package org.duckdns.vrscuola.config;

import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

@Component
public class BootstrapPerformanceTracker implements ApplicationListener<ContextRefreshedEvent> {

    private long startTime;
    private long endTime;

    public BootstrapPerformanceTracker() {
        this.startTime = System.currentTimeMillis(); // Or capture this even earlier if needed
    }

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        this.endTime = System.currentTimeMillis();
    }

    public long getBootstrapTime() {
        return this.endTime - this.startTime;
    }
}
