<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="it">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CSS -->
    <link href="<c:url value="/static/css/bootstrap.min.css" />" rel="stylesheet">


    <!-- Altri CSS -->
    <link href="<c:url value="/static/css/main.css" />" rel="stylesheet">

    <!-- Altri CSS -->
    <link href="<c:url value="/static/css/cookie.css" />" rel="stylesheet">

    <title>
           <c:if test="${not empty titolo}">
                ${titolo}
           </c:if>
    </title>

  </head>

  <body>

   <div class="content" style="background-image: url(&quot;/static/svg/background.svg&quot;);">

    <c:if test="${not empty content}">
        <jsp:include page="${content}" />
    </c:if>

    <jsp:include page="common/footer.jsp" />

   </div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script type="text/javascript" src="<c:url value="/static/js/jquery-3.6.4.min.js" />"></script>
    <script type="text/javascript" src="<c:url value="/static/js/bootstrap.min.js" />"></script>
     <script type="text/javascript" src="<c:url value="/static/js/main.js" />"></script>
     <script type="text/javascript" src="<c:url value="/static/js/cookiechoices.js" />"></script>
      <script type="text/javascript" src="<c:url value="/static/js/bootstrap-cookie-consent-settings.js" />"></script>

     <script>
         const cookieSettings = new BootstrapCookieConsentSettings({
             contentURL: "<c:url value="/static/page/cookie/cookie-consent-content"/>",
             privacyPolicyUrl: "<c:url value="/static/page/cookie/privacy-policy.html"/>",
             legalNoticeUrl: "<c:url value="/static/page/cookie/legal-notice.html"/>",
             postSelectionCallback: function () {
                 location.reload(); // ricarica la pagina dopo la selezione
             }
         });

         function showSettingsDialog() {
             cookieSettings.showDialog();
         }

         $(document).ready(function () {
             $("#settingsOutput").text(JSON.stringify(cookieSettings.getSettings()));
             $("#settingsAnalysisOutput").text(cookieSettings.getSettings("statistics"));
         });

         // Aggiungi uno script per gestire il toggle delle card
         const cards = document.querySelectorAll('.card');

         cards.forEach(function(card) {
             const cardHeader = card.querySelector('.card-header');
             const cardBody = card.querySelector('.card-body');

             cardHeader.addEventListener('click', function() {
                 cardBody.classList.toggle('d-none');
             });
         });

     </script>
  </body>
</html>