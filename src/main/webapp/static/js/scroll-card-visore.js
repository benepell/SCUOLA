  // Aggiungi la funzione per lo scroll verso l'alto con delay
  $("#scrollUpArrow").click(function () {
    $("html, body").animate({ scrollTop: 0 }, 150); // Tempo di delay in millisecondi (1000 = 1 secondo)
  });

  $(document).ready(function () {
    // Aggiungi l'evento di click all'elemento con l'ID scrollDownArrow
    $("#scrollDownArrow").click(function () {
      // Anima lo scrolling del corpo e dell'html alla fine del documento
      $("html, body").animate({ scrollTop: $(document).height() }, 150);
    });
  });
