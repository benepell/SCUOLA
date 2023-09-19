
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%> 
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%> 
 

<!DOCTYPE html>
<html lang="it">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CSS -->
    <link href="<c:url value="/static/css/bootstrap.min.css" />" rel="stylesheet">
     
    <!-- Altri CSS -->
    <link href="<c:url value="/static/css/minimal-main.css" />" rel="stylesheet">


    <title><tiles:insertAttribute name="titolo" /></title>
  </head>
  <body>
     <tiles:insertAttribute name="content" /> 
     
     <tiles:insertAttribute name="footer" />  
      
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script type="text/javascript" src="<c:url value="/static/js/jquery-3.6.4.min.js" />"></script>
    <script type="text/javascript" src="<c:url value="/static/js/bootstrap.min.js" />"></script>
     <script type="text/javascript" src="<c:url value="/static/js/main.js" />"></script>
     <script type="text/javascript" src="<c:url value="/static/js/Sortable.min.js" />"></script>
  </body>
</html>