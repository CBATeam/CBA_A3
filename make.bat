@echo off
setlocal enabledelayedexpansion

if not exist "@CBA_A3" mkdir "@CBA_A3"
if not exist "@CBA_A3\addons" mkdir "@CBA_A3\addons"
if not exist "@CBA_A3\optionals" mkdir "@CBA_A3\optionals"

if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set armake=tools\armake_w64.exe) else (set armake=tools\armake_w32.exe)

for /d %%f in (addons\*) do (
    set folder=%%f
    set name=!folder:addons\=!
    echo   PBO  @CBA_A3\addons\cba_!name!.pbo
    !armake! build -i include -w unquoted-string -w redefinition-wo-undef -f !folder! @CBA_A3\addons\cba_!name!.pbo
)

for /d %%f in (optionals\*) do (
    set folder=%%f
    set name=!folder:optionals\=!
    echo   PBO  @CBA_A3\optionals\cba_!name!.pbo
    !armake! build -i include -w unquoted-string -w redefinition-wo-undef -f !folder! @CBA_A3\optionals\cba_!name!.pbo
)

pause
