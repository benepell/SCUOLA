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

      <jsp:include page="include/scroll-page.jsp"></jsp:include>

<script src="static/js/jquery-3.6.4.min.js"></script>
<script src="static/js/card-visore.js"></script>
<script src="static/js/modale-card-visore.js"></script>
<script src="static/js/preload-card-visore.js"></script>
<script src="static/js/scroll-card-visore.js"></script>
