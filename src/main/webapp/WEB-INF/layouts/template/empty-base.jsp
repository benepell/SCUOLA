<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%> 
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<!DOCTYPE html>
<html lang="it">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CSS -->
    <link href="<c:url value="/static/css/bootstrap.min.css" />" rel="stylesheet">

  
    <!-- Altri CSS -->
    <link href="<c:url value="/static/css/empty-main.css" />" rel="stylesheet">

    <link href="<c:url value="/static/css/style-classe.css" />" rel="stylesheet">
    <link href="<c:url value="/static/css/style-sezione.css" />" rel="stylesheet">
    <link href="<c:url value="/static/css/style-visore.css" />" rel="stylesheet">


    <title><tiles:insertAttribute name="titolo" /></title>
  </head>
  <body>

  <c:set var="currentLanguage" value="${cookie['localeInfo'].value}" />
   <section class="locale-link" style="position: fixed;top: 0;right: 40px;background: none;border: none;z-index: 9999;">
       <c:choose>
           <c:when test="${currentLanguage == 'it'}">
               <a href="?language=en"><img src="<c:url value='/static/images/IT.png' />" style="width: 80%;"></a>
           </c:when>
           <c:otherwise>
               <a href="?language=it"><img src="<c:url value='/static/images/US.png' />" style="width: 80%;"></a>
           </c:otherwise>
       </c:choose>
   </section>

     <tiles:insertAttribute name="content" /> 

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script type="text/javascript" src="<c:url value="/static/js/jquery-3.6.4.min.js" />"></script>
    <script type="text/javascript" src="<c:url value="/static/js/bootstrap.min.js" />"></script>
     <script type="text/javascript" src="<c:url value="/static/js/main.js" />"></script>
     <script type="text/javascript" src="<c:url value="/static/js/Sortable.min.js" />"></script>
     <script type="text/javascript" src="<c:url value="/static/js/language.js" />"></script>
  </body>

</html>