<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="jumbotron jumbotron-billboard">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <h3 style="color: white;">${intestazione}</h3>
            </div>
        </div>
    </div>
</div>

<form id="form" method="post" action="/classe">
    <input type="hidden" id="classSelected" name="classSelected" value="${classSelected}" />

    <section class="my-card-container">


  <c:forEach var="i" begin="1" end="5">
    <div class="my-card">
      <div class="my-card-front">
        <h3>Classe ${i}</h3>
      </div>
      <div class="my-card-back">
        <h3>Classe ${i}</h3>
        <!-- Aggiungi l'attributo data-classe con il valore della classe -->
        <button data-classe="${i}" onclick="setClassSelected('${i}')">Seleziona</button>
      </div>
    </div>
  </c:forEach>
</section>

    <div class="my-classe">
        <img src="static/images/classe.png" alt="classe" width="100%">
    </div>
</form>

<script src="static/js/jquery-3.6.4.min.js"></script>
  <script>
    $(document).ready(function() {
      $.ajax({
        url: '/keycloak-users/filter',
        type: 'GET',
        success: function(data) {
          var classi = [];
          for (var i = 0; i < data.length; i++) {
            var classe = data[i].classe;
            classi.push(classe);
          }
          // Disabilita i pulsanti delle classi non presenti nell'array
          $("button").each(function() {
            var classe = $(this).attr("data-classe");
            if (classi.indexOf(classe) === -1) {
              $(this).css("display", "none");
            }
          });
        }
      });
    });

  </script>

<script>
    function setClassSelected(className) {
        document.getElementById('classSelected').value = className;
        document.getElementById('form').submit();
    }
</script>
