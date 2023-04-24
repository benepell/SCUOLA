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

 $("figure").click(function() {
   var codiceVisore = $(this).find('.visore_text span').text();
   if (codiceVisore == '') {
       codiceVisore = $(this).find('.valore').text();
   }
   setCodiceVisore(codiceVisore);
 });

 $(".hexagon-inset").click(function () {
    setShowmod(true);
    showDemoModal(getCodiceVisore());
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
