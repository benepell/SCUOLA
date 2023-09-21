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

REM Imposta il percorso di lavoro
c:
cd \vrscuola

REM Esegui il file vm.bat e attendi la sua terminazione prima di continuare
call vm.bat

REM Esegui il file start_setup.bat
start cmd /c start_setup.bat start cmd /c mode con:cols=40 lines=15

REM Esegui il file start_setup.bat
start cmd /c check_setup.bat start cmd /c mode con:cols=40 lines=15
