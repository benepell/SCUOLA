@echo off
setlocal

set "current_time=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "base=C:\vrscuola"
set "log_file=%base%\LOG\vm_%current_time%.log"

net session >nul 2>&1
if %errorLevel% == 0 (
    goto start
) else (
    powershell -Command "Start-Process '%~0' -Verb runAs"
    exit /B
)

:start

set "current_time=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"

echo %current_time% - Controlla requisiti minimi. >> %log_file%
echo Verifica della porta 80... >> %log_file%
netstat -ano | find /I ":80 " | findstr LISTENING > nul
if %errorlevel% equ 0 (
    echo La porta 80 non e' libera. >> %log_file%
    echo La porta 80 non e' libera.
    pause
    exit /B 1
) 

echo Verifica della porta 5555... >> %log_file%
netstat -ano | find /I ":5555 " | findstr LISTENING > nul
if %errorlevel% equ 0 (
    echo La porta 5555 non e' libera. >> %log_file%
    echo La porta 5555 non e' libera. 
    pause
    exit /B 1
) 

for /f "tokens=2 delims=:" %%a in ('systeminfo ^| findstr /C:"Memoria fisica totale:"') do set "RAM=%%a"
set "RAM=%RAM:~1%"
set "RAM=%RAM: =%"
set "RAM=%RAM:.=%"
set "RAM=%RAM:MB=%"
echo RAM totale: %RAM% >> %log_file%

if %RAM% lss 8192 (
    echo La RAM totale e' inferiore ai 8GB. >> %log_file%
    echo La RAM totale e' inferiore ai 8GB. 
    pause
    exit /B 1
)

rem Recupera il numero di core della CPU
for /f "tokens=2 delims==" %%a in ('wmic cpu get NumberOfCores /VALUE') do set numberOfCores=%%a
set "numberOfCores=%numberOfCores:~0,-1%"
echo Numero di core: %numberOfCores% >> %log_file%

if %numberOfCores% lss 2 (
    echo Il numero di core e' inferiore a 2. >> %log_file%
    echo Il numero di core e' inferiore a 2. 
    pause
    exit /B 1
)


rem Recupera il numero di core della CPU
for /f "tokens=2 delims==" %%a in ('wmic cpu get NumberOfCores /VALUE') do set numberOfCores=%%a
set "numberOfCores=%numberOfCores:~0,-1%"
echo Numero di core: %numberOfCores% 

if %numberOfCores% lss 2 (
    echo Il numero di core e' inferiore a 2.
    echo Il numero di core e' inferiore a 2. >> %log_file%
    exit /B 1
    pause
)


echo %current_time% - Avvio installazione. >> %log_file%

echo %current_time% - Verifica presenza di VirtualBox... >> %log_file%
REM Ottieni l'IdentifyingNumber dell'installazione di Oracle VM VirtualBox
for /f "tokens=2 delims==" %%I in ('wmic product where "Caption like '%%Oracle VM VirtualBox%%'" get IdentifyingNumber /value') do set ID=%%I

REM Rimuovi l'installazione utilizzando l'IdentifyingNumber
if defined ID (
    set "current_time=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
    echo %current_time% - Disinstallazione di Oracle VM VirtualBox in corso... >> %log_file%
    msiexec /x %ID% /quiet

    set "current_time=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
    echo %current_time% - Disinstallazione completata. >> %log_file%
) else (
    set "current_time=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
    echo %current_time% - Oracle VM VirtualBox non e' installato sul sistema. >> %log_file%
)

set "installer_path=%~dp0SOFTWARE\VirtualBox-7.0.6-155176-Win.exe"

if not exist "%installer_path%" (
    set "current_time=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
    echo %current_time% - File di installazione non trovato! >> %log_file%
    goto errore
) else (
    set "current_time=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
    echo %current_time% - Avvio installazione VirtualBox... >> %log_file%
    start /wait "" "%installer_path%" -s
    if %errorLevel% neq 0 (
        set "current_time=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
        echo %current_time% - Errore durante l'installazione di VirtualBox! >> %log_file%
        goto errore
    ) else (
        set "current_time=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
        echo %current_time% - Installazione VirtualBox completata con successo. >> %log_file%
        
    )
)

