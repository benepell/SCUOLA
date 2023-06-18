<?php
require 'vendor/autoload.php';

use League\OAuth2\Client\Provider\GenericProvider;
use League\OAuth2\Client\Provider\Exception\IdentityProviderException;

$provider = new GenericProvider([
    'clientId'                => 'client',
    'clientSecret'            => 'MizAkO7AcNiDEgsGwXIsCHWdhAlNMc2A',
    'redirectUri'             => 'https://scuola.vrscuola.it:8443/res.php',
    'urlAuthorize'            => 'https://keycloak.vrscuola.it:9443/realms/scuola/protocol/openid-connect/auth',
    'urlAccessToken'          => 'https://keycloak.vrscuola.it:9443/realms/scuola/protocol/openid-connect/token',
    'urlResourceOwnerDetails' => 'https://keycloak.vrscuola.it:9443/realms/scuola/protocol/openid-connect/userinfo'
]);

if (!isset($_GET['code'])) {
    $authorizationUrl = $provider->getAuthorizationUrl();
    header('Location: ' . $authorizationUrl);
    exit;
} 
 
?>
