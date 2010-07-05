@echo off

set ADDONS=P:\x\cba\addons

set TOOL="C:\tools\six-arma-tools.exe"
set OPTS=-b

set KEY="P:\x\cba\utils\CBA_v0-5-0.biprivatekey"
set SIGN="C:\tools\dsutils\DSSignFile.exe"

REM set OPTS=-m

REM set TOOL=makepbo
REM set OPTS=-LN

P:

cd "C:\tools"

%TOOL% %OPTS% "%ADDONS%\ai"
%TOOL% %OPTS% "%ADDONS%\extended_eventhandlers"
%TOOL% %OPTS% "%ADDONS%\main"
%TOOL% %OPTS% "%ADDONS%\arrays"
%TOOL% %OPTS% "%ADDONS%\help"
%TOOL% %OPTS% "%ADDONS%\common"
%TOOL% %OPTS% "%ADDONS%\diagnostic"
%TOOL% %OPTS% "%ADDONS%\events"
%TOOL% %OPTS% "%ADDONS%\hashes"
%TOOL% %OPTS% "%ADDONS%\network"
%TOOL% %OPTS% "%ADDONS%\strings"
%TOOL% -m "%ADDONS%\ui"
%TOOL% %OPTS% "%ADDONS%\vectors"
%TOOL% %OPTS% "%ADDONS%\versioning"

echo.

cd %ADDONS%
rem rename xxx_extended_eventhandlers.pbo extended_eventhandlers.pbo

%SIGN% %KEY% "%ADDONS%\cba_extended_eventhandlers.pbo"
%SIGN% %KEY% "%ADDONS%\cba_ai.pbo"
%SIGN% %KEY% "%ADDONS%\cba_main.pbo"
%SIGN% %KEY% "%ADDONS%\cba_arrays.pbo"
%SIGN% %KEY% "%ADDONS%\cba_common.pbo"
%SIGN% %KEY% "%ADDONS%\cba_diagnostic.pbo"
%SIGN% %KEY% "%ADDONS%\cba_events.pbo"
%SIGN% %KEY% "%ADDONS%\cba_hashes.pbo"
%SIGN% %KEY% "%ADDONS%\cba_help.pbo"
%SIGN% %KEY% "%ADDONS%\cba_network.pbo"
%SIGN% %KEY% "%ADDONS%\cba_strings.pbo"
%SIGN% %KEY% "%ADDONS%\cba_ui.pbo"
%SIGN% %KEY% "%ADDONS%\cba_vectors.pbo"
%SIGN% %KEY% "%ADDONS%\cba_versioning.pbo"

pause
