 $(document).ready(function() {
     $("section.locale-link a").on('click', function(event) {
         var newLang = $(this).attr('href').split('=')[1];
         document.cookie = "localeInfo=" + newLang + ";path=/";
     });
 });
