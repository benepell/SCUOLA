var showmod = false;
var codice_visore;
var isShowModal = false;
var isResume = false;

function getShowmod() {
  return showmod;
}

function setShowmod(value) {
  showmod = value;
}

$(document).ready(function () {
  var totalIndexes = parseInt($('#' + "totalIndexes").val()); // Assicurati che "totalIndexes" sia un valore numerico
  for (var index = 1; index <= totalIndexes; index++) {
    var resumeUsername = $('#' + "resumeusername" + "-" + index).val();
    var resumeLbl = $('#' + "codicevisore" + "-" + index).val();
    if (resumeUsername == "true") {
      isResume = true;
      var $hexagonBack = $('.hexagon.back');
      $hexagonBack.eq(index - 1).click();
      $hexagonBack.eq(index - 1).find('.see-more.valore').text(resumeLbl);
    }
  }
});

$("figure.hexagon.front").click(function() {
  var input_id = $(this).parent().parent().find('input[type=hidden]').attr('id');
  var index = input_id.split("-")[1];
  var usernameAllievo = $('#' + "username" + "-" + index).val();
  var nomeAllievo = $('#' + "nome" + "-" + index).val();
  var codiceVisore = $('#' + "codicevisore" + "-" + index).val();

  var $clicked_figure = $(this);

    // Chiamata AJAX per ottenere il codice del visore
    $.post("/visore-selection", { username: usernameAllievo, allievo: nomeAllievo }, function (data) {
        $clicked_figure.next('.hexagon.back').find('.see-more.valore').text(data.visore);
        $('#' + "codicevisore" + "-" + index).val(data.visore);

        if (data.num_visore_occup === undefined) {
                // Non ci sono visori disponibili
                setTimeout(function () {
                    $("span.close-btn").click();
                    // inserisci 0.5 secondi di ritardo per permettere la chiusura della modale
                    setTimeout(function () {
                        $clicked_figure.next('.hexagon.back').click();
                    }, 500);

                }, 1500);
        }
    });

});

$(".hexagon-inset").click(function () {
  setShowmod(true);
   var inset_input_id = $(this).parent().parent().parent().find('input[type=hidden]').attr('id');
   var inset_index = inset_input_id.split("-")[1];
   showDemoModal($('#' + "codicevisore" + "-" + inset_index).val());
   isShowModal= true;
});

$("figure.hexagon.back").click(function() {
  var input_id = $(this).parent().parent().find('input[type=hidden]').attr('id');
  var index = input_id.split("-")[1];
  var usernameAllievo = $('#' + "username" + "-" + index).val()
  var resumeUsername = $('#' + "resumeusername" + "-" + index).val();
  var nomeAllievo = $('#' + "nome" + "-" + index).val();

  var $clicked_figure = $(this);
    // Chiamata AJAX per ottenere il codice del visore
    if(!isShowModal && !isResume) {
        $.post("/visore-remove", { username: usernameAllievo, allievo: nomeAllievo }, function (data) {
            $clicked_figure.next('.hexagon.front').find('.see-more.valore').text('');
        });
    }

    isResume = false;
});

// Modifica la funzione di gestione dell'evento click della carta
$(".card").click(function () {
   isShowModal = false;
  var card = $(this);
  if (getShowmod() == false) {
    card.toggleClass("flipped");
  }
  showLoader(); // Mostra il loader
  setTimeout(function () {
    hideLoader(); // Nascondi il loader dopo 2 secondi
  }, 2000);
});
