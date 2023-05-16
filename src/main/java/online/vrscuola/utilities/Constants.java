package online.vrscuola.utilities;

public interface Constants {
    String UNIQUE_TIME_FORMAT = "yyyyMMdd_HHmmss";
    String PATH_RESOURCE_DIR = "/var/www/html/risorse/files/";

 //   String PATH_RESOURCE_DIR = "D:\\";
    String RESOURCE_TRASH = ".trash";
    String RESOURCE_TMB= ".tmb";

    String CONNECTED_IN_PENDING = "in_pending";
    String CONNECTED_IN_CONNECTED = "connected";
    String CONNECTED_IN_DISCONNECTED = "disconnected";
    String CONNECTED_IN_RECONNECTED = "reconnected";
    String CONNECTED_IN_RECONNECTING = "reconnecting";
    String CONNECTED_IN_RECONNECTING_ERROR = "reconnecting_error";

    String EVENT_LOG_IN = "login";
    String EVENT_LOG_OUT = "logout";
    String EVENT_LOG_RECONNECT = "reconnect";
    String EVENT_LOG_RECONNECT_ERROR = "reconnect_error";
    String EVENT_LOG_CONNECTING = "connecting";
    String EVENT_LOG_DISCONNECT = "disconnect";
    String EVENT_LOG_ADD_VISOR = "add_visor";
    String EVENT_LOG_REMOVE_VISOR = "remove_visor";
    String EVENT_LOG_ENABLE_VISOR = "add_visor";
    String EVENT_LOG_DISABLE_VISOR = "remove_visor";
    String EVENT_LOG_ADD_STUDENT = "add_student";
    String EVENT_LOG_REMOVE_STUDENT = "remove_student";
    String EVENT_LOG_ADD_TEACHER = "add_teacher";
    String EVENT_LOG_REMOVE_TEACHER = "remove_teacher";
    String EVENT_LOG_ADD_CLASS = "add_class";
    String EVENT_LOG_REMOVE_CLASS = "remove_class";
    String EVENT_LOG_ADD_COURSE = "add_course";
    String EVENT_LOG_REMOVE_COURSE = "remove_course";
    String EVENT_LOG_CLOSE_ALL_VISOR = "close_all_visor";
    String EVENT_LOG_CHECK_RES = "resource_check";
    String EVENT_LOG_CHECK_INFO = "info_check";

    int BATTERY_LEVEL_MAX = 100;
    int BATTERY_LEVEL = 15;
}
