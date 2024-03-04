<?php

    define('CLIENT_ID', 'client');
    define('CLIENT_SECRET', getenv('VRSCUOLA_KEYCLOAK_SECRET'));
    define('REDIRECT_URI', getenv('VRSCUOLA_RESOURCES_URL') . '/res.php');
    define('URL_AUTHORIZE', getenv('VRSCUOLA_KEYCLOAK_URL') . '/realms/scuola/protocol/openid-connect/auth');
    define('URL_ACCESS_TOKEN', getenv('VRSCUOLA_KEYCLOAK_URL') . '/realms/scuola/protocol/openid-connect/token');
    define('URL_RESOURCE_OWNER_DETAILS', getenv('VRSCUOLA_KEYCLOAK_URL') . '/realms/scuola/protocol/openid-connect/userinfo>

?>