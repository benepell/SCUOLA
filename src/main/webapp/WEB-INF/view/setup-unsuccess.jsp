<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<br/><br/>
<div class="card-container">
  <div class="card">
    <div class="card-body">
      <h5 class="card-title">Codice di Registrazione non Valido</h5>
      <div class="form-group">
        Configurazione non salvata
      </div>
      <div class="form-group">
        CODICE DI REGISTRAZIONE SCUOLA: ${config.codiceDiRegistrazioneScuola}
      </div>
      <div class="form-group">
        Si prega di <a href="/api/index">riprovare</a> o contattare assistenza
      </div>
    </div>
  </div>
