  var showmod = false;
  var codice_visore;

  // set codice_visore
    function setCodiceVisore(value) {
        codice_visore = value;
    }

  // get codice_visore
    function getCodiceVisore() {
        return codice_visore;
    }

  function getShowmod() {
    return showmod;
  }

  function setShowmod(value) {
    showmod = value;
  }

  $(".hexagon-inset").click(function () {
    //var card = $(this);
    // card.toggleClass('flipped');
    // alert('click bp');
    showDemoModal(getCodiceVisore()); // Mostra la finestra modale per selezionare i form demo
    setShowmod(true);
  });

  // Modifica la funzione di gestione dell'evento click della carta
  $(".card").click(function () {
    var card = $(this);
    if (getShowmod() == false) {
      card.toggleClass("flipped");
    }
    showLoader(); // Mostra il loader
    setTimeout(function () {
      hideLoader(); // Nascondi il loader dopo 2 secondi
    }, 2000);
  });
