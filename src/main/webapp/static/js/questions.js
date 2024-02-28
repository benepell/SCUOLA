  document.addEventListener('DOMContentLoaded', function() {
      const form = document.getElementById('questionForm');

      form.addEventListener('submit', function(event) {
          event.preventDefault(); // Impedisce il normale invio del form

          // Raccoglie le risposte selezionate
          const selectedAnswers = {};
          document.querySelectorAll('input[type="checkbox"]:checked').forEach(input => {
              const questionId = input.getAttribute('data-question-id');
              if (!selectedAnswers[questionId]) {
                  selectedAnswers[questionId] = [];
              }
              selectedAnswers[questionId].push(input.value);
          });

          // Prepara il JSON da inviare
          const formData = {
              aula: form.dataset.aula,
              classe: form.dataset.classe,
              sezione: form.dataset.sezione,
              argomento: form.dataset.argomento,
              text: form.dataset.text,
              username: form.dataset.username,
              questionAnswers: Object.keys(selectedAnswers).map(questionId => ({
                  questionId: questionId,
                  answerIds: selectedAnswers[questionId]
              }))
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
