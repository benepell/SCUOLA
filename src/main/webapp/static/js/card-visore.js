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
    var $figure = $(this);
    var codiceVisore = $figure.find('.visore_text span').text();
    var nomeAllievo = $figure.find(".card-content h1").text().toLowerCase();
   if (codiceVisore == '' && nomeAllievo != '') {
        // sono qui quando clicco per chiudere esagono
        nomeAllievo = nomeAllievo.replace(" attivo", "");
       $.post("/visore-remove", { allievo: nomeAllievo }, function(data) {
           setCodiceVisore(data.visore);

       });
   } else {
           // sono qui quando clicco per aprire esagono
          var nomeAllievo = $figure.find(".card-content a").text().toLowerCase();

           $.post("/visore-selection", { allievo: nomeAllievo }, function(data) {
             setCodiceVisore(data.visore);
             $('figure.hexagon').each(function() {
               var $figure = $(this);
               var $cardContent = $figure.find('.card-content');
               if (($cardContent.find('h1').text().toLowerCase())  === data.allievo.toLowerCase() + " attivo") {
                 $figure.find('.see-more.valore').text(data.visore);
               }
             });
           });
   }

 });

 $(".hexagon-inset").click(function () {
    setShowmod(true);
    alert(getCodiceVisore());
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
