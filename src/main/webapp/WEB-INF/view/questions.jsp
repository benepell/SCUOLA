<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <title>Questionario</title>
    <link href="<c:url value='/static/css/style-questions.css'/>" rel="stylesheet">
</head>
<body>
    <div class="content">
        <div class="container">
            <h2 style="text-align: center;">Questionario</h2>
            <form id="questionForm" method="post"
                 data-mac="${macAddress}"
                 data-text="${text}">

                <c:forEach var="question" items="${questions}" varStatus="status">
                    <div class="question">
                        <h3>${question.domanda}</h3>
                        <!-- Opzionale: visualizza media se presente -->
                        <c:if test="${not empty question.media}">
                            <div class="question-media">
                                <img src="${question.media}" alt="">
                            </div>
                        </c:if>
                        <div class="answers">
                            <c:forEach var="answer" items="${question.risposte}" varStatus="ansStatus">
                                <div>
                                    <label>
                                        <input type="checkbox" data-question-id="${question.id}" value="${answer.id}">
                                        ${ansStatus.index + 1}) ${answer.testo}
                                    </label>
                                    <!-- Opzionale: visualizza media per risposta se presente -->
                                    <c:if test="${not empty answer.media}">
                                        <div class="answer-media">
                                            <img src="${answer.media}" alt="">
                                        </div>
                                    </c:if>
                                </div>
                                <br> <!-- Assicura che ogni risposta sia a capo -->
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>
                <button type="submit" class="btn-custom" style="display: block; margin-left: auto; margin-right: auto;">Invia Risposte</button>
            </form>
        </div>
    </div>
    <footer>
        <p>Copyright © 2024 Tutti i diritti riservati.</p>
    </footer>
    <script src="static/js/questions.js"></script>
</body>
</html>
