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

<!-- Form per inviare il valore della classe selezionata -->
<form id="form" method="post" action="/classe">
  <input type="hidden" id="classSelected" name="classSelected" value="${classSelected}" />

<!-- codice classe -->
	<section class="my-card-container">
        <div class="my-card">
          <div class="my-card-front">
            <h3>Classe Prima</h3>
          </div>
          <div class="my-card-back">
            <h3>Classe Prima</h3>
            <button onclick="setClassSelected('1')">Seleziona</button>
          </div>
        </div>

        <div class="my-card">
          <div class="my-card-front">
            <h3>Classe Seconda</h3>
          </div>
          <div class="my-card-back">
            <h3>Classe Seconda</h3>
            <button onclick="setClassSelected('2')">Seleziona</button>
          </div>
        </div>

        <div class="my-card">
          <div class="my-card-front">
            <h3>Classe Terza</h3>
          </div>
          <div class="my-card-back">
            <h3>Classe Terza</h3>
            <button onclick="setClassSelected('3')">Seleziona</button>
          </div>
        </div>

        <div class="my-card">
          <div class="my-card-front">
            <h3>Classe Quarta</h3>
          </div>
          <div class="my-card-back">
            <h3>Classe Quarta</h3>
                <button onclick="setClassSelected('4')">Seleziona</button>
          </div>
        </div>

        <div class="my-card">
          <div class="my-card-front">
            <h3>Classe Quinta</h3>
          </div>
          <div class="my-card-back">
            <h3>Classe Quinta</h3>
                <button onclick="setClassSelected('5')">Seleziona</button>
          </div>
        </div>
      </section>

    <div class="my-classe">
        <img src="static/images/classe.png" alt="classe" width="100%">
    </div>
    </form>

    <!-- Script per impostare il valore della classe selezionata e inviare il form -->
    <script>
      function setClassSelected(className) {
        document.getElementById('classSelected').value = className;
        document.getElementById('form').submit();
      }
    </script>
