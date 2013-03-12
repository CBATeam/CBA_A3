#define DEBUG_MODE_FULL
#include "script_component.hpp"


player createDiarySubject ["CBA_docs", "CBA"];
//player createDiaryRecord ["CBA_docs", [(localize "STR_DN_CBA_WEBSITE_WIKI"), "http://dev-heaven.net/projects/cca"]];
player createDiaryRecord ["CBA_docs", [(localize "STR_DN_CBA_CREDITS_ADDONS"), ([GVAR(credits), "CfgPatches"] call CBA_fnc_hashGet) call FUNC(process)]];
player createDiaryRecord ["CBA_docs", ["Docs", GVAR(docs)]];
player createDiaryRecord ["CBA_docs", [(localize "STR_DN_CBA_HELP_KEYS"), GVAR(keys)]];
//player createDiaryRecord ["CBA_docs", [(localize "STR_DN_CBA_CREDITS"), GVAR(credits_cba)]];
//player createDiaryRecord ["CBA_docs", ["Credits - Vehicles", ([GVAR(credits), "CfgVehicles"] call CBA_fnc_hashGet) call FUNC(process)]];
//player createDiaryRecord ["CBA_docs", ["Credits - Weapons", ([GVAR(credits), "CfgWeapons"] call CBA_fnc_hashGet) call FUNC(process)]];

//player createDiaryRecord ["CBA_docs", [(localize "STR_DN_CBA_WEBSITE"), "http://dev-heaven.net/projects/cca"]];
