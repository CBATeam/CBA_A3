@echo off

set ADDONS=P:\x\cba\addons

set TOOL=ruby "P:\x\dh-arma-tools\lib\main.rb"
set OPTS=-b
REM set OPTS=-m

REM set TOOL=makepbo
REM set OPTS=-LN

cd "G:\Games\ArmA 2\x\dh-arma-tools\lib"

%TOOL% %OPTS% "%ADDONS%\extended_eventhandlers"
%TOOL% %OPTS% "%ADDONS%\main"
%TOOL% %OPTS% "%ADDONS%\arrays"
%TOOL% %OPTS% "%ADDONS%\common"
%TOOL% %OPTS% "%ADDONS%\diagnostic"
%TOOL% %OPTS% "%ADDONS%\events"
%TOOL% %OPTS% "%ADDONS%\hashes"
%TOOL% %OPTS% "%ADDONS%\network"
%TOOL% %OPTS% "%ADDONS%\strings"

echo.

P:
cd %ADDONS%
rename xxx_extended_eventhandlers.pbo extended_eventhandlers.pbo

pause