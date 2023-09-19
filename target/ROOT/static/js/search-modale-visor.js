  $(document).ready(function() {
    $('#searchButton').click(function() {
      searchName();
    });
  });

  function searchName() {
    var searchTerm = $('#searchBox').val().toLowerCase();

    if (searchTerm.length < 3) {
        displayModal("Inserire almeno 3 caratteri per effettuare la ricerca.");
        return; // Interrompi la ricerca se il termine è troppo corto
      }

    $('.container a').removeClass('highlighted');
    $('.container a:contains("' + searchTerm + '")').addClass('highlighted');

    if ($('.container a.highlighted').length === 0) {
        displayModal("Nominativo non trovato");
    } else {
      // Effettua lo scroll fino al nome trovato
      var highlightedElement = $('.container a.highlighted').first();
      $('html, body').animate({ scrollTop: highlightedElement.offset().top }, 500);
    }
  }

  function handleEnterKey(event) {
    if (event.key === "Enter") {
      event.preventDefault(); // Evita l'invio del modulo se presente
      searchName(); // Esegui la ricerca quando viene premuto "Invio"
    }
  }

  function displayModal(message) {
    $('#modalMessage').text(message);
    $('#resultModal').modal('show');

    // Chiudi il modale automaticamente dopo 2 secondi
    setTimeout(function() {
      $('#resultModal').modal('hide');
    }, 2000);
  }
