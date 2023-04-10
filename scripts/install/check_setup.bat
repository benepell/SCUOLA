@echo off
setlocal EnableDelayedExpansion

set /a max_attempts=240
set /a attempt=0
set "url=http://localhost:5555/api/setup-state"

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
