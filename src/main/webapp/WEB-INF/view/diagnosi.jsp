<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="common/empty-base.jsp" %>


<%
    String[] setupVisori = null;
    String[] labelVisori = null;

    String[] service = null;
    String[] state = null;

   if (request != null) {
       String strService = "Piattaforma,Login,Risorse,Archivio";
       String strState = request.getAttribute("operatingSystemStatus") + ","+ request.getAttribute("websiteKeycloakStatus") + "," + request.getAttribute("websiteRisorseStatus") + "," + request.getAttribute("databaseStatus");

       service = strService.split(",");
       state = strState.split(",");
   }

   setupVisori = service;
   labelVisori = state;

%>

<div class="jumbotron jumbotron-billboard">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
              <h3 style="color: white;">${intestazione} Diagnosi Dispositivi </h3>
            </div>
        </div>
    </div>
</div>

<jsp:include page="include/menu-alto.jsp"></jsp:include>

<% if (setupVisori != null && setupVisori.length > 0 &&
        labelVisori != null && labelVisori.length > 0) { %>

    <div class="container">
        <% int margin = 0; %>
        <% for (int j = 0; j <= Math.ceil(setupVisori.length / 4.0); j++) { %>
            <div class="row" style="margin-top:<%=margin%>px;">
                <% for (int i = 1 + j*4; i <= Math.min(setupVisori.length, 4 + j*4); i++) { %>
                    <div class="col-md-3">
                        <jsp:include page="include/diagnosi-card.jsp">
                            <jsp:param name="nome_visore" value="<%=setupVisori[i-1]%>" />
                            <jsp:param name="img_diagnosi" value="<%=i%>" />
                            <jsp:param name="codice_visore" value="<%=labelVisori[i-1]%>" />
                        </jsp:include>
                    </div>
                <% } %>
            </div>
            <% margin = 325; %>
             <script>
             // Array per memorizzare le altezze del visore
             var altezzaVisore = [];
             </script>
        <% } %>
    </div>
<% } %>

<div>
    <a href="#" id="scrollUpArrow" style="position: fixed; bottom: 110px; right: 35px;">
      <img src="static/images/scroll-up-arrow.png" style="border: 3px solid #0dcaf0cf;border-radius: 60px;" alt="Vai sopra" width="80" height="80">
    </a>
</div>
<div>
<a href="#" id="scrollDownArrow" style="position: fixed; transform: rotate(180deg); bottom: 20px; right: 35px;">
      <img src="static/images/scroll-up-arrow.png" style="border: 3px solid #0dcaf0cf;border-radius: 60px;" alt="Vai sopra" width="80" height="80">
    </a>
</div>
</script>


    <script src="static/js/jquery-3.6.4.min.js"></script>
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

    <script>
    $(function () {
      $('[data-toggle="tooltip"]').tooltip();
    });

          function send() {
            document.getElementById('form').submit();
          }

    </script>