setlocal enabledelayedexpansion

set "VBoxManagePath=C:\Program Files\Oracle\VirtualBox"

set "Path=%VBoxManagePath%;%Path%"

setx Path "%Path%" 

if %errorLevel% neq 0 (
    set "current_time=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
    echo %current_time% - Errore durante l'aggiornamento del percorso! >> %log_file%
    goto errore
) else (
    set "current_time=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
    echo %current_time% - Aggiornamento del percorso riuscito. >> %log_file%
)

endlocal

set "vm_path=%~dp0VM\scuola.ova"
set "current_time=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
echo %current_time% - Importazione macchina virtuale in corso... >> %log_file%
VBoxManage import "%vm_path%" --vsys 0 --vmname "scuola" --eula accept
if %errorLevel% neq 0 (
    set "current_time=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
    echo %current_time% - Errore durante l'importazione della macchina virtuale! >> %log_file%
    goto errore
) else (
    set "current_time=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
    echo %current_time% - Importazione della macchina virtuale completata con successo. >> %log_file%
)
set "current_time=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
echo %current_time% - Avvio della macchina virtuale... >> %log_file%

echo ottimizzazione macchina virtuale in corso... >> %log_file%

rem Recupera il valore della memoria RAM totale
for /f "tokens=2 delims=:" %%a in ('systeminfo ^| findstr /C:"Memoria fisica totale:"') do set "RAM=%%a"
set "RAM=%RAM:~1%"
set "RAM=%RAM: =%"
set "RAM=%RAM:.=%"
set "RAM=%RAM:MB=%"
echo RAM totale: %RAM% >> %log_file%

rem Recupera il numero di core della CPU
for /f "tokens=2 delims==" %%a in ('wmic cpu get NumberOfCores /VALUE') do set numberOfCores=%%a
set "numberOfCores=%numberOfCores:~0,-1%"
echo Numero di core: %numberOfCores% >> %log_file%

rem Calcola il 60% dei valori della RAM e dei core
set /a VBOX_MEMORY=%RAM%*60/100
set /a VBOX_CPU=%numberOfCores%*60/100
echo Memory 60%: %VBOX_MEMORY% >> %log_file%
echo CPU 60%: %VBOX_CPU% >> %log_file%

rem Modifica la configurazione della VM con i nuovi valori
VBoxManage modifyvm "scuola" --memory %VBOX_MEMORY%
VBoxManage modifyvm "scuola" --cpus %VBOX_CPU%

rem abilita nat nella eth0
VBoxManage modifyvm "scuola" --nic1 nat

rem abilita port-forwarding tcp/5555
VBoxManage modifyvm "scuola" --natpf1 "tcp-port5555,tcp,,5555,,5555"

rem abilita port-forwarding tcp/80
VBoxManage modifyvm "scuola" --natpf1 "tcp-port80,tcp,,80,,80"

rem abilita port-forwarding tcp/22
VBoxManage modifyvm "scuola" --natpf1 "tcp-port22,tcp,,22,,22"

rem rimuovi regola firewall di windows tcp/80
netsh advfirewall firewall delete rule name="vrscuola-cert"

rem aggiungi al firewall di windows tcp/80
netsh advfirewall firewall add rule name="vrscuola-cert" dir=in action=allow protocol=TCP localport=80

set vm_name=scuola
start "" /B VBoxManage startvm %vm_name% --type headless

if %errorLevel% neq 0 (
    echo %current_time% - Avvio della macchina virtuale... >> %log_file%
    echo %current_time% - Errore durante l'avvio della macchina virtuale! >> %log_file%
    goto errore
) else (
    echo %current_time% - Avvio della macchina virtuale... >> %log_file%
    echo %current_time% - Avvio della macchina virtuale completato con successo. >> %log_file%

)

:errore

echo %current_time% - Avvio della macchina virtuale... >> %log_file%
echo %current_time% - Installazione completata con errori. >> %log_file%
