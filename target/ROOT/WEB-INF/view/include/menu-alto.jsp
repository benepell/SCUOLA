<!-- codice menu -->
<%
    Boolean isCloseVisorLogout = request.getAttribute("isCloseVisorLogout") != null ? (Boolean)request.getAttribute("isCloseVisorLogout") : false;
    String scuola = request.getAttribute("scuola") != null ? (String)request.getAttribute("scuola") : "";
    String risorse = request.getAttribute("risorse") != null ? (String)request.getAttribute("risorse") : "";
    String utenti = request.getAttribute("utenti") != null ? (String)request.getAttribute("utenti") : "";
    String[] lbls = new String[] { "AULE", "CLASSI", "VISORI", "RISORSE", "UTENTI", "DIAGNOSI","LOGOUT"};
    String[] li = new String[] {"/abilita-classe", "/abilita-sezione","/setup-visore", risorse, utenti + "/admin/master/console/#/scuola/users","/diagnosi" ,"/logout" };
    String[] targets = new String[] { "_self", "_self", "_self", "_blank", "_blank", "_self", "_self" };
%>
  <div class="mysez-sezione">
    <!-- barra centrale -->
    <div class="mysez-barra-centrale">
      <%
      int x = 0;
      for(String le : lbls) { %>
      <a href="<%=li[x]%>" target="<%=targets[x]%>"><%=le%></a>
      <% x++; } %>
    </div>
  </div>
