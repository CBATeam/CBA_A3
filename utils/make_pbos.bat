@echo off

set ADDONS=P:\x\cba\addons

set TOOL=ruby "C:\_Home\sb\projects\dh-arma-tools\lib\main.rb"
set OPTS=-b

set KEY="P:\x\cba\utils\CBA_v0-1-3.biprivatekey"
set SIGN="C:\Program Files (x86)\Bohemia Interactive\Tools\BinPBO Personal Edition\DSSignFile\DSSignFile.exe"

REM set OPTS=-m

REM set TOOL=makepbo
REM set OPTS=-LN

P:

cd "C:\_Home\sb\projects\dh-arma-tools\lib"

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

cd %ADDONS%
rename xxx_extended_eventhandlers.pbo extended_eventhandlers.pbo

%SIGN% %KEY% "%ADDONS%\extended_eventhandlers.pbo"
%SIGN% %KEY% "%ADDONS%\cba_main.pbo"
%SIGN% %KEY% "%ADDONS%\cba_arrays.pbo"
%SIGN% %KEY% "%ADDONS%\cba_common.pbo"
%SIGN% %KEY% "%ADDONS%\cba_diagnostic.pbo"
%SIGN% %KEY% "%ADDONS%\cba_events.pbo"
%SIGN% %KEY% "%ADDONS%\cba_hashes.pbo"
%SIGN% %KEY% "%ADDONS%\cba_network.pbo"
%SIGN% %KEY% "%ADDONS%\cba_strings.pbo"

pause
