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

$("figure").click(function () {
  var $figure = $(this);
  var codiceVisore = $figure.find('.visore_text span').text();
  var nomeAllievo = $figure.find(".card-content h1").text().toLowerCase();
  if (nomeAllievo != '' && getShowmod() == false) {
    // sono qui quando clicco per chiudere esagono
    nomeAllievo = nomeAllievo.replace(" attivo", "");
    $.post("/visore-remove", { allievo: nomeAllievo }, function (data) {
      $figure.find('.see-more.valore').text('')

    });
  } else {
    // sono qui quando clicco per aprire esagono
    var nomeAllievo = $figure.find(".card-content a").text().toLowerCase();

    $.post("/visore-selection", { allievo: nomeAllievo }, function (data) {
      setCodiceVisore(data.visore);
      $('figure.hexagon').each(function () {
        var $figure = $(this);
        var $cardContent = $figure.find('.card-content');

        if (data != null &&
          data.allievo != null &&
          ($cardContent.find('h1').text().toLowerCase()) === data.allievo.toLowerCase() + " attivo") {
          $figure.find('.see-more.valore').text(data.visore);
        }

        if (data.visore === '1'){
            setTimeout(function () {
                showDemoModal(getCodiceVisore());
            }, 2000);
        }
        
      });

      if (data.num_visore_occup === undefined && !getShowmod()) {
        // Non ci sono visori disponibili, mostra l'alert
        var $alert = $('<div class="alert alert-warning" style="width:80%;padding-inline-start: 30px;background-color: #79656580;font-size: 20px;color: yellowgreen; border: 2px solid #C5E1A5" role="alert">Non ci sono visori disponibili.</div>');
        $('body').append($alert);
        setTimeout(function () {
          $alert.alert('close'); // Chiudi l'alert dopo 3 secondi

          $figure.find('.card-container.card.flipped').toggleClass("flipped");
        }, 6000);
      }
    });
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


