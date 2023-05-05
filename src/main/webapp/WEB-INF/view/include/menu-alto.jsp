<!-- codice menu -->
<%
    String risorse = (String)request.getAttribute("risorse") != null ? (String)request.getAttribute("risorse") : "";
    String utenti = (String)request.getAttribute("utenti") != null ? (String)request.getAttribute("utenti") : "";
    String[] lbls = new String[] { "CLASSE", "VISORI", "RISORSE", "UTENTI","LOGOUT"};
    String[] li = new String[] { "/abilita-classe","/setup-visore", risorse, utenti + "/admin/master/console/#/scuola/users", "/logout" };
    String[] targets = new String[] { "_self", "_self", "_blank", "_blank", "_self" };
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
