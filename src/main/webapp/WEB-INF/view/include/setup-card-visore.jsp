 <%@ page language="java" %>
 <%@ page import="org.duckdns.vrscuola.utilities.Utilities" %>

    <section class="card-container">
        <div class="card">
        <%
            boolean isOnline = false;
            if (request != null) {
                isOnline = "true".equals(request.getParameter("online_visore"));
            }
        %>
            <figure class="hexagon front" <%if (!isOnline){ out.print("style=\"filter: grayscale(100%);\"");  } else {out.print("style=\"filter: grayscale(0);\"");}%> >
                <div class="card-content">
                    <a href="#">${param.nome_visore}</a>
                </div>
                <div class="visore_small">
                    <img src="static/images/visore_small.webp"  alt="Visore">
                     <span class="tick-batt">
                        <!-- qui codice battVisore -->
                        <%
                      int batteryLevel = 0;
                      if (request != null) {
                          String battVisore = request.getParameter("batt_visore");
                          if (battVisore != null && !battVisore.isEmpty()) {
                              try {
                                  batteryLevel = Integer.parseInt(battVisore);
                              } catch (NumberFormatException e) {
                                  // valore di default a batteryLevel se necessario
                                  batteryLevel = 0;
                              }
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
