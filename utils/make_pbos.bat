@echo off

set ADDONS=P:\x\cba\addons
set OPTIONAL=P:\x\cba\optional

set TOOL="C:\tools\six-arma-tools.exe"
set OPTS=-b

set KEY="P:\x\cba\utils\CBA_v0-7-6.biprivatekey"
set SIGN="C:\tools\dsutils\DSSignFile.exe"

REM set OPTS=-m

REM set TOOL=makepbo
REM set OPTS=-LN

P:

cd "C:\tools"

REM %TOOL% %OPTS% "%ADDONS%\ai"
REM %TOOL% %OPTS% "%ADDONS%\extended_eventhandlers"
REM %TOOL% %OPTS% "%ADDONS%\main"
REM %TOOL% %OPTS% "%ADDONS%\arrays"
REM %TOOL% %OPTS% "%ADDONS%\help"
REM %TOOL% %OPTS% "%ADDONS%\common"
REM %TOOL% %OPTS% "%ADDONS%\diagnostic"
REM %TOOL% %OPTS% "%ADDONS%\events"
REM %TOOL% %OPTS% "%ADDONS%\hashes"
REM %TOOL% %OPTS% "%ADDONS%\network"
REM %TOOL% %OPTS% "%ADDONS%\strings"
REM %TOOL% -m "%ADDONS%\ui"
REM %TOOL% %OPTS% "%ADDONS%\ui_helper"
REM %TOOL% %OPTS% "%ADDONS%\vectors"
REM %TOOL% %OPTS% "%ADDONS%\versioning"
REM %TOOL% %OPTS% "%ADDONS%\xeh"

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
%SIGN% %KEY% "%ADDONS%\cba_ui_helper.pbo"
%SIGN% %KEY% "%ADDONS%\cba_vectors.pbo"
%SIGN% %KEY% "%ADDONS%\cba_versioning.pbo"
%SIGN% %KEY% "%ADDONS%\cba_xeh.pbo"

for %%F in (%OPTIONAL%\*.pbo) do (
	%SIGN% %KEY% %%F
)

pause
