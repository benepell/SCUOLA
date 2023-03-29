<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="it">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link href="<c:url value="/static/css/bootstrap.min.css" />" rel="stylesheet">

    <!-- open-iconic -->
    <link href="<c:url value="/static/css/open-iconic-bootstrap.css" />" rel="stylesheet">

    <!-- Altri CSS -->
    <link href="<c:url value="/static/css/config.css" />" rel="stylesheet">

    <!-- google fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto+Slab&display=swap" rel="stylesheet">
    </head>
<body>

<br/><br/>
<div class="card-container">
  <div class="card">
    <div class="card-body">
      <h5 class="card-title">Codice di Registrazione Valido</h5>
      <div class="form-group">
        Configurazione salvata con successo
      </div>
      <div class="form-group">
        Url SCUOLA: ${config.baseScuola}
      </div>
      <div class="form-group">
        CODICE DI REGISTRAZIONE SCUOLA: ${config.codiceDiRegistrazioneScuola}
      </div>
    </div>
  </div>

  <!-- Optional JavaScript -->
      <!-- jQuery first, then Popper.js, then Bootstrap JS -->
      <script type="text/javascript" src="<c:url value="/static/js/jquery-3.2.1.min.js" />"></script>
      <script type="text/javascript" src="<c:url value="/static/js/bootstrap.min.js" />"></script>
       <script type="text/javascript" src="<c:url value="/static/js/main.js" />"></script>
    </body>
  </html>