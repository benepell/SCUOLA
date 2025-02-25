<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="common/empty-base.jsp" %>

<div class="jumbotron jumbotron-billboard">
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <h3 style="color: white">${intestazione} Aula: ${classroomSelected}</h3>
      </div>
    </div>
  </div>
</div>

<jsp:include page="include/menu-alto.jsp"></jsp:include>

<!-- Form per inviare il valore della classe selezionata -->
<form id="form" method="post" action="/classe">
  <input
    type="hidden"
    id="classSelected"
    name="classSelected"
    value="${classSelected}"
  />


  <%
    String[] classes = {"1", "2", "3", "4", "5"};
   String[] letters = (String[]) request.getAttribute("allSections");
  %>

  <!-- codice sezione -->

  <div class="mysez-sezione">
    <h1><spring:message code="form.abilita-sezione.title" /></h1>

    <!-- barra centrale -->
    <div class="mysez-barra-centrale">
      <% for(String cl : classes) {
      String c = (String)request.getAttribute("classSelected");
      String clazz =  c != null && c.equals(cl) ? "active": "";

       %>
      <a href="#" onclick="setClasseSelected('<%=cl%>')" class="<%=clazz%>"><%=cl%></a>
      <% } %>
    </div>
  </div>

</form>

  <!-- Form per inviare il valore della classe selezionata -->
  <form id="form1" method="post" action="/sezione">
    <input
      type="hidden"
      id="classSelected"
      name="classSelected"
      value="${classSelected}"
    />
    <input
      type="hidden"
      id="sectionSelected"
      name="sectionSelected"
      value="${sectionSelected}"
    />


  <div class="mysez-container">
    <div class="row">
      <div class="col-md-12">
        <div style="padding-bottom: 130px;">
          <% for(String letter : letters) { %>
          <section class="mysez-section" id="section-<%=letter%>">
            <h2><spring:message code="form.abilita-sezione.section" /> <span><%=letter.toUpperCase()%></span></h2>
            <button
              onclick="setSectionSelected('<%=letter%>')"
              type="button"
              class="mysez-btn mysez-btn-primary mysez-btn-3d"
            >
              <spring:message code="form.abilita-sezione.button.next" /> --&gt;
            </button>
          </section>
          <% } %>
        </div>
      </div>
    </div>
  </div>

  <div>
    <a
      href="#"
      id="scrollUpArrow"
      style="position: fixed; bottom: 110px; right: 35px"
    >
      <img
        src="static/images/scroll-up-arrow.png"
        style="border: 3px solid #0dcaf0cf;border-radius: 60px;"
        alt="Vai sopra"
        width="80"
        height="80"
      />
    </a>
  </div>
  <div>
    <a
      href="#"
      id="scrollDownArrow"
      style="
        position: fixed;
        transform: rotate(180deg);
        bottom: 20px;
        right: 35px;
      "
    >
      <img
        src="static/images/scroll-up-arrow.png"
        style="border: 3px solid #0dcaf0cf;border-radius: 60px;"
        alt="Vai sotto"
        width="80"
        height="80"
      />
    </a>
  </div>
</form>
<!-- Script per impostare il valore della sezione selezionata e inviare il form -->
<script src="static/js/jquery-3.6.4.min.js"></script>

<script>
    function setClasseSelected(classe) {
        document.getElementById("classSelected").value = classe;
        document.getElementById("form").submit();
    }

  function setSectionSelected(sectionName) {
    document.getElementById("sectionSelected").value = sectionName;
    document.getElementById("form1").submit();
  }
</script>

<script>
  // Aggiungi la funzione per lo scroll verso l'alto con delay
  $("#scrollUpArrow").click(function () {
    $("html, body").animate({ scrollTop: 0 }, 150); // Tempo di delay in millisecondi (1000 = 1 secondo)
  });

  $(document).ready(function () {
    // Aggiungi l'evento di click all'elemento con l'ID scrollDownArrow
    $("#scrollDownArrow").click(function () {
      // Anima lo scrolling del corpo e dell'html alla fine del documento
      $("html, body").animate({ scrollTop: $(document).height() }, 150);
    });
  });
</script>
