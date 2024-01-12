<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%-- Inizializzazione variabile --%>
<% String[] lbls = new String[7]; %>

<%-- Popolamento delle variabili usando spring:message --%>
<spring:message code="form.menu-alto.classroom.button.title" var="aule" />
<spring:message code="form.menu-alto.class.button.title" var="classi" />
<spring:message code="form.menu-alto.visor.button.title" var="visori" />
<spring:message code="form.menu-alto.resource.button.title" var="risorseLabel" />
<spring:message code="form.menu-alto.users.button.title" var="utentiLabel" />
<spring:message code="form.menu-alto.diagnose.button.title" var="diagnosi" />
<spring:message code="form.menu-alto.logout.button.title" var="logout" />

<%
    lbls[0] = (String) pageContext.getAttribute("aule");
    lbls[1] = (String) pageContext.getAttribute("classi");
    lbls[2] = (String) pageContext.getAttribute("visori");
    lbls[3] = (String) pageContext.getAttribute("risorseLabel");
    lbls[4] = (String) pageContext.getAttribute("utentiLabel");
    lbls[5] = (String) pageContext.getAttribute("diagnosi");
    lbls[6] = (String) pageContext.getAttribute("logout");
%>

<%
    Boolean isCloseVisorLogout = request.getAttribute("isCloseVisorLogout") != null ? (Boolean)request.getAttribute("isCloseVisorLogout") : false;
    String scuola = request.getAttribute("scuola") != null ? (String)request.getAttribute("scuola") : "";
    String risorse = request.getAttribute("risorse") != null ? (String)request.getAttribute("risorse") : "";
    String utenti = request.getAttribute("utenti") != null ? (String)request.getAttribute("utenti") : "";

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


