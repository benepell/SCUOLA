<?php
session_start();

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
    'urlResourceOwnerDetails' => URL_RESOURCE_OWNER_DETAILS,
    'scopes'                  => 'openid'
]);

try{

    $accessToken = $provider->getAccessToken('authorization_code', [
        'code' => $_GET['code']
    ]);

     // Se l'access token è valido, ottieni i dettagli dell'utente
     if ($accessToken) {
        $isAdmin = false;

        // Supponiamo che $accessToken sia il tuo token
        $jwt = $accessToken;

        // Divide il token in parti
        $jwtParts = explode('.', $jwt);
        if (count($jwtParts) !== 3) {
            throw new Exception('Token JWT non valido.');
        }

        // Decodifica il payload
        $payload = base64_decode(str_replace(['-', '_'], ['+', '/'], $jwtParts[1]));

        // Converti la stringa JSON in un array PHP
        $payloadArray = json_decode($payload, true);

        // Controlla se il payload ha la struttura attesa e ottiene i ruoli
        if (isset($payloadArray['realm_access']) && isset($payloadArray['realm_access']['roles'])) {
            $roles = $payloadArray['realm_access']['roles'];

            // Controlla se 'admins' è uno dei ruoli
            if (in_array('admins', $roles)) {
                $isAdmin = true;
            }

        } else {
            throw new Exception('Ruoli non trovati nel token.');
        }

        if($isAdmin){
            $_SESSION['abilitato'] = true;
        }

    } else {
        throw new Exception("Token non valido.");
    }
}  catch (Exception $e) {
    $_SESSION['abilitato'] = false;
    ob_end_clean(); // Cancella l'output buffering
    header("Location: index.php");
    exit;
}

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