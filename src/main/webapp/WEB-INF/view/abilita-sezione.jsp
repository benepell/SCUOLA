<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="jumbotron jumbotron-billboard">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
              <h3 style="color: white;">${intestazione} </h3>
            </div>
        </div>
    </div>
</div>

<!-- Form per inviare il valore della classe selezionata -->
<form id="form" method="post" action="/sezione">
  <input type="hidden" id="classSelected" name="classSelected" value="${classSelected}" />
  <input type="hidden" id="sectionSelected" name="sectionSelected" value="${sectionSelected}" />

<%
    String[] letters = (String[])session.getAttribute("allSections");;
%>

<!-- codice sezione -->

<div class="mysez-sezione">
  <h1>Scegli la Sezione</h1>

  <!-- barra centrale -->
  <div class="mysez-barra-centrale">

    <%
      for(String letter : letters) {
    %>
        <a href="#section-<%=letter%>"><%=letter%></a>
    <%
      }
    %>
  </div>
</div>

<-- collegamento lettera corrispondente -->
<div class="mysez-container">
  <div class="row">
    <div class="col-md-12">
      <div>
        <%
          for(String letter : letters) {
        %>
          <section class="mysez-section" id="section-<%=letter%>">
            <h2>Sezione <span><%=letter%></span></h2>
            <button onclick="setSectionSelected('<%=letter%>')" type="button" class="mysez-btn mysez-btn-primary mysez-btn-3d">Avanti --&gt;</button>
          </section>
        <% } %>
      </div>
    </div>
  </div>
</div>

</form>
    <!-- Script per impostare il valore della sezione selezionata e inviare il form -->
    <script>
      function setSectionSelected(sectionName) {
        document.getElementById('sectionSelected').value = sectionName;
        document.getElementById('form').submit();
      }
    </script>
