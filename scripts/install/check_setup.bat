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
setlocal EnableDelayedExpansion

set /a max_attempts=240
set /a attempt=0
set "url=http://localhost:5555/setup-state"

:loop
set /a attempt+=1
if %attempt% gtr %max_attempts% goto timeout

echo Attempt %attempt%...
for /f "delims=" %%a in ('wget -q -O - %url% 2^>^&1') do set "response=%%a"

echo %response% | findstr /C:"{\"state\":\"ok\"}" >nul
if not errorlevel 1 (
  echo ok
)

ping -n 16 127.0.0.1 >nul
goto loop

:timeout
echo Timeout: no response received after %max_attempts% attempts.
exit /b 1
