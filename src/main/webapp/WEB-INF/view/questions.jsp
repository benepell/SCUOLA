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
            <h2>Questionario</h2>
            <form id="questionForm" method="post"
                  data-aula="${aula}"
                  data-classe="${classe}"
                  data-sezione="${sezione}"
                  data-argomento="${argomento}"
                  data-username="${username}"
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
                                        <input type="checkbox" name="answer_${question.id}" value="${answer.id}">
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
                <button type="submit" class="btn-custom">Invia Risposte</button>
            </form>
        </div>
    </div>
    <footer>
        <p>Copyright © 2024 Tutti i diritti riservati.</p>
    </footer>
     <script>
   document.addEventListener('DOMContentLoaded', function() {
       const form = document.getElementById('questionForm');

       form.addEventListener('submit', function(event) {
           event.preventDefault(); // Impedisce il normale invio del form

           // Prepara i dati del form per l'invio
             const formData = {
                         aula: form.dataset.aula,
                         classe: form.dataset.classe,
                         sezione: form.dataset.sezione,
                         argomento: form.dataset.argomento,
                         text: form.dataset.text,
                         username: form.dataset.username,
                         questionAnswers: []
                     };

           // Invia i dati al server
           fetch('/answers', {
               method: 'POST',
               headers: {
                   'Content-Type': 'application/json'
               },
               body: JSON.stringify(formData)
           })
           .then(response => {
               if (!response.ok) {
                   throw new Error('Network response was not ok');
               }
               return response.text();
           })
           .then(data => {
               try {
                   const jsonData = JSON.parse(data);
                   console.log("Risposta ricevuta (JSON):", jsonData);
                   alert(`Test svolto correttamente!`);
                   // Gestisci qui la risposta JSON
               } catch (error) {
                   console.error('Errore nell\'analisi JSON:', error);
                   console.log("Risposta ricevuta (Testo):", data);
                    alert(`Test non inviato!`);
                   // Gestisci qui la risposta come testo (probabilmente un messaggio di errore)
               }
           })
           .catch(error => {
               console.error('Errore nell\'invio delle risposte:', error);
           });
       });
   });

    </script>
</body>
</html>
