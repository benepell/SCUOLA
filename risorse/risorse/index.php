<?php
session_start();

// ini_set ( 'display_errors', 1 );
// error_reporting ( E_ALL );

require 'vendor/autoload.php';
require 'vars.php';

use League\OAuth2\Client\Provider\GenericProvider;
use League\OAuth2\Client\Provider\Exception\IdentityProviderException;

$provider = new GenericProvider([
    'clientId'                => CLIENT_ID,
    'clientSecret'            => CLIENT_SECRET,
    'redirectUri'             => REDIRECT_URI,
    'urlAuthorize'            => URL_AUTHORIZE,
    'urlAccessToken'          => URL_ACCESS_TOKEN,
    'urlResourceOwnerDetails' => URL_RESOURCE_OWNER_DETAILS
]);

// Aggiungi logout get param logout=true per distruggere la sessione
if(isset($_GET['logout']) && $_GET['logout'] == true) {
    session_destroy();
    header('Location: ' . 'https://vrscuola.duckdns.org/logout');
    exit();
}

if(!isset($_GET['code'])) {
    $authorizationUrl = $provider->getAuthorizationUrl();
    header('Location: ' . $authorizationUrl);
    exit();
} else {
    // Redirect a res.php
    header('Location: res.php');
    exit();
}
?>
