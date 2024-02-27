/**
 * Copyright (c) 2023, Benedetto Pellerito
 * Email: benedettopellerito@gmail.com
 * GitHub: https://github.com/benepell
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.duckdns.vrscuola.utilities;

public interface Constants {
    boolean IS_DEBUG = true;

    String UNIQUE_TIME_STD = "yyyy-MM-dd HH:mm:ss";
    String UNIQUE_TIME_FORMAT = "yyyyMMdd_HHmmss";
    String UNIQUE_TIME_FORMAT2 = "dd-MM-yyyy HH:mm";
    String UNIQUE_TIME_FORMAT3 = "dd-MM-yyyy";

    String EVENT_LOG_DATE_FORMAT = "dd/MM/yyyy HH:mm:ss";
    String PATH_RESOURCE_DIR = "/var/www/html/risorse/files/";

    //   String PATH_RESOURCE_DIR = "D:\\";
    String SEPARATOR = "/";
    String ADD_OCULUS_CONF = "aggiungi-visore.txt";
    String ADD_OCULUS_DONE = "aggiungi-visore-fatto.txt";
    String CHANGE_OCULUS_CONF = "cambia-visore.txt";
    String CHANGE_OCULUS_DONE = "cambia-visore-fatto.txt";
    String RESOURCE_TRASH = ".trash";
    String RESOURCE_TMB = ".tmb";
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
    String QUESTIONS_SEPARATOR = "|";
    String QUESTIONS_PREFIX_FILENAME = "test";
    String QUESTIONS_PREFIX_DOMANDE = "QUESTIONARI";
    String QUESTIONS_PREFIX_TEST = "TEST";
    String QUESTIONS_PREFIX_FILES = "files";

    String QUESTIONS_PREFIX_RISPOSTE = "ALLIEVI";
    String QUESTIONS_TAG_DOMANDA = "{domanda}";
    String QUESTIONS_TAG_CORRETTA = "{corretta}";
    String QUESTIONS_TAG_MEDIA_START = "{media:";
    String QUESTIONS_TAG_MEDIA_END = "}";
    String QUESTIONS_PREFIX_REPORT = "report";
    String QUESTIONS_PREF_UPPERCASE_REPORT = "REPORT";
    String QUESTIONS_CORRECT_RESPONSE = "Risposta corretta";
    String RESOURCES_INTEST_PNG = "intestazione.png";
    String CLAIMS_NAME = "name";
    String CLAIMS_EMAIL = "email";
    String CLAIMS_PREF_USERNAME = "preferred_username";
    String NO_CODE = "nocode";
    int BATTERY_LEVEL_MAX = 100;
    int BATTERY_LEVEL = 20;

    int QUESTIONS_HOURS_AGO = 6;
    boolean ENABLED_ONLINE = false;
    long MIN_ONLINE_ERA = 5;
    boolean ENABLED_REMOVE_RECORDS = true;
    long MIN_REMOVE_RECORDS = 2;
    boolean QUESTIONS_RANDOM = true;

}
