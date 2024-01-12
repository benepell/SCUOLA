<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Errore</title>
    <% if (request.getAttribute("base_included") == null) {
           request.setAttribute("base_included", true);
    } %>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-6" style="margin-top: 20px !important;">
                <h2>Errore</h2>
                <c:if test="${not empty errorStatus}">
                    <p>Status dell'Errore: <c:out value="${errorStatus}" /></p>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <p>Messaggio di Errore: <c:out value="${errorMessage}" /></p>
                </c:if>
                <p>Si è verificato un errore durante l'esecuzione della richiesta.</p>
                <a href="/" class="btn btn btn-warning btn-lg">Home</a>
            </div>
        </div>
    </div>
</body>
</html>
