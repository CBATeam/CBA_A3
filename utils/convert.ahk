FileCopy, orig\strings\script_strings.hpp, .
FileCopy, orig\hashes\script_hashes.hpp, .
FileCopy, orig\common\delayless.fsm, .
FileCopy, orig\common\delayless.fsm, extended_eventhandlers_delayless.fsm
FileCopy, orig\main\script_mod.hpp, .
FileCopy, orig\main\script_macros.hpp, .
FileCopy, orig\main\script_macros_common.hpp, .

; order: requiredAddons[] = { "Extended_EventHandlers", "CBA_common", "CBA_arrays", "CBA_events", "CBA_diagnostic", "CBA_hashes", "CBA_network", "CBA_strings", "CBA_vectors", "CBA_versioning" };

wcl(file) {
    lines=0
    Loop, read, %file%
    {
	lines=%A_Index%
    }
    return lines
}

components=common arrays events diagnostic hashes network strings vectors

FileDelete, CfgFunctions.hpp
FileAppend,
(

	class CBA
	{

),CfgFunctions.hpp

Loop, parse, components, %A_Space%
{
    file=orig\%A_LoopField%\CfgFunctions.hpp
    lines := wcl(file)
    Loop, read, %file%
    {
	if ( (A_Index < 10) || (A_Index > (lines-2)) )
	    continue
	re=\\x\\cba\\addons\\(.*)\\fnc_(.*)\.sqf
	rp=x\cba\addons\$1_fnc_$2.sqf
	l:=RegExReplace(A_LoopReadLine, re, rp)
	FileAppend, %l%`r`n, CfgFunctions.hpp
    }
}

FileAppend, }`;`r`n, CfgFunctions.hpp

Loop, orig\extended_eventhandlers\*.sqf
{
    fnc_dst=extended_eventhandlers_%A_LoopFileName%
    FileRead, file, %A_LoopFileFullPath%
    re="extended_eventhandlers\\
    rp="x\cba\addons\extended_eventhandlers_
    file:=RegExReplace(file, re, rp)
    re=#include "script_component.hpp"
    rp=
(
#include "extended_eventhandlers_script_component.hpp"`r
#define PATHTO_SYS(var1,var2,var3) MAINPREFIX\##var1\SUBPREFIX\##var2##_##var3.sqf 
)
    file:=RegExReplace(file, re, rp)
    FileDelete, %fnc_dst%
    FileAppend, %file%, %fnc_dst%
}

FileRead, file, orig\extended_eventhandlers\script_component.hpp
re=#include "x\\cba\\addons\\main\\
rp=#include "
file:=RegExReplace(file, re, rp)
FileDelete, extended_eventhandlers_script_component.hpp
FileAppend, %file%, extended_eventhandlers_script_component.hpp

Loop, parse, components, %A_Space%
{
    component=%A_LoopField%
    Loop, orig\%component%\*.sqf
    {
	fnc_dst=%component%_%A_LoopFileName%
	FileRead, file, %A_LoopFileFullPath%
	re=#include "script_component.hpp"
	rp=
(
#include "%component%_script_component.hpp"`r
#define PATHTO_SYS(var1,var2,var3) MAINPREFIX\##var1\SUBPREFIX\##var2##_##var3.sqf 
)
	file:=RegExReplace(file, re, rp)
	if ( fnc_dst = "common_XEH_preInit.sqf" ) {
	    re=GVAR\(delayless\).*
	    rp=GVAR(delayless) = "x\cba\addons\delayless.fsm"`;
	    file:=RegExReplace(file, re, rp)
	}
	FileDelete, %fnc_dst%
	FileAppend, %file%, %fnc_dst%
    }     
    FileRead, file, orig\%component%\script_component.hpp
    re=#include "\\x\\cba\\addons\\main\\
    rp=#include "
    file:=RegExReplace(file, re, rp)
    FileDelete, %component%_script_component.hpp
    FileAppend, %file%, %component%_script_component.hpp
}

FileDelete, CBA_init.hpp
FileAppend,
(
call compile preProcessFileLineNumbers "x\cba\addons\extended_eventhandlers_InitXEH.sqf";
call compile preProcessFileLineNumbers "x\cba\addons\events_XEH_preInit.sqf";
if (!isDedicated) then {call compile preProcessFileLineNumbers "x\cba\addons\events_XEH_preClientInit.sqf"};
if (!isDedicated) then {call compile preProcessFileLineNumbers "x\cba\addons\common_XEH_preClientInit.sqf"};
call compile preProcessFileLineNumbers "x\cba\addons\common_XEH_preInit.sqf";
call compile preProcessFileLineNumbers "x\cba\addons\common_XEH_postInit.sqf";
call compile preProcessFileLineNumbers "x\cba\addons\diagnostic_XEH_preInit.sqf";
call compile preProcessFileLineNumbers "x\cba\addons\network_XEH_preInit.sqf";
if (!isDedicated) then {call compile preProcessFileLineNumbers "x\cba\addons\network_XEH_postClientInit.sqf"};
call compile preProcessFileLineNumbers "x\cba\addons\vectors_XEH_preInit.sqf";
), CBA_init.hpp
