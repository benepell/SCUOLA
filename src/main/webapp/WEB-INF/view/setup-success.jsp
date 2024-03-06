<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="common/minimal-base.jsp" %>

<br/><br/>
<div class="card-container">
  <div class="card">
    <div class="card-body">
      <h5 class="card-title">Configurazione salvata con successo</h5>
      <h6 class="card-title">Riavvia il Server entro 5 minuti per applicare le modifiche</h6>

      <!-- Barra di progresso per il tempo rimanente -->
      <div id="progressBarContainer" style="width: 100%; background-color: #e0e0e0;">
        <div id="progressBar" style="width: 0%; height: 30px; background-color: #4CAF50;"></div>
      </div>
      <h6 id="countdownTimer" style="text-align: center; margin-top: 10px;">5:00</h6>

      <!-- Divisore con bordo -->
      <div style="border-top: 1px solid #ccc; margin: 20px 0;"></div>

      <p>TOKEN_DUCKDNS: ${setupModel.tokenDuckdns}</p>
      <p>CODICE_DI_REGISTRAZIONE_SCUOLA: ${setupModel.codiceDiRegistrazioneScuola}</p>
      <p>BASE_SCUOLA: ${setupModel.baseScuola}</p>
      <p>BASE_KEYCLOAK: ${setupModel.baseKeycloak}</p>
      <p>BASE_RISORSE: ${setupModel.baseRisorse}</p>

       <!-- Divisore con bordo -->
      <div style="border-top: 1px solid #ccc; margin: 20px 0;"></div>

      <a href="#" onclick="window.history.back(); return false;">Inserisci nuovamente i valori</a>
    </div>
  </div>
</div>

<script>
function startCountdown(duration, display, progressBar) {
    var start = Date.now(),
        diff,
        minutes,
        seconds;
    function timer() {
        // Calcola il tempo trascorso
        diff = duration - (((Date.now() - start) / 1000) | 0);

        // Calcola i minuti e secondi da visualizzare
        minutes = (diff / 60) | 0;
        seconds = (diff % 60) | 0;

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        display.textContent = minutes + ":" + seconds;

        // Aggiorna la barra del progresso
        var percent = 100 - (diff * 100 / duration);
        progressBar.style.width = percent + "%";

        if (diff <= 0) {
            // Quando il timer arriva a 0, ferma il timer
            clearInterval(interval);
            display.textContent = "00:00";
            progressBar.style.width = "100%";
        }
    };
    // Aggiorna il timer ogni secondo
    timer();
    var interval = setInterval(timer, 1000);
}

window.onload = function () {
    var fiveMinutes = 60 * 5,
        display = document.querySelector('#countdownTimer'),
        progressBar = document.querySelector('#progressBar');
    startCountdown(fiveMinutes, display, progressBar);
};
</script>
