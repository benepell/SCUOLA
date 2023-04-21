<section class="card-container">
  <div class="card">
    <figure class="hexagon front">
      <div class="card-content">
        <a href="#">${param.nome_allievo}</a>
      </div>
      <div class="visore_small">
        <img src="static/images/visore_small.png" alt="Visore" />
        <jsp:include page="lampeggio.jsp">
          <jsp:param name="enable" value="true" />
        </jsp:include>
      </div>
      <div class="visore_text">
        <span>${param.codice_visore}</span>
      </div>
      <span class="see-more"><i class="fa fa-repeat"></i></span>
    </figure>
    <figure class="hexagon back">
      <div class="card-content">
        <h1>${param.nome_allievo} Attivo</h1>
      </div>
      <div class="hexagon-inset">
        <div class="card-content">
          <img src="static/images/profile.png" />
        </div>
      </div>
      <span class="see-more" style="transform: rotate(0) !important"
        >${param.codice_visore}</span
      >
    </figure>
  </div>
</section>
