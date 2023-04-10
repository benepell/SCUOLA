@echo off
setlocal

set "current_time=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "base=C:\vrscuola"
set "log_file=%base%\LOG\vm_export_%current_time%.log"

REM Impostare il percorso e il nome del file di esportazione
set EXPORTFILE=C:\vrscuola\VM\scuola.ova

REM Impostare il nome della macchina virtuale da esportare
set VMNAME=scuola

REM Eseguire l'esportazione della macchina virtuale con l'opzione -eula accept
VBoxManage export %VMNAME% -o %EXPORTFILE%  --vsys 0 --eula accept

REM Controllare se il file di esportazione esiste
if exist %EXPORTFILE% (
    set "log_file=%base%\LOG\vm_export_%current_time%.log"
    echo %current_time% - Esportazione completata con successo. >> %log_file%
) else (
    set "log_file=%base%\LOG\vm_export_%current_time%.log"
    echo %current_time% - Si è verificato un errore durante l'esportazione. >> %log_file%
)

REM Controllare la validità del file di esportazione
VBoxManage import --dry-run %EXPORTFILE%

REM Controllare il codice di uscita del comando precedente
if %errorlevel% equ 0 (
    set "log_file=%base%\LOG\vm_export_%current_time%.log"
    echo %current_time% -  Il file di esportazione è valido e corretto. >> %log_file%
) else (
    set "log_file=%base%\LOG\vm_export_%current_time%.log"
    echo %current_time% -  Si è verificato un errore durante il controllo del file di esportazione. >> %log_file%
)