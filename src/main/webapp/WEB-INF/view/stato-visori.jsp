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


<% if (setupVisori != null && setupVisori.length > 0 &&
        labelVisori != null && labelVisori.length > 0) { %>

    <h1 style="color: white; text-align: center">Stato Visori:</h1>

    <div class="container">
        <% int margin = 0; %>
        <% for (int j = 0; j <= Math.ceil(setupVisori.length / 4.0); j++) { %>
            <div class="row" style="margin-top:<%=margin%>px;">
                <% for (int i = 1 + j*4; i <= Math.min(setupVisori.length, 4 + j*4); i++) { %>
                <%
                   String onlineVisoreValue = onlineVisori != null ? onlineVisori[i-1] : "true" ;

                %>
                    <div class="col-md-3">
                        <jsp:include page="include/setup-card-visore.jsp">
                            <jsp:param name="nome_visore" value="<%=setupVisori[i-1]%>" />
                            <jsp:param name="codice_visore" value="<%=labelVisori[i-1]%>" />
                            <jsp:param name="batt_visore" value="<%=battVisori[i-1]%>" />
                            <jsp:param name="online_visore" value="<%=onlineVisoreValue%>" />

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
