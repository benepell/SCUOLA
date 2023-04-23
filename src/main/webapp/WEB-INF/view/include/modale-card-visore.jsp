<div id="demo-modal" class="modal">
  <div class="modal-content">
  <div class="cerchio" id="cerchio">&nbsp;</div>
    <span class="close-btn">&times;</span>
    <h2>Seleziona un argomento</h2>
    <div class="iframe-container">
          <iframe srcdoc='
                <!DOCTYPE html>
                <html>
                  <head>
                    <style>
                      * {
                        margin: 0;
                        padding: 0;
                      }

                      body {
                        background-color: #e4eeda;
                        font-family: sans-serif;
                      }

                      ul {
                        list-style: none;
                        padding: 20px;
                        max-height: 450px;
                        overflow: auto;
                      }

                      li {
                        margin-bottom: 10px;
                      }

                      a {
                        color: #6D4C41;
                        text-decoration: none;
                        font-size: larger;
                        line-height: 1.4rem;
                      }

                      a:hover {
                        text-decoration: underline;
                      }
                    </style>
                  </head>
                  <body>
                          <ul>
                             <li><a  onclick="return false;" href="#">Argomento demo 1</a></li>
                             <li><a  onclick="return false;" href="#">Argomento demo 2</a></li>
                             <li><a   onclick="return false;" href="#">Argomento demo 3</a></li>
                             <li><a href="#">Argomento demo 4</a></li>
                             <li><a href="#">Argomento demo 5</a></li>
                             <li><a href="#">Argomento demo 6</a></li>
                             <li><a href="#">Argomento demo 7</a></li>
                             <li><a href="#">Argomento demo 8</a></li>
                             <li><a href="#">Argomento demo 9</a></li>
                           </ul>
                  </body>
                </html>'></iframe>
        </div>
  </div>
</div>

