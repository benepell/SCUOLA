package it.vrscuola.scuola.utilities;

public interface Constants {
    String UNIQUE_TIME_FORMAT = "yyyyMMdd_HHmmss";

    String EVENT_LOG_DATE_FORMAT = "dd/MM/yyyy HH:mm:ss";
    String PATH_RESOURCE_DIR = "/var/www/html/risorse/files/";

 //   String PATH_RESOURCE_DIR = "D:\\";
    String SEPARATOR = "/";
    String RESOURCE_TRASH = ".trash";
    String RESOURCE_TMB= ".tmb";

    String CONNECTED_IN_PENDING = "in_pending";
    String CONNECTED_IN_CONNECTED = "connected";
    String CONNECTED_IN_DISCONNECTED = "disconnected";
    String CONNECTED_IN_RECONNECTED = "reconnected";
    String CONNECTED_IN_RECONNECTING = "reconnecting";
    String CONNECTED_IN_RECONNECTING_ERROR = "reconnecting_error";

   String EVENT_LOG_IN = "accesso";
   String EVENT_LOG_OUT = "uscita";
   String EVENT_LOG_RECONNECT = "riconnessione";
   String EVENT_LOG_RECONNECT_ERROR = "errore riconnessione";
   String EVENT_LOG_CONNECTING = "connessione";
   String EVENT_LOG_DISCONNECT = "disconnessione";
   String EVENT_LOG_ADD_VISOR = "aggiungi visore";
   String EVENT_LOG_REMOVE_VISOR = "rimuovi visore";
   String EVENT_LOG_ENABLE_VISOR = "abilita visore";
   String EVENT_LOG_DISABLE_VISOR = "disabilita visore";
   String EVENT_LOG_ADD_STUDENT = "aggiungi studente";
   String EVENT_LOG_REMOVE_STUDENT = "rimuovi studente";
   String EVENT_LOG_ADD_TEACHER = "aggiungi docente";
   String EVENT_LOG_REMOVE_TEACHER = "rimuovi docente";
   String EVENT_LOG_ADD_CLASS = "aggiungi classe";
   String EVENT_LOG_REMOVE_CLASS = "rimuovi classe";
   String EVENT_LOG_ADD_COURSE = "aggiungi corso";
   String EVENT_LOG_REMOVE_COURSE = "rimuovi corso";
   String EVENT_LOG_CLOSE_ALL_VISOR = "chiudi tutti visori";
   String EVENT_LOG_CHECK_RES = "verifica risorse";
   String EVENT_LOG_CHECK_INFO = "verifica informazioni";

   String PREFIX_CLASSROOM = "aula";

    String CONFIG_EVENT_LOG_PDF = "event_log_pdf";
    int BATTERY_LEVEL_MAX = 100;
    int BATTERY_LEVEL = 20;
}
