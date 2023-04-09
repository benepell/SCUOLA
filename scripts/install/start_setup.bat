@echo off

set url=http://localhost:5555/api/setup
set timeout=600

setlocal enableDelayedExpansion

REM Imposta l'orario di fine timeout
set "EndTime="
for /f "tokens=1-4 delims=:.," %%a in ("%TIME%") do (
    set /a "EndTime=(((%%a*60)+1%%b %% 100)*60)+1%%c %% 100+1%%d %% 10000"
    set /a "EndTime+=timeout"
)

:loop
set response=
echo Contatto il server %url%...
powershell -Command "& { try { $response = Invoke-WebRequest -Uri '%url%' -UseBasicParsing -TimeoutSec 5; exit $response.StatusCode } catch { exit 0 } }"
if %errorlevel% EQU 200 (
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
