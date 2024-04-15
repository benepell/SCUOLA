<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="common/empty-base.jsp" %>

<div class="jumbotron jumbotron-billboard">
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <h3 style="color: white">${intestazione}</h3>
      </div>
    </div>
  </div>
</div>

<jsp:include page="include/menu-alto.jsp"></jsp:include>

<form id="form" method="post" action="/classroom">
  <input
    type="hidden"
    id="classroomSelected"
    name="classroomSelected"
    value="${classroomSelected}"
  />

  <section class="my-card-container">
    <c:forEach var="i" begin="1" end="5">
      <div class="my-card">
        <div class="my-card-front">
          <h3><spring:message code="form.abilita-classe.classroom"/> ${i}</h3>
        </div>
        <div class="my-card-back">
          <h3>Lab ${i}</h3>
          <!-- Aggiungi l'attributo data-classe con il valore della classe -->
          <button data-classe="${i}" onclick="setClassSelected('${i}')">
            <spring:message code="form.abilita-classe.button.title"/>
          </button>
        </div>
      </div>
    </c:forEach>
  </section>

<div class="video-background">
  <video id="myVideo" src="static/video/video.mp4" autoplay loop muted></video>
</div>

</form>

<script src="static/js/jquery-3.6.4.min.js"></script>
<script>
  $(document).ready(function () {
    $.ajax({
      url: "/keycloak-users/filter",
      type: "GET",
      success: function (data) {
        var classi = [];
        for (var i = 0; i < data.length; i++) {
          var classe = data[i].classe;
          classi.push(classe);
        }
      },
    });
  });
</script>

<script>
  // pause and play video
  var video = document.getElementById('myVideo');

  video.addEventListener('click', function() {
    if (video.paused) {
      video.play();
    } else {
      video.pause();
    }
  });
</script>

<script>
  function setClassSelected(className) {
    document.getElementById("classroomSelected").value = className;
    document.getElementById("form").submit();
  }
</script>

