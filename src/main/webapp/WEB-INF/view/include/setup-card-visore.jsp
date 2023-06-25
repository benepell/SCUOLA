 <%@ page language="java" %>
 <%@ page import="it.vrscuola.scuola.utilities.Utilities" %>

    <section class="card-container">
        <div class="card">
            <figure class="hexagon front">
                <div class="card-content">
                    <a href="#">${param.nome_visore}</a>
                </div>
                <div class="visore_small">
                    <img src="static/images/visore_small.png"  alt="Visore">
                     <span class="tick-batt">
                        <!-- qui codice battVisore -->
                        <%
                        int batteryLevel = 0;
                        if (request != null) {
                            String battVisore = request.getParameter("batt_visore");
                            if (battVisore != null && !battVisore.isEmpty()){
                                batteryLevel = Integer.parseInt(battVisore);
                            }
                        }

                        String cssWidth = "120px";
                        Utilities obj = new Utilities();
                        String svg = obj.generateBatterySVG(batteryLevel, cssWidth);
                        %>
                        <%= svg %> <!-- This will print the SVG code -->
                      </span>
                       <jsp:include page="lampeggio.jsp">
                          <jsp:param name="enable" value="true" />
                       </jsp:include>

                </div>

                <div class="setup_visore_text ${param.codice_visore}">
                    <span>${param.codice_visore}</span>
                </div>
                <span class="see-more"><i class="fa fa-repeat"></i></span>

            </figure>
        </div>
    </section>
