package org.duckdns.vrscuola.services.config;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import org.duckdns.vrscuola.entities.config.SessionEntity;
import org.duckdns.vrscuola.repositories.config.SessionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.time.Instant;
import java.util.Map;

@Service
public class SessionDBService {

    private final SessionRepository sessionRepository;
    private final HttpSession httpSession;

    @Autowired
    public SessionDBService(SessionRepository sessionRepository, HttpSession httpSession) {
        this.sessionRepository = sessionRepository;
        this.httpSession = httpSession;
    }

    @Transactional
    public void setAttribute(String name, Object value) {
        String username = getUsername();
        String lab = getLab();

        if ( !existUsername() || !existLab()) return;

        String jsonValue = serializeObjectToJson(value);

        Boolean exists = sessionRepository.exists(name, username, lab);

        if (exists) {
            sessionRepository.setAttribute(name, jsonValue, username, lab, Instant.now());
        } else {
            SessionEntity sessionEntity = new SessionEntity();
            sessionEntity.setName(name);
            sessionEntity.setValue(jsonValue); // Salvato come JSON
            sessionEntity.setUsername(username);
            sessionEntity.setLab(lab);
            sessionEntity.setSessionDate(Instant.now());
            sessionRepository.save(sessionEntity);
        }
    }

    @Transactional(readOnly = true)
    public void removeAttribute(String name) {
        String username = getUsername();
        String lab = getLab();

        if ( !existUsername() || !existLab()) return;

        sessionRepository.removeAttribute(name, username, lab);
    }

    @Transactional(readOnly = true)
    public Object getAttribute(String name, Object typeParameter) {
        String username = getUsername();
        String lab = getLab();

        if ( !existUsername() || !existLab()) return null;

        String jsonValue = sessionRepository.getAttribute(name, username, lab);
        if (jsonValue == null) {
            // Ritorna null o un valore di default appropriato se il jsonValue è null
            return null;
        }
        if (typeParameter instanceof Class<?>) {
            return deserializeJsonToObject(jsonValue, (Class<?>) typeParameter);
        } else if (typeParameter instanceof TypeReference) {
            return deserializeJsonToObject(jsonValue, (TypeReference<?>) typeParameter);
        } else {
            throw new IllegalArgumentException("Invalid type parameter provided.");
        }
    }

    public void modifyAttribute(String name, String keyToRemove) {
        String username = getUsername();
        String lab = getLab();

        if ( !existUsername() || !existLab()) return;

        ObjectMapper mapper = new ObjectMapper();
        // Deserializza il valore JSON in una mappa
        TypeReference<Map<String, String>> typeRef = new TypeReference<Map<String, String>>() {};
        Map<String, String> map = (Map<String, String>) getAttribute(name, typeRef);

        // Rimuove la chiave specificata, se presente
        if (map.containsKey(keyToRemove)) {
            map.remove(keyToRemove);

            // Aggiorna il record nel database con il nuovo valore JSON
            setAttribute(name,map);
        }

    }

        private String serializeObjectToJson(Object value) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            return mapper.writeValueAsString(value);
        } catch (JsonProcessingException e) {
            throw new RuntimeException("Error during object to JSON conversion", e);
        }
    }

    private <T> T deserializeJsonToObject(String json, Class<T> valueType) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            return mapper.readValue(json, valueType);
        } catch (IOException e) {
            throw new RuntimeException("Error during JSON to object conversion", e);
        }
    }

    // Metodo sovraccaricato per TypeReference
    private <T> T deserializeJsonToObject(String json, TypeReference<T> typeReference) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            return mapper.readValue(json, typeReference);
        } catch (IOException e) {
            throw new RuntimeException("Error during JSON to object conversion", e);
        }
    }

    public boolean existUsername() {
        String username = getUsername();
        return !(username == null || username.isEmpty());
    }

    public boolean existLab() {
        String lab = getLab();
        return !(lab == null || lab.isEmpty());
    }

    private String getUsername() {
        return httpSession.getAttribute("main_username") != null ? (String) httpSession.getAttribute("main_username") : null;
    }

    private String getLab() {
        return httpSession.getAttribute("classroomSelected") != null ? (String) httpSession.getAttribute("classroomSelected") : null;
    }

    /*
    Per ottenere una String:
    String value = (String) sessionDBService.getAttribute("chiave", String.class);

    Per ottenere un String[]:
    String[] values = (String[]) sessionDBService.getAttribute("chiaveArray", String[].class);

    Per ottenere una Map<String, String>:
    TypeReference<Map<String, String>> typeRef = new TypeReference<Map<String, String>>() {};
    Map<String, String> map = (Map<String, String>) sessionDBService.getAttribute("chiaveMappa", typeRef);

    Per ottenere un List<String>
    TypeReference<List<String>> typeRef2 = new TypeReference<List<String>>() {};
    List<String> list = (List<String>) sessionDBService.getAttribute("chiaveMappa", typeRef2);

    */
}
