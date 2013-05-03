#define DEBUG_MODE_FULL
#include "script_component.hpp"

GVAR(CREDITS_Info) = [GVAR(credits), "CfgPatches"] call (uiNamespace getVariable "CBA_fnc_hashGet");
GVAR(CREDITS_CfgPatches) = (GVAR(CREDITS_Info)) call FUNC(process);
TRACE_2("",GVAR(CREDITS_Info), GVAR(CREDITS_CfgPatches));

#ifdef DEBUG_MODE_FULL
	// Troubleshooting an A3 Funcitons Compliation for missionNamespace.
	if (isNil "CBA_fnc_hashGet") then { diag_log "CBA_fnc_hashGet is nil!!";};
	if (isNil QGVAR(CREDITS_CfgPatches)) then { diag_log "CREDITS_CfgPatches is nil! CBA_fnc_hashGet must have failed"; TRACE_1("",CBA_fnc_hashGet)};
#endif

player createDiarySubject ["CBA_docs", "CBA"];
//player createDiaryRecord ["CBA_docs", [(localize "STR_DN_CBA_WEBSITE_WIKI"), "http://dev-heaven.net/projects/cca"]];
if (!isNil QGVAR(CREDITS_CfgPatches)) then { player createDiaryRecord ["CBA_docs", [(localize "STR_DN_CBA_CREDITS_ADDONS"), GVAR(CREDITS_CfgPatches)]];};
if (!isNil QGVAR(docs)) then { player createDiaryRecord ["CBA_docs", ["Docs", GVAR(docs)]];};
if (!isNil QGVAR(keys)) then { player createDiaryRecord ["CBA_docs", [(localize "STR_DN_CBA_HELP_KEYS"), GVAR(keys)]];};
//player createDiaryRecord ["CBA_docs", [(localize "STR_DN_CBA_CREDITS"), GVAR(credits_cba)]];
//player createDiaryRecord ["CBA_docs", ["Credits - Vehicles", ([GVAR(credits), "CfgVehicles"] call (uiNamespace getVariable "CBA_fnc_hashGet")) call FUNC(process)]];
//player createDiaryRecord ["CBA_docs", ["Credits - Weapons", ([GVAR(credits), "CfgWeapons"] call (uiNamespace getVariable "CBA_fnc_hashGet")) call FUNC(process)]];

//player createDiaryRecord ["CBA_docs", [(localize "STR_DN_CBA_WEBSITE"), "http://dev-heaven.net/projects/cca"]];


// [cba_help_credits, "CfgPatches"] call (uiNamespace getVariable "CBA_fnc_hashGet")