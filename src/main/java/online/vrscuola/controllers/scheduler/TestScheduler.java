package online.vrscuola.controllers.scheduler;

import org.springframework.scheduling.annotation.Scheduled;

public class TestScheduler {
    @Scheduled(fixedDelay = 60*60*1000)
    public void testSched() {
        System.out.println("Schedulato");
    }
}
