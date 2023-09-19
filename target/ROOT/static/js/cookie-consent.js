const cookieSettings = new BootstrapCookieConsentSettings({
  contentURL: "../page/cookie/cookie-consent-content",
  privacyPolicyUrl: "../page/cookie/privacy-policy.html",
  legalNoticeUrl: "../page/cookie/legal-notice.html",
  postSelectionCallback: function () {
      location.reload() // reload after selection
  }
})

function showSettingsDialog() {
  cookieSettings.showDialog()
}

$(document).ready(function () {
  $("#settingsOutput").text(JSON.stringify(cookieSettings.getSettings()))
  $("#settingsAnalysisOutput").text(cookieSettings.getSettings("statistics"))
})

// Add script for card toggle
const cards = document.querySelectorAll('.card');

cards.forEach(function(card) {
  const cardHeader = card.querySelector('.card-header');
  const cardBody = card.querySelector('.card-body');

  cardHeader.addEventListener('click', function() {
    cardBody.classList.toggle('d-none');
  });
});