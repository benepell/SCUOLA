<?php
ob_start(); // Avvia l'output buffering

session_start();
// ini_set ( 'display_errors', 1 );
// error_reporting ( E_ALL );
?>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=2">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>VrScuola Risorse</title>

     <style>
        .mysez {
          display: flex;
          justify-content: end;
          padding: 4px;
          margin: 1px;
          background-color: rgb(30 23 34 / 73%);
          border: 2px solid rgb(13 253 173 / 23%);
          color: white;
          font-weight: bold;
          text-decoration: none;
          border-radius: 5px;
          transition: background-color 0.3s, color 0.3s;
        }
      </style>

    <!-- Require JS (REQUIRED) -->
    <!-- Rename "main.default.js" to "main.js" and edit it if you need configure elFInder options or any things -->
    <script data-main="./main.default.js" src="js/require.min.js"></script>

    <script>
    define('elFinderConfig', {
        // elFinder options (REQUIRED)
        // Documentation for client options:
        // https://github.com/Studio-42/elFinder/wiki/Client-configuration-options
        defaultOpts: {
            url: 'php/connector.minimal.php', // or connector.maximal.php : connector URL (REQUIRED)
            commandsOptions: {
                edit: {
                    extraOptions: {
                        // set API key to enable Creative Cloud image editor
                        // see https://console.adobe.io/
                        creativeCloudApiKey: '',
                        // browsing manager URL for CKEditor, TinyMCE
                        // uses self location with the empty value
                        managerUrl: ''
                    }
                },
                quicklook: {
                    // to enable CAD-Files and 3D-Models preview with sharecad.org
                    sharecadMimes: ['image/vnd.dwg', 'image/vnd.dxf', 'model/vnd.dwf',
                        'application/vnd.hp-hpgl', 'application/plt', 'application/step', 'model/iges',
                        'application/vnd.ms-pki.stl', 'application/sat', 'image/cgm',
                        'application/x-msmetafile'
                    ],
                    // to enable preview with Google Docs Viewer
                    googleDocsMimes: ['application/pdf', 'image/tiff', 'application/vnd.ms-office',
                        'application/msword', 'application/vnd.ms-word', 'application/vnd.ms-excel',
                        'application/vnd.ms-powerpoint',
                        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                        'application/vnd.openxmlformats-officedocument.presentationml.presentation',
                        'application/postscript', 'application/rtf'
                    ],
                    // to enable preview with Microsoft Office Online Viewer
                    // these MIME types override "googleDocsMimes"
                    officeOnlineMimes: ['application/vnd.ms-office', 'application/msword',
                        'application/vnd.ms-word', 'application/vnd.ms-excel',
                        'application/vnd.ms-powerpoint',
                        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                        'application/vnd.openxmlformats-officedocument.presentationml.presentation',
                        'application/vnd.oasis.opendocument.text',
                        'application/vnd.oasis.opendocument.spreadsheet',
                        'application/vnd.oasis.opendocument.presentation'
                    ]
                }
            },
            // bootCalback calls at before elFinder boot up
            bootCallback: function(fm, extraObj) {
                /* any bind functions etc. */
                fm.bind('init', function() {
                    // any your code
                });
                // for example set document.title dynamically.
                var title = document.title;
                fm.bind('open', function() {
                    var path = '',
                        cwd = fm.cwd();
                    if (cwd) {
                        path = fm.path(cwd.hash) || null;
                    }
                    document.title = path ? path + ':' + title : title;
                }).bind('destroy', function() {
                    document.title = title;
                });
            }
        },
        managers: {
            // 'DOM Element ID': { /* elFinder options of this DOM Element */ }
            'elfinder': {}
        }
    });
    </script>
</head>

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


try{

$accessToken = $provider->getAccessToken('authorization_code', [
    'code' => $_GET['code']
]);

// Dati da inviare con la richiesta POST
$data = array('key' => 'risorse');

$options = array(
    'http' => array(
        'header'  => "Content-type: application/x-www-form-urlencoded\r\n" .
                     "Authorization: Bearer " . $accessToken->getToken() . "\r\n",
        'method'  => 'POST',
        'content' => http_build_query($data)
    )
);

// Crea il contesto della richiesta
$context  = stream_context_create($options);

// Effettua la chiamata POST all'endpoint
$response = file_get_contents('https://scuola.vrscuola.it/checkRes', false, $context);

 // Controlla se la risposta contiene la stringa "admins"
    if (strpos($response, 'admins') !== false) {
        $_SESSION['abilitato'] = true;
    } else {
        $_SESSION['abilitato'] = false;
        ob_end_clean(); // Cancella l'output buffering
        header("Location: https://scuola.vrscuola.it/");
        exit;
    }
} catch (Exception $e) {
    $_SESSION['abilitato'] = false;
    ob_end_clean(); // Cancella l'output buffering
    header("Location: index.php");
    exit;
}
if($_SESSION['abilitato']) {

    // Contenuto protetto
    ?>
    <body>
    <!-- Element where elFinder will be created (REQUIRED) -->
    <div class="mysez">
        <button id="closeButton">Chiudi</button>
    </div>
    <div id="elfinder"></div>
    <img src="img/studenti.png" alt="studenti" style="width: 100%; height: 40%; position: absolute; z-index: -1;">
    <?php
} else {
    header("Location: index.php");
    exit;
}?>
</body>

<script>
document.getElementById('closeButton').addEventListener('click', function() {
    window.close();
});
</script>

</html>

<?php
ob_end_flush(); // Invia l'output buffering al browser
?>
