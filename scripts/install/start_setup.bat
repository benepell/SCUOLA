::------------------------------------------------------------------------------
:: Copyright (c) 2023, Benedetto Pellerito
:: Email: benedettopellerito@gmail.com
:: GitHub: https://github.com/benepell
::
:: Licensed under the Apache License, Version 2.0 (the "License");
:: you may not use this file except in compliance with the License.
:: You may obtain a copy of the License at
::
::      http://www.apache.org/licenses/LICENSE-2.0
::
:: Unless required by applicable law or agreed to in writing, software
:: distributed under the License is distributed on an "AS IS" BASIS,
:: WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
:: See the License for the specific language governing permissions and
:: limitations under the License.
::------------------------------------------------------------------------------

@echo off

set url=http://localhost:5555/setup
set timeout=1200

setlocal enableDelayedExpansion

REM Imposta l'orario di fine timeout
set "EndTime="
for /f "tokens=1-4 delims=:.," %%a in ("%TIME%") do (
    set /a "EndTime=(((%%a*60)+1%%b %% 100)*60)+1%%c %% 100+1%%d %% 10000"
    set /a "EndTime+=timeout"
)

:loop
echo Contatto il server %url%...
wget -q --spider %url%
if %errorlevel% EQU 0 (
    echo La pagina è stata trovata, aprendo il browser...
    start "" %url%
) else (
    for /f "tokens=1-4 delims=:.," %%a in ("%TIME%") do (
        set /a "CurrentTime=(((%%a*60)+1%%b %% 100)*60)+1%%c %% 100+1%%d %% 10000"
    )
    if !CurrentTime! LSS !EndTime! (
        echo Impossibile contattare la pagina, riprovo tra 15 secondi...
        ping 127.0.0.1 -n 16 > nul
        goto loop
    ) else (
        echo Il timeout di %timeout% secondi è scaduto, esco...
    )
)

endlocal
