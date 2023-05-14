    <section class="card-container">
        <div class="card">
            <figure class="hexagon front">
                <div class="card-content">
                    <a href="#">${param.nome_visore}</a>
                </div>
                <div class="visore_small">
                    <img src="static/images/visore_small.png"  alt="Visore">
                     <span class="tick">
                        <!--
                        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" viewBox="0 0 20 20">
                          <path fill="#4CAF50" d="M18.3 3.3c-.4-.4-1-.4-1.4 0L7 13.6 3.1 9.7c-.4-.4-1-.4-1.4 0s-.4 1 0 1.4l4 4c.2.2.5.3.7.3s.5-.1.7-.3l12-12c.4-.4.4-1 0-1.4z"/>
                        </svg> -->
                        <svg xmlns="http://www.w3.org/2000/svg" width="110" height="110" viewBox="0 0 20 20">
                         <path d="M6 0v1h-6v1h6v1l2-1.5-2-1.5zm-4 4l-2 1.5 2 1.5v-1h6v-1h-6v-1z" fill="yellowgreen" />
                        </svg>
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
