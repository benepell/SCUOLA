<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%
   //String[] allievi = (String[])session.getAttribute("alunni");
   String[] allievi = new String[]{
       "Mario Rossi", "Luigi Bianchi", "Giuseppe Verdi", "Carlo Rossi", "Andrea Bianchi",
       "Paolo Neri", "Marco Bianco", "Simone Gialli", "Francesco Rosso", "Fabio Verdi",
       "Giovanni Marroni", "Roberto Blu", "Alberto Arancio", "Antonio Verde", "Nicola Magenta",
       "Riccardo Celeste", "Davide Oro", "Federico Rosa", "Stefano Viola", "Enrico Rossetti",
       "Gabriele Indaco", "Massimo Azzurro", "Mattia Turchese", "Pietro Malva", "Vincenzo Beige",
       "Alessio Ciano", "Daniele Avorio", "Sergio Cielo", "Giacomo Cobalto", "Emanuele Fucsia",
       "Leonardo Lilla", "Maurizio Malachite", "Raffaele Perla", "Salvatore Smeraldo", "Bruno Ciano",
       "Gianluca Zaffiro", "Oscar Magenta", "Angelo Zolfo", "Carmine Ambra", "Alberto Ametista",
       "Diego Topazio", "Pasquale Turchese", "Angelo Lavanda", "Giancarlo Zafferano", "Ivan Ciano",
       "Domenico Rubino", "Valerio Giallo", "Lorenzo Cobalto", "Marcello Bronzo", "Flavio Smeraldo"
   };
%>

<div class="jumbotron jumbotron-billboard">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
              <h3 style="color: white;">${intestazione} Classe: ${classSelected} Sezione: ${sectionSelected} </h3>
            </div>
        </div>
    </div>
</div>

    <div class="loader-container">
        <div class="loader"></div>
    </div>

<% if (allievi != null && allievi.length > 0) { %>

    <div class="container">
        <% int margin = 0; %>
        <% for (int j = 0; j < Math.ceil(allievi.length / 4.0); j++) { %>
            <div class="row" style="margin-top:<%=margin%>px;">
                <% for (int i = 1 + j*4; i <= Math.min(allievi.length, 4 + j*4); i++) { %>
                    <div class="col-md-3">
                        <jsp:include page="include/card-visore.jsp">
                            <jsp:param name="nome_allievo" value="<%=allievi[i-1]%>" />
                            <jsp:param name="codice_visore" value="<%=i%>" />
                        </jsp:include>
                    </div>
                <% } %>
            </div>
            <% margin = 325; %>
             <script>
             // Array per memorizzare le altezze del visore
             var altezzaVisore = [];
              // Chiamata alla funzione per memorizzare l'altezza del visore
                memorizzaAltezzaVisore();
             </script>
        <% } %>
    </div>
<% } %>

<div>
    <a href="#" id="scrollUpArrow" style="position: fixed; bottom: 110px; right: 35px;">
      <img src="static/images/scroll-up-arrow.png" alt="Vai sopra" width="80" height="80">
    </a>
</div>
<div>
<a href="#" id="scrollDownArrow" style="position: fixed; transform: rotate(180deg); bottom: 20px; right: 35px;">
      <img src="static/images/scroll-up-arrow.png" alt="Vai sopra" width="80" height="80">
    </a>
</div>


    <script src="static/js/jquery-3.6.4.min.js"></script>
    <script>
        // Modifica la funzione di gestione dell'evento click della carta
        $('.card').click(function () {
            var card = $(this);
            card.toggleClass('flipped');
            showLoader(); // Mostra il loader
            setTimeout(function () {
                hideLoader(); // Nascondi il loader dopo 2 secondi
            }, 2000);
        });
    </script>

    <script>
        // Seleziona il contenitore del caricamento
        var loaderContainer = document.querySelector('.loader-container');

        // Mostra la finestra modale del caricamento
        function showLoader() {
            loaderContainer.style.display = 'block';
        }

        // Nascondi la finestra modale del caricamento
        function hideLoader() {
            loaderContainer.style.display = 'none';
        }

    </script>

    <script>
    // Aggiungi la funzione per lo scroll verso l'alto con delay
      $('#scrollUpArrow').click(function() {
        $('html, body').animate({scrollTop: 0}, 150); // Tempo di delay in millisecondi (1000 = 1 secondo)
      });

$(document).ready(function() {
  // Aggiungi l'evento di click all'elemento con l'ID scrollDownArrow
  $('#scrollDownArrow').click(function() {
    // Anima lo scrolling del corpo e dell'html alla fine del documento
    $('html, body').animate({scrollTop: $(document).height()}, 150);
  });
});
    </script>