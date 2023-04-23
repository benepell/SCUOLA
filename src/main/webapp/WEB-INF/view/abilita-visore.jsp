<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%
    int codiceVisore = 0;
    //String[] allievi = (String[])session.getAttribute("alunni");

    String[] allievi = new String[]{
        "Mario Rossi", "Luigi Bianchi", "Giuseppe Verdi", "Carlo Rossi",
        "Andrea Bianchi", "Paolo Neri", "Marco Bianco", "Simone Gialli",
        "Francesco Rosso", "Fabio Verdi", "Giovanni Marroni", "Roberto Blu",
        "Alberto Arancio", "Antonio Verde", "Nicola Magenta", "Riccardo Celeste", "Davide Oro",
        "Federico Rosa", "Stefano Viola", "Enrico Rossetti", "Gabriele Indaco", "Massimo Azzurro",
        "Mattia Turchese", "Pietro Malva", "Vincenzo Beige", "Alessio Ciano",
        "Daniele Avorio", "Sergio Cielo", "Giacomo Cobalto", "Emanuele Fucsia", "Leonardo Lilla",
        "Maurizio Malachite", "Raffaele Perla", "Salvatore Smeraldo", "Bruno Ciano",
        "Gianluca Zaffiro", "Oscar Magenta", "Angelo Zolfo", "Carmine Ambra",
        "Alberto Ametista", "Diego Topazio", "Pasquale Turchese", "Angelo Lavanda",
        "Giancarlo Zafferano", "Ivan Ciano", "Domenico Rubino", "Valerio Giallo",
        "Lorenzo Cobalto", "Marcello Bronzo", "Flavio Smeraldo"
    };
%>

<div class="jumbotron jumbotron-billboard">
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <h3 style="color: white">
          ${intestazione} Classe: ${classSelected} Sezione: ${sectionSelected}
        </h3>
      </div>
    </div>
  </div>
</div>

<div class="loader-container">
  <div class="loader"></div>
</div>

<% if (allievi != null && allievi.length > 0) { %>

<div class="container">
  <% int margin = 0; %> <% for (int j = 0; j < Math.ceil(allievi.length / 4.0);
  j++) { %>
  <div class="row" style="margin-top: <%=margin%>px">
    <% for (int i = 1 + j*4; i <= Math.min(allievi.length, 4 + j*4); i++) { %>
    <div class="col-md-3">
      <jsp:include page="include/card-visore.jsp">
        <jsp:param name="nome_allievo" value="<%=allievi[i-1]%>" />
        <jsp:param name="codice_visore" value="<%=i%>" />
      </jsp:include>
    </div>
    <%} %>
  </div>
  <% margin = 325; %>
  <script>
    // Array per memorizzare le altezze del visore
    var altezzaVisore = [];
  </script>
  <% } %>
</div>
<% } %>

<div id="demo-modal" class="modal">
  <div class="modal-content">
  <div class="cerchio" id="cerchio">&nbsp;</div>
    <span class="close-btn">&times;</span>
    <h2>Seleziona un argomento</h2>
    <div class="iframe-container">
          <iframe srcdoc='
                <!DOCTYPE html>
                <html>
                  <head>
                    <style>
                      * {
                        margin: 0;
                        padding: 0;
                      }

                      body {
                        background-color: #e4eeda;
                        font-family: sans-serif;
                      }

                      ul {
                        list-style: none;
                        padding: 20px;
                        max-height: 450px;
                        overflow: auto;
                      }

                      li {
                        margin-bottom: 10px;
                      }

                      a {
                        color: #6D4C41;
                        text-decoration: none;
                        font-size: larger;
                        line-height: 1.4rem;
                      }

                      a:hover {
                        text-decoration: underline;
                      }
                    </style>
                  </head>
                  <body>

                    <ul>
                      <li><a href="#" onclick="clicktrasporto()">Argomento demo 1</a></li>
                      <li><a href="#">Argomento demo 2</a></li>
                      <li><a href="#">Argomento demo 3</a></li>
                      <li><a href="#">Argomento demo 4</a></li>
                      <li><a href="#">Argomento demo 5</a></li>
                      <li><a href="#">Argomento demo 6</a></li>
                      <li><a href="#">Argomento demo 7</a></li>
                      <li><a href="#">Argomento demo 8</a></li>
                      <li><a href="#">Argomento demo 9</a></li>
                    </ul>

                    <script>
                       function clicktrasporto() {
                         var message = {
                           action: "linkClicked"
                         };
                         parent.postMessage(message, "http://localhost:8080");
                       }
                    </script>
                  </body>
                </html>'></iframe>
        </div>
  </div>
</div>

