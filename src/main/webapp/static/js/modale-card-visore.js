  function showDemoModal(valoreCerchio) {
    // Mostra la finestra modale
    var modal = $("#demo-modal");
    // set display modal
    modal.css("display", "block");
    // reload iframe
    modal.find("iframe").attr("srcdoc", modal.find("iframe").attr("srcdoc"));
    modal.show();

    // Seleziona l'elemento del cerchio
    var cerchio = document.getElementById('cerchio');

    // Imposta il contenuto dell'elemento con il valore della variabile
    cerchio.innerHTML = valoreCerchio;

    // Aggiungi un gestore di eventi per la chiusura della finestra modale
    modal.find(".close-btn").click(function () {
      setShowmod(false);
      modal.hide();
    });
  }

// Aggiungi un listener per ricevere i messaggi dall'iframe

window.addEventListener("message", function(event) {
  if (event.data.action === "linkClicked") {
    var modal = document.getElementById("demo-modal");
    modal.style.display = "none";
    setShowmod(false);

    var loading = document.createElement("div");

    // Aggiungi la finestra di caricamento
    loading.style.position = "fixed";
    loading.style.top = 0;
    loading.style.left = 0;
    loading.style.width = "100%";
    loading.style.height = "100%";
    loading.style.background = "rgba(0, 0, 0, 0.5)";
    loading.style.display = "flex";
    loading.style.justifyContent = "center";
    loading.style.alignItems = "center";

    var message = document.createElement("p");
    message.style.color = "yellow";
    message.style.fontFamily = "Arial, sans-serif";
    message.style.fontSize = "50px";
    message.style.textAlign = "left";
    message.textContent = "Caricamento in corso...";

    loading.appendChild(message);

    // Aggiungi un'immagine di una barra di avanzamento
    var progressBar = document.createElement("img");
    progressBar.src = "static/images/animazione-loading.gif";
    progressBar.style.border = "3px solid #C5E1A5";
    progressBar.style.padding = "20px";
    progressBar.style.margin = "16px";
    progressBar.style.width = "350px";
    progressBar.style.height = "350px";
    progressBar.style.borderRadius = "60%";
    progressBar.style.filter = "brightness(75%)";
    progressBar.style.opacity = 0.7;
    loading.appendChild(progressBar);

    document.body.appendChild(loading);

        var formData = new FormData();
          // aggiungi i dati da inviare
          formData.append('argomento', event.data.argomento);
          formData.append('visore', event.data.visore);
          fetch('argomento-visore', {
            method: 'POST',
            body: formData
          }).then(function(response) {
             if (response !== null && response.status === 200) {
                 setTimeout(function() {
                   document.body.removeChild(loading);
                 }, 3000);
             } else {  // aggiungi questo blocco else
                document.body.removeChild(loading);
                alert("Errore di caricamento ( " + response.status + " )" );
             }

            // gestisci la risposta della pagina di destinazione qui
          }).catch(function(error) {
            document.body.removeChild(loading);
            alert("Errore di caricamento ( " + response.status + " )" );
          });

    // remove loading

  }
});