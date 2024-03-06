<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="common/minimal-base.jsp" %>

  <form action="/update-env" method="POST">
    <div class="card-container sortable">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title">Autenticazione</h5>
          <div class="form-group">
            <label for="TOKEN_DUCKDNS">TOKEN_DUCKDNS:</label>
            <input type="text" class="form-control" id="TOKEN_DUCKDNS" name="tokenDuckdns"
              value="">
              <p><a href="https://www.duckdns.org/" target="_blank">Registrati su duckdns</a></p>
          </div>
          <div class="form-group">
            <label for="CODICE_DI_REGISTRAZIONE_SCUOLA">CODICE_DI_REGISTRAZIONE_SCUOLA:</label>
            <input type="text" class="form-control" id="CODICE_DI_REGISTRAZIONE_SCUOLA"
              name="codiceDiRegistrazioneScuola" value="">
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
                value="">
            </div>
            <div class="form-group">
              <label for="BASE_KEYCLOAK">BASE_KEYCLOAK:</label>
              <input type="text" class="form-control" id="BASE_KEYCLOAK" name="baseKeycloak"
                value="">
            </div>
            <div class="form-group">
              <label for="BASE_RISORSE">BASE_RISORSE:</label>
              <input type="text" class="form-control" id="BASE_RISORSE" name="baseRisorse"
                value="">
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
<script>
const basePath = '<%= request.getContextPath() %>'; // Recupera la base URL dalla richiesta HTTP
const apiEndpoint = `${basePath}/basesetup`; // Concatena la base URL con l'endpoint dell'API

fetch(apiEndpoint)
    .then(response => response.json()) // Parse la risposta HTTP come JSON
    .then(data => {
      // Utilizza i campi del JSON per impostare il valore dell'input HTML
      document.getElementById('TOKEN_DUCKDNS').value = data.TOKEN_DUCKDNS;
      document.getElementById('CODICE_DI_REGISTRAZIONE_SCUOLA').value = data.CODICE_DI_REGISTRAZIONE_SCUOLA;
      document.getElementById('BASE_SCUOLA').value = data.BASE_SCUOLA;
      document.getElementById('BASE_KEYCLOAK').value = data.BASE_KEYCLOAK;
      document.getElementById('BASE_RISORSE').value = data.BASE_RISORSE;
    })
    .catch(error => {
      console.error('Errore durante il recupero del JSON:', error);
    });
</script>
<br/>
 <jsp:include page="common/minimal-footer.jsp" />