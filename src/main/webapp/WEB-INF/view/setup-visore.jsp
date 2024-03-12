<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="common/empty-base.jsp" %>

<!-- Form per inviare il valore della classe selezionata -->
<form id="form" method="post" action="/setup-visore">

<%
    String[] setupVisori = null;
    String[] labelVisori = null;
    String[] battVisori = null;
    String[] onlineVisori = null;

    if (request.getAttribute("macsSetup") != null && request.getAttribute("labelsSetup") != null && request.getAttribute("battSetup") != null ) {
        setupVisori = request.getAttribute("macsSetup").toString().split(",");
        labelVisori = request.getAttribute("labelsSetup").toString().split(",");
        battVisori = request.getAttribute("battSetup").toString().split(",");
        onlineVisori = request.getAttribute("onlineSetup") != null ? request.getAttribute("onlineSetup").toString().split(",") : null;
    }

%>

<div class="jumbotron jumbotron-billboard">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
              <h3 style="color: white;">${intestazione} Gestione Dispositivi </h3>
            </div>
        </div>
    </div>
</div>

<jsp:include page="include/menu-alto.jsp"></jsp:include>

<script>
$(document).ready(function() {
    function aggiornaContenuto() {
        $.ajax({
            url: '/aggiornaStatoVisori',
            type: 'GET',
            success: function(response) {
                $('.no-pointer-events').html(response);
            },
            error: function(error) {
                console.error("Errore durante l'aggiornamento dei visori: ", error);
            }
        });
    }

    setInterval(aggiornaContenuto, 5000); // Aggiorna ogni 5 secondi
});
</script>

<div class="iframe-style">
    <!-- Div interno per applicare il ridimensionamento -->
    <div class="scale-content">
        <!-- Div che disabilita gli eventi del mouse -->
        <div class="no-pointer-events">
            <jsp:include page="stato-visori.jsp"></jsp:include>
        </div>
    </div>
</div>

<div>
<a href="#" onclick="send()" style="position: fixed; transform: rotate(90deg); top: 65px; right: 35px; background: none; border: none;" data-toggle="tooltip" data-placement="left" title="Procedi alla ricerca dei nuovi device">
  <img src="static/images/scroll-up-arrow.png" style="border: 3px solid #0dcaf0cf;border-radius: 60px;" alt="Cerca" width="80" height="80">
</a>
</div>


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
