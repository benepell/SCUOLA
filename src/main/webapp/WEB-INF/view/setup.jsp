<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

  <form action="/api/update-env" method="POST">
    <div class="card-container sortable">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title">Autenticazione</h5>
          <div class="form-group">
            <label for="PASSWORD_SERVER_SCUOLA">PASSWORD_SERVER_SCUOLA:</label>
            <input type="text" class="form-control" id="PASSWORD_SERVER_SCUOLA" name="passwordServerScuola"
              value="vrscuola!!!">
          </div>
          <div class="form-group">
            <label for="CODICE_DI_REGISTRAZIONE_SCUOLA">CODICE_DI_REGISTRAZIONE_SCUOLA:</label>
            <input type="text" class="form-control" id="CODICE_DI_REGISTRAZIONE_SCUOLA"
              name="codiceDiRegistrazioneScuola" value="akkqqiji$$55ga">
          </div>
          <div class="form-group">
            <label for="VERSIONE_SCUOLA">VERSIONE_SCUOLA:</label>
            <input type="text" class="form-control" id="VERSIONE_SCUOLA" name="versioneScuola" value="1">
          </div>
        </div>
      </div>

      <div class="card-container sortable">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Configurazione Base</h5>
            <div class="form-group">
              <label for="BASE_SCUOLA">BASE_SCUOLA:</label>
              <input type="text" class="form-control" id="BASE_SCUOLA" name="baseScuola"
                value="https://scuola.vrscuola.online">
            </div>
            <div class="form-group">
              <label for="BASE_KEYCLOAK">BASE_KEYCLOAK:</label>
              <input type="text" class="form-control" id="BASE_KEYCLOAK" name="baseKeycloak"
                value="https://keycloak.vrscuola.online:9443">
            </div>
            <div class="form-group">
              <label for="BASE_RISORSE">BASE_RISORSE:</label>
              <input type="text" class="form-control" id="BASE_RISORSE" name="baseRisorse"
                value="https://scuola.vrscuola.online:8443">
            </div>
          </div>
        </div>

        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Configurazione Certificati</h5>
            <div class="form-group">
              <label for="CERT_SCUOLA">CERT_SCUOLA:</label>
              <input type="text" class="form-control" id="CERT_SCUOLA" name="certScuola" value="/etc/certs/scuola">
            </div>
            <div class="form-group">
              <label for="CERT_KEYCLOAK">CERT_KEYCLOAK:</label>
              <input type="text" class="form-control" id="CERT_KEYCLOAK" name="certKeycloak"
                value="/etc/certs/keycloak">
            </div>
            <div class="form-group">
              <label for="DOMAIN_SCUOLA">DOMAIN_SCUOLA:</label>
              <input type="text" class="form-control" id="DOMAIN_SCUOLA" name="domainScuola"
                value="scuola.vrscuola.online">
            </div>
            <div class="form-group">
              <label for="DOMAIN_KEYCLOAK">DOMAIN_KEYCLOAK:</label>
              <input type="text" class="form-control" id="DOMAIN_KEYCLOAK" name="domainKeycloak"
                value="keycloak.vrscuola.online">
            </div>
            <div class="form-group">
              <label for="CERT_PASSWORD">CERT_PASSWORD:</label>
              <input type="text" class="form-control" id="CERT_PASSWORD" name="certPassword" value="vrscuola!!!">
            </div>
            <div class="form-group">
              <label for="CERT_ALIAS_SCUOLA">CERT_ALIAS_SCUOLA:</label>
              <input type="text" class="form-control" id="CERT_ALIAS_SCUOLA" name="certAliasScuola" value="vrscuola">
            </div>
            <div class="form-group">
              <label for="CERT_ALIAS_KEYCLOAK">CERT_ALIAS_KEYCLOAK:</label>
              <input type="text" class="form-control" id="CERT_ALIAS_KEYCLOAK" name="certAliasKeycloak"
                value="keycloak">
            </div>
          </div>
        </div>

        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Configurazioni Basedati</h5>
            <div class="form-group">
              <label for="DB_SCUOLA_NAME">DB_SCUOLA_NAME:</label>
              <input type="text" class="form-control" id="DB_SCUOLA_NAME" name="dbScuolaName" value="vrscuoladb">
            </div>
            <div class="form-group">
              <label for="DB_SCUOLA_USERNAME">DB_SCUOLA_USERNAME:</label>
              <input type="text" class="form-control" id="DB_SCUOLA_USERNAME" name="dbScuolaUsername"
                value="vrscuola">
            </div>
            <div class="form-group">
              <label for="DB_SCUOLA_PASSWORD">DB_SCUOLA_PASSWORD:</label>
              <input type="text" class="form-control" id="DB_SCUOLA_PASSWORD" name="dbScuolaPassword"
                value="vrscuola!!!!">
            </div>
            <div class="form-group">
              <label for="DB_SCUOLA_BRIDGE_USERNAME">DB_SCUOLA_BRIDGE_USERNAME:</label>
              <input type="text" class="form-control" id="DB_SCUOLA_BRIDGE_USERNAME" name="dbScuolaBridgeUsername"
                value="keycloakread">
            </div>
            <div class="form-group">
              <label for="DB_SCUOLA_BRIDGE_PASSWORD">DB_SCUOLA_BRIDGE_PASSWORD:</label>
              <input type="text" class="form-control" id="DB_SCUOLA_BRIDGE_PASSWORD" name="dbScuolaBridgePassword"
                value="vrscuolaread!!">
            </div>
            <div class="form-group">
              <label for="DB_KEYCLOAK_NAME">DB_KEYCLOAK_NAME:</label>
              <input type="text" class="form-control" id="DB_KEYCLOAK_NAME" name="dbKeycloakName" value="keycloakdb">
            </div>
            <div class="form-group">
              <label for="DB_KEYCLOAK_USERNAME">DB_KEYCLOAK_USERNAME:</label>
              <input type="text" class="form-control" id="DB_KEYCLOAK_USERNAME" name="dbKeycloakUsername"
                value="keycloak">
            </div>
            <div class="form-group">
              <label for="DB_KEYCLOAK_PASSWORD">DB_KEYCLOAK_PASSWORD:</label>
              <input type="text" class="form-control" id="DB_KEYCLOAK_PASSWORD" name="dbKeycloakPassword"
                value="vrscuola!!!">
            </div>
            <div class="form-group">
              <label for="DB_WORDPRESS_NAME">DB_WORDPRESS_NAME:</label>
              <input type="text" class="form-control" id="DB_WORDPRESS_NAME" name="dbWordpressName" value="wpdb">
            </div>
            <div class="form-group">
              <label for="DB_WORDPRESS_USERNAME">DB_WORDPRESS_USERNAME:</label>
              <input type="text" class="form-control" id="DB_WORDPRESS_USERNAME" name="dbWordpressUsername"
                value="wp">
            </div>
            <div class="form-group">
              <label for="DB_WORDPRESS_PASSWORD">DB_WORDPRESS_PASSWORD:</label>
              <input type="text" class="form-control" id="DB_WORDPRESS_PASSWORD" name="dbWordpressPassword"
                value="vrscuola!!!">
            </div>
          </div>
        </div>

        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Configurazione Login - Keycloak</h5>
            <div class="form-group">
              <label for="KEYCLOAK_DIR">KEYCLOAK_DIR:</label>
              <input type="text" class="form-control" id="KEYCLOAK_DIR" name="keycloakDir"
                value="/opt/keycloak-21.0.0">
            </div>
            <div class="form-group">
              <label for="KEYCLOAK_ADMIN_USERNAME">KEYCLOAK_ADMIN_USERNAME:</label>
              <input type="text" class="form-control" id="KEYCLOAK_ADMIN_USERNAME" name="keycloakAdminUsername"
                value="admin">
            </div>
            <div class="form-group">
              <label for="KEYCLOAK_ADMIN_PASSWORD">KEYCLOAK_ADMIN_PASSWORD:</label>
              <input type="text" class="form-control" id="KEYCLOAK_ADMIN_PASSWORD" name="keycloakAdminPassword"
                value="vrscuola!!!">
            </div>
            <div class="form-group">
              <label for="KEYCLOAK_CLIENT_ID">KEYCLOAK_CLIENT_ID:</label>
              <input type="text" class="form-control" id="KEYCLOAK_CLIENT_ID" name="keycloakClientId"
                value="scuolaelementare">
            </div>
          </div>
        </div>

        <div class="form-group mt-3">
          <button type="button" class="btn btn-danger" id="cancelButton">Annulla</button>
          <button type="submit" class="btn btn-primary ml-2" >Registra</button>
        </div>
  </form>

  <!-- Modale di conferma per Salva -->
  <div class="modal fade" id="saveModal" tabindex="-1" role="dialog" aria-labelledby="saveModalLabel"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="saveModalLabel">Salvare le modifiche?</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Chiudi">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          Sei sicuro di voler salvare le modifiche apportate?
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Annulla</button>
          <button type="button" id="saveConfirmButton" class="btn btn-primary">Salva Modifiche</button>
        </div>
      </div>
    </div>
  </div>
  </div>


  </form>

  <script>
  // Aggiungi un ascoltatore di eventi al bottone "annulla" e ricarica la pagina
  document.getElementById("cancelButton").addEventListener("click", function() {
      location.reload();
    });

    // Aggiungi un ascoltatore di eventi al bottone "Salva"
    const saveButton = document.getElementById("saveButton");
    saveButton.addEventListener("click", function () {
      // Apri la finestra modale di conferma per "Salva"
      const saveModal = document.getElementById("saveModal");
      const modal = new bootstrap.Modal(saveModal);
      modal.show();
    });
    // Aggiungi un ascoltatore di eventi al form di configurazione
    const configForm = document.getElementById("config-form");
    configForm.addEventListener("submit", function (event) {
      // Impedisci l'invio del form e apri la finestra modale di conferma per "Salva"
      event.preventDefault();
      const saveModal = document.getElementById("saveModal");
      const modal = new bootstrap.Modal(saveModal);
      modal.show();
    });

    // Aggiungi un ascoltatore di eventi al pulsante di conferma del modale "Salva"
    const saveConfirmButton = document.getElementById("saveConfirmButton");
    saveConfirmButton.addEventListener("click", function () {
      // Invia il form tramite AJAX
      const configForm = document.getElementById("config-form");
      const xhr = new XMLHttpRequest();
      xhr.open(configForm.method, configForm.action);
      xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
      xhr.onload = function () {
        if (xhr.status === 200) {
          // Se l'invio del form ha avuto successo, chiudi la finestra modale e aggiorna la pagina
          const saveModal = document.getElementById("saveModal");
          const modal = new bootstrap.Modal(saveModal);
          modal.hide();
          location.reload();
        } else {
          // In caso di errore, visualizza un messaggio di errore
          alert("Errore durante l'invio del form: " + xhr.statusText);
        }
      };
      xhr.send(new FormData(configForm));
    });

  </script>

<script>
  var cardContainer = document.querySelector('.card-container');
  if (window.innerWidth > 768) { // Disabilita il drag and drop sui dispositivi mobili
    new Sortable(cardContainer, {
      animation: 150,
      handle: '.card',
      ghostClass: 'card-placeholder',
      chosenClass: 'card-dragging',
      dragClass: 'card-dragging',
      onEnd: function(evt) {
        console.log("Card moved from " + evt.oldIndex + " to " + evt.newIndex);
      }
    });
  }
</script>
