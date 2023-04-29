<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%
    int codiceVisore = 0;
    String[] allievi = (String[])session.getAttribute("alunni");
    String[] username = (String[])session.getAttribute("username");
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
        <jsp:param name="username_allievo" value="<%=username[i-1]%>" />
        <jsp:param name="index" value="<%=i%>" />
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

<script src="static/js/jquery-3.6.4.min.js"></script>
<script src="static/js/card-visore.js"></script>
<script src="static/js/modale-card-visore.js"></script>
<script src="static/js/preload-card-visore.js"></script>
<script src="static/js/scroll-card-visore.js"></script>


<%-- Modale per la visualizzazione del visore --%>
<%
    List<String> linkList = (List<String>) session.getAttribute("argoments");

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

