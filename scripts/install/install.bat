@echo off

REM Imposta il percorso di lavoro
c:
cd \vrscuola

REM Esegui il file vm.bat e attendi la sua terminazione prima di continuare
call vm.bat

REM Esegui il file start_setup.bat
start cmd /c start_setup.bat start cmd /c mode con:cols=40 lines=15

REM Esegui il file start_setup.bat
start cmd /c check_setup.bat start cmd /c mode con:cols=40 lines=15
