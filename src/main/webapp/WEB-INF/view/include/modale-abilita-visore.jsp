<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>


<div id="demo-modal" class="modal">
  <div class="modal-content">
  <div class="cerchio" id="cerchio">&nbsp;</div>
    <span class="close-btn">&times;</span>
    <h2>Seleziona un argomento</h2>
    <div class="iframe-container">
          <iframe srcdoc='
                <!DOCTYPE html>
                <html>
                  <head>
                    <style>
                      * {
                        margin: 0;
                        padding: 0;
                      }

                      body {
                        background-color: #e4eeda;
                        font-family: sans-serif;
                      }

                      ul {
                        list-style: none;
                        padding: 20px;
                        max-height: 450px;
                        overflow: auto;
                      }

                      li {
                        margin-bottom: 10px;
                      }

                      a {
                        color: #6D4C41;
                        text-decoration: none;
                        font-size: larger;
                        line-height: 1.4rem;
                      }

                      a:hover {
                        text-decoration: underline;
                      }
                    </style>
                  </head>
                  <body>

                    <ul>
                      <%
                        Map<String, String> linkMap = (Map<String, String>) request.getAttribute("linkMap");
                        for (Map.Entry<String, String> entry : linkMap.entrySet()) { %>
                        <li><a onclick="clicktrasporto(&apos;<%= entry.getKey() %>&apos;,&apos;<%= entry.getValue() %>&apos;)" href="#"><%= entry.getValue() %></a></li>
                      <% } %>
                    </ul>

                    <script>
                       function clicktrasporto(id_arg,arg) {
                         var message = {
                           action: "linkClicked",
                           id_argomento: id_arg,
                           argomento: arg
                         };
                         parent.postMessage(message, "*");
                       }
                    </script>
                  </body>
                </html>' sandbox="allow-same-origin allow-forms allow-scripts"></iframe>
        </div>
  </div>
</div>