<div>
  <a
    href="#"
    id="scrollUpArrow"
    style="position: fixed; bottom: 110px; right: 35px"
  >
    <img
      src="static/images/scroll-up-arrow.png"
      alt="Vai sopra"
      width="80"
      height="80"
    />
  </a>
</div>
<div>
  <a
    href="#"
    id="scrollDownArrow"
    style="
      position: fixed;
      transform: rotate(180deg);
      bottom: 20px;
      right: 35px;
    "
  >
    <img
      src="static/images/scroll-up-arrow.png"
      alt="Vai sopra"
      width="80"
      height="80"
    />
  </a>
</div>

<script src="static/js/jquery-3.6.4.min.js"></script>
<script>
  var showmod = false;
  $(".hexagon-inset").click(function () {
    //var card = $(this);
    // card.toggleClass('flipped');
    // alert('click bp');
    showDemoModal('<%=codiceVisore%>'); // Mostra la finestra modale per selezionare i form demo
    showmod = true;
  });

  // Modifica la funzione di gestione dell'evento click della carta
  $(".card").click(function () {
    var card = $(this);
    if (showmod == false) {
      card.toggleClass("flipped");
    }
    showLoader(); // Mostra il loader
    setTimeout(function () {
      hideLoader(); // Nascondi il loader dopo 2 secondi
    }, 2000);
  });

  function showDemoModal(valoreCerchio) {
    // Mostra la finestra modale
    var modal = $("#demo-modal");
    // set display modal
    modal.css("display", "block");
    // reload iframe
    modal.find("iframe").attr("srcdoc", modal.find("iframe").attr("srcdoc"));
    modal.show();

    // Seleziona l'elemento del cerchio
    var cerchio = document.getElementById('cerchio');

    // Imposta il contenuto dell'elemento con il valore della variabile
    cerchio.innerHTML = valoreCerchio;

    // Aggiungi un gestore di eventi per la chiusura della finestra modale
    modal.find(".close-btn").click(function () {
      showmod = false;
      modal.hide();
    });
  }
</script>

<script>
  // Seleziona il contenitore del caricamento
  var loaderContainer = document.querySelector(".loader-container");

  // Mostra la finestra modale del caricamento
  function showLoader() {
    loaderContainer.style.display = "block";
  }

  // Nascondi la finestra modale del caricamento
  function hideLoader() {
    loaderContainer.style.display = "none";
  }
</script>

<script>
  // Aggiungi la funzione per lo scroll verso l'alto con delay
  $("#scrollUpArrow").click(function () {
    $("html, body").animate({ scrollTop: 0 }, 150); // Tempo di delay in millisecondi (1000 = 1 secondo)
  });

  $(document).ready(function () {
    // Aggiungi l'evento di click all'elemento con l'ID scrollDownArrow
    $("#scrollDownArrow").click(function () {
      // Anima lo scrolling del corpo e dell'html alla fine del documento
      $("html, body").animate({ scrollTop: $(document).height() }, 150);
    });
  });
</script>

<script>
// Aggiungi un listener per ricevere i messaggi dall'iframe
window.addEventListener("message", function(event) {

  if (event.data.action === "linkClicked") {
    var modal = document.getElementById("demo-modal");
    modal.style.display = "none";
    showmod = false;

    var loading = document.createElement("div");

    // Aggiungi la finestra di caricamento
    loading.style.position = "fixed";
    loading.style.top = 0;
    loading.style.left = 0;
    loading.style.width = "100%";
    loading.style.height = "100%";
    loading.style.background = "rgba(0, 0, 0, 0.5)";
    loading.style.display = "flex";
    loading.style.justifyContent = "center";
    loading.style.alignItems = "center";

    // Aggiungi il testo "Trasferimento in corso..."
    var message = document.createElement("p");
    message.style.color = "yellow";
    message.style.fontFamily = "Arial, sans-serif";
    message.style.fontSize = "50px";
    message.style.textAlign = "left";
    message.textContent = "Caricamento in corso... ";
    // inserisci il testo a capo

    loading.appendChild(message);

    // Aggiungi un'immagine di una barra di avanzamento
    var progressBar = document.createElement("img");
    progressBar.src = "static/images/animazione-loading.gif";
    // padding 20px
    progressBar.style.padding = "20px";
    progressBar.style.width = "350px";
    progressBar.style.height = "350px";
    //
    progressBar.style.borderRadius = "60%";
    progressBar.style.filter = "brightness(75%)";
    // trasparente
    progressBar.style.opacity = 0.7;
    loading.appendChild(progressBar);

    document.body.appendChild(loading);

    // remove loading
    setTimeout(function() {
        document.body.removeChild(loading);
    }, 5000);
  }
});
</script>

