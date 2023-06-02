package online.vrscuola.models;

import java.time.Instant;

public class EventLogInfoModel {
    private Long id;
    private String username;
    private String event;
    private Instant eventDate;
    private String note;

    public EventLogInfoModel() {
    }
    public EventLogInfoModel(Long id, String username, String event, Instant eventDate, String note) {
        this.id = id;
        this.username = username;
        this.event = event;
        this.eventDate = eventDate;
        this.note = note;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEvent() {
        return event;
    }

    public void setEvent(String event) {
        this.event = event;
    }

    public Instant getEventDate() {
        return eventDate;
    }

    public void setEventDate(Instant eventDate) {
        this.eventDate = eventDate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
}
