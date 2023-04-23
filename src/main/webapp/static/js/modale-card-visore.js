  function showDemoModal(valoreCerchio) {
    // Mostra la finestra modale
    var modal = $("#demo-modal");
    modal.show();

    // Seleziona l'elemento del cerchio
    var cerchio = document.getElementById('cerchio');

    // Imposta il contenuto dell'elemento con il valore della variabile
    cerchio.innerHTML = valoreCerchio;

    // Aggiungi un gestore di eventi per la chiusura della finestra modale
    modal.find(".close-btn").click(function () {
      showmod = false;
      modal.hide();
    });
  }