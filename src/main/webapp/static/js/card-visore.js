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

$("figure.hexagon.front").click(function() {
  var input_id = $(this).parent().parent().find('input[type=hidden]').attr('id');
  var index = input_id.split("-")[1];
  var usernameAllievo = $('#' + "username" + "-" + index).val()
  var nomeAllievo = $('#' + "nome" + "-" + index).val();
  var codiceVisore = $('#' + "codicevisore" + "-" + index).val();

  var $clicked_figure = $(this);

    // Chiamata AJAX per ottenere il codice del visore
    $.post("/visore-selection", { allievo: nomeAllievo }, function (data) {
        setCodiceVisore(data.visore);
        $clicked_figure.next('.hexagon.back').find('.see-more.valore').text(data.visore);
        $('#' + "codicevisore" + "-" + index).val(data.visore);

        if (data.num_visore_occup === undefined) {
                // Non ci sono visori disponibili, mostra l'alert
                var $alert = $('<div class="alert alert-warning" style="width:80%;padding-inline-start: 30px;background-color: #79656580;font-size: 20px;color: yellowgreen; border: 2px solid #C5E1A5" role="alert">Non ci sono visori disponibili.</div>');
                $('body').append($alert);
                setTimeout(function () {
                  $alert.alert('close'); // Chiudi l'alert dopo 3 secondi
                }, 5000);
        }
    });

});

$("figure.hexagon.back").click(function() {
  var input_id = $(this).parent().parent().find('input[type=hidden]').attr('id');
  var index = input_id.split("-")[1];
  var usernameAllievo = $('#' + "username" + "-" + index).val()
  var nomeAllievo = $('#' + "nome" + "-" + index).val();

  var $clicked_figure = $(this);
    // Chiamata AJAX per ottenere il codice del visore
    if(!getShowmod){
        $.post("/visore-remove", { allievo: nomeAllievo }, function (data) {
            $clicked_figure.next('.hexagon.front').find('.see-more.valore').text('');
        });
    }

});

$(".hexagon-inset").click(function () {
  setShowmod(true);
   var inset_input_id = $(this).parent().parent().parent().find('input[type=hidden]').attr('id');
   var inset_index = inset_input_id.split("-")[1];
   showDemoModal($('#' + "codicevisore" + "-" + inset_index).val());
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
