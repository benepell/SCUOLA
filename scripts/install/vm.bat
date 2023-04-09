@echo off
setlocal

set "current_time=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "base=d:\install"
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
    echo %current_time% - Oracle VM VirtualBox non è installato sul sistema. >> %log_file%
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

set "vm_path=%~dp0SOFTWARE\scuola.ova"
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

rem abilita nat nella eth0
VBoxManage modifyvm "scuola" --nic1 nat

rem abilita port-forwarding tcp/5555
VBoxManage modifyvm "scuola" --natpf1 "tcp-port5555,tcp,,5555,,5555"

rem aggiungi al firewall di windows tcp/5555
netsh advfirewall firewall add rule name="scuola" dir=in action=allow protocol=TCP localport=5555

VBoxManage startvm "scuola" --type headless
if %errorLevel% neq 0 (
    echo %current_time% - Avvio della macchina virtuale... >> %log_file%
    echo %current_time% - Errore durante l'avvio della macchina virtuale! >> %log_file%
    goto errore
) else (
    echo %current_time% - Avvio della macchina virtuale... >> %log_file%
    echo %current_time% - Avvio della macchina virtuale completato con successo. >> %log_file%
)

echo %current_time% - Avvio della macchina virtuale... >> %log_file%
echo %current_time% - Installazione completata con successo! >> %log_file%
exit /B 0

:errore
echo %current_time% - Avvio della macchina virtuale... >> %log_file%
echo %current_time% - Installazione completata con errori. >> %
