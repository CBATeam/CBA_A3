@echo off

set ADDONS=P:\x\cba\addons

set TOOL="C:\tools\six-arma-tools.exe"
set OPTS=-b

set KEY="P:\x\cba\utils\CBA_v0-2-0.biprivatekey"
set SIGN="C:\tools\dsutils\DSSignFile.exe"

REM set OPTS=-m

REM set TOOL=makepbo
REM set OPTS=-LN

P:

cd "C:\tools"

%TOOL% %OPTS% "%ADDONS%\extended_eventhandlers"
%TOOL% %OPTS% "%ADDONS%\main"
%TOOL% %OPTS% "%ADDONS%\arrays"
%TOOL% %OPTS% "%ADDONS%\common"
%TOOL% %OPTS% "%ADDONS%\diagnostic"
%TOOL% %OPTS% "%ADDONS%\events"
%TOOL% %OPTS% "%ADDONS%\hashes"
%TOOL% %OPTS% "%ADDONS%\network"
%TOOL% %OPTS% "%ADDONS%\strings"
%TOOL% %OPTS% "%ADDONS%\vectors"

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
%SIGN% %KEY% "%ADDONS%\cba_vectors.pbo"

pause
