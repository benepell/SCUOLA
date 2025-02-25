<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="common/empty-base.jsp" %>

<%
    int codiceVisore = 0;
    String[] allievi = (String[])request.getAttribute("alunni");
    String[] username = (String[])request.getAttribute("usernameSelected");
    String users = username != null ? String.join(",", username) : "";

%>

<!-- Modal -->
<div class="modal fade" id="resultModal" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-body">
        <p id="modalMessage"></p>
      </div>
    </div>
  </div>
</div>

<div class="jumbotron jumbotron-billboard">
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <h3 style="color: white">
          ${intestazione} <spring:message code="form.abilita-visore.classroom" />: ${classroomSelected} <spring:message code="form.abilita-visore.class" />: ${classSelected} <spring:message code="form.abilita-visore.section" />: ${sectionSelected.toUpperCase()}
        </h3>
      </div>
    </div>
  </div>
</div>

<div style="position: fixed;top: 4px;right: 125px;background: none;border: none;z-index: 9999;/* height: 12px !important; */">
  <div class="input-group">
    <input type="text" class="form-control" id="searchBox" placeholder="Cerca un nome..." onkeydown="handleEnterKey(event)" style="border: 2px solid rgb(13 253 173 / 23%);background: #352b2b;color: white;/* border-color: #455A64; */">
    <button class="btn btn-primary" id="searchButton" style="
    display: inline-block;
    padding: 4px;
    margin: 0px 2px;
    background-color: #352b2b;
    border: 2px solid rgb(13 253 173 / 23%);
    text-align: center;
    min-width: 100px;
    color: white;
    font-weight: bold;
    text-decoration: none;
    border-radius: 5px;
    transition: background-color 0.mysez-3s, color 0.mysez-3s;">Cerca</button>
  </div>
</div>

<jsp:include page="include/menu-alto.jsp"></jsp:include>

<style>
.iframe-style {
    height: 220px; /* Imposta l'altezza massima */
    overflow: hidden;
    overflow-y: auto; /* Aggiunge la barra di scorrimento verticale se necessario */
    margin: 20px 0; /* Margini esterni (opzionale) */
    padding: 10px; /* Padding interno (opzionale) */
}

.no-pointer-events {
    pointer-events: none; /* Disabilita gli eventi del mouse solo per questo contenitore */
}

.scale-content {
    transform: scale(0.5);
    transform-origin: top left; /* Aggiornato per evitare tagli del contenuto */
    width: 200%; /* Aumenta la larghezza per compensare la riduzione della scala */
}


</style>

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

<!-- Form per inviare il valore della classe selezionata -->
<form id="form" method="post" action="/chiudi-visore">

    <input type="hidden" name="username" value="<%=users%>" />

<div class="loader-container">
  <div class="loader"></div>
</div>

<div>
    <a href="#" onclick="send()" style="position: fixed; transform: rotate(90deg); top: 65px; right: 35px; background: none; border: none;" data-toggle="tooltip" data-placement="left" title="Procedi alla chiusura di tutti i visori">
      <img src="static/images/scroll-up-arrow.png" style="border: 3px solid #0dcaf0cf;border-radius: 60px;" alt="Cerca" width="80" height="80">
    </a>
</div>


<% if (allievi != null && allievi.length > 0) { %>

<div class="container">
<%
    int numVisoriInRow = 4;

  int totalIndexes = allievi.length;
  int margin = 0; %> <% for (int j = 0; j <= Math.ceil(totalIndexes / numVisoriInRow);
  j++) { %>
  <div class="row" style="margin-top: <%=margin%>px;">
    <% for (int i = 1 + j*numVisoriInRow; i <= Math.min(totalIndexes, numVisoriInRow + j*numVisoriInRow); i++) { %>

           <div class="col-md-3">


      <%
        boolean isResumeUsername = false;
        String resumeLabel = "";
      String[] resumeUsers;
      String[] resumeLabels;

      Object resumeUsersObj = request.getAttribute("resumeUsers");
      Object resumeLabelsObj = request.getAttribute("resumeLabels");

      if (resumeUsersObj != null && resumeUsersObj instanceof String) {
          resumeUsers = ((String) resumeUsersObj).split(",");
      } else {
          resumeUsers = new String[0]; // or handle this scenario as you see fit
      }

      if (resumeLabelsObj != null && resumeLabelsObj instanceof String) {
          resumeLabels = ((String) resumeLabelsObj).split(",");
      } else {
          resumeLabels = new String[0]; // or handle this scenario as you see fit
      }

        if(resumeUsers != null && resumeLabels != null &&
        resumeLabels.length > 0 &&
        !resumeLabels[0].equals("null") &&
         resumeUsers.length == resumeLabels.length) {
            int y = 0;
            for (String resumeUser : resumeUsers) {
                if (resumeUser.equals(username[i-1])) {
                    isResumeUsername = true;
                    resumeLabel = resumeLabels[y];
                    break;
                }
                y++;
            }
        }



      %>
      <jsp:include page="include/card-visore.jsp">
        <jsp:param name="nome_allievo" value="<%=allievi[i-1]%>" />
        <jsp:param name="username_allievo" value="<%=username[i-1]%>" />
        <jsp:param name="resume_username" value="<%=isResumeUsername%>" />
        <jsp:param name="resume_label" value="<%=resumeLabel%>" />
        <jsp:param name="index" value="<%=i%>" />
        <jsp:param name="totalIndexes" value="<%=totalIndexes%>" />
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

<script>
    function send() {
        document.getElementById("form").submit();
    }
</script>

<script src="static/js/jquery-3.6.4.min.js"></script>
<script src="static/js/card-visore.js"></script>
<script src="static/js/modale-card-visore.js"></script>
<script src="static/js/preload-card-visore.js"></script>
<script src="static/js/scroll-card-visore.js"></script>
<script src="static/js/search-modale-visor.js"></script>


<%-- Modale per la visualizzazione del visore --%>
<%
    List<String> linkList = (List<String>) request.getAttribute("argoments");

    if(linkList == null) {
        linkList = new ArrayList<>();
    }
    Map<String, String> linkMap = new HashMap<>();
    int i = 1;

    for (String link : linkList) {
        linkMap.put(String.valueOf(i), link);
        i++;
    }

    request.setAttribute("linkMap", linkMap);
%>

<jsp:include page="include/modale-abilita-visore.jsp">
      <jsp:param name="linkMap" value="<%= linkMap %>"/>
</jsp:include>

<jsp:include page="include/scroll-page.jsp"></jsp:include>


</form>

