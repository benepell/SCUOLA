<section class="card-container">
  <div class="card">
    <input type="hidden" id="username-${param.index}" value="${param.username_allievo}">
    <input type="hidden" id="nome-${param.index}" value="${param.nome_allievo}">
    <input type="hidden" id="codicevisore-${param.index}" value="">


    <figure class="hexagon front">
      <div class="card-content">
        <a href="#">${param.nome_allievo}</a>
      </div>
      <div class="visore_small">
        <img src="static/images/visore_small.webp" alt="Visore"/>
            <jsp:include page="lampeggio.jsp">
            <jsp:param name="enable" value="true" />
        </jsp:include>
      </div>
      <div class="visore_text">
        <span>-</span>
      </div>
      <span class="see-more"><i class="fa fa-repeat"></i></span>
    </figure>
    <figure class="hexagon back">
      <div class="card-content">
        <h1>${param.nome_allievo}</h1>
      </div>
      <div class="hexagon-inset">
        <div class="card-content">
          <img src="static/images/profile.webp" />
        </div>
      </div>
      <span class="see-more valore" style="transform: rotate(0) !important"
        >&nbsp;</span>
    </figure>
  </div>
</section>
