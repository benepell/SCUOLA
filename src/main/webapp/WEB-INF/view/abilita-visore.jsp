<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

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

  <div class="container">
    <div class="container">
  <% int margin = 0; %>
  <% for (int j = 0; j < 2; j++) { %>
    <div class="row" style="margin-top:<%=margin%>px;">
      <% for (int i = 1 + j*4; i <= 4 + j*4; i++) { %>
        <div class="col-md-3">
          <jsp:include page="include/card-visore.jsp">
            <jsp:param name="nome_allievo" value="Nome Allievo " />
            <jsp:param name="codice_visore" value="<%=i%>" />
          </jsp:include>
        </div>
      <% } %>
    </div>
    <% margin += 325; %>
  <% } %>
</div>

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