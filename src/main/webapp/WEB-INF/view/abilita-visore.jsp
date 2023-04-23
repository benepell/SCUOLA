<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

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

<%-- Modale per la visualizzazione del visore --%>
<%
    Map<String, String> linkMap = new HashMap<String, String>();
    linkMap.put("classe1", "classeEsempio di link");
    linkMap.put("classe2", "Google");
    request.setAttribute("linkMap", linkMap);
%>

<jsp:include page="include/modale-abilita-visore.jsp">
      <jsp:param name="linkMap" value="<%= linkMap %>"/>
</jsp:include>

<jsp:include page="include/scroll-page.jsp"></jsp:include>

<script src="static/js/jquery-3.6.4.min.js"></script>
<script src="static/js/card-visore.js"></script>
<script src="static/js/modale-card-visore.js"></script>
<script src="static/js/preload-card-visore.js"></script>
<script src="static/js/scroll-card-visore.js"></script>
