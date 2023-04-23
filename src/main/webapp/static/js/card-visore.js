var showmod = false;
  $(".hexagon-inset").click(function () {
    //var card = $(this);
    // card.toggleClass('flipped');
    // alert('click bp');
    showDemoModal(4); // Mostra la finestra modale per selezionare i form demo
    showmod = true;
  });

  // Modifica la funzione di gestione dell'evento click della carta
  $(".card").click(function () {
    var card = $(this);
    if (showmod == false) {
      card.toggleClass("flipped");
    }
    showLoader(); // Mostra il loader
    setTimeout(function () {
      hideLoader(); // Nascondi il loader dopo 2 secondi
    }, 2000);
  });