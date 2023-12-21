<?php
session_start();

// ini_set ( 'display_errors', 1 );
// error_reporting ( E_ALL );

require 'vendor/autoload.php';

use League\OAuth2\Client\Provider\GenericProvider;
use League\OAuth2\Client\Provider\Exception\IdentityProviderException;

$provider = new GenericProvider([
    'clientId'                => 'client',
    'clientSecret'            => 'MizAkO7AcNiDEgsGwXIsCHWdhAlNMc2A',
    'redirectUri'             => 'https://vrscuola.duckdns.org:8443/res.php',
    'urlAuthorize'            => 'https://vrscuola-auth.duckdns.org:9443/realms/scuola/protocol/openid-connect/auth',
    'urlAccessToken'          => 'https://vrscuola-auth.duckdns.org:9443/realms/scuola/protocol/openid-connect/token',
    'urlResourceOwnerDetails' => 'https://vrscuola-auth.duckdns.org:9443/realms/scuola/protocol/openid-connect/userinfo'
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
