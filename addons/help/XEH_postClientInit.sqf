#include "script_component.hpp"

player createDiarySubject ["CBA_docs", "CBA"]; 
player createDiaryRecord ["CBA_docs", ["Credits - Addons", ([GVAR(credits), "CfgPatches"] call CBA_fnc_hashGet) call FUNC(process)]];
//player createDiaryRecord ["CBA_docs", ["Credits - Vehicles", ([GVAR(credits), "CfgVehicles"] call CBA_fnc_hashGet) call FUNC(process)]];
//player createDiaryRecord ["CBA_docs", ["Credits - Weapons", ([GVAR(credits), "CfgWeapons"] call CBA_fnc_hashGet) call FUNC(process)]];
player createDiaryRecord ["CBA_docs", ["Keys", GVAR(keys)]];
player createDiaryRecord ["CBA_docs", ["Website", "http://dev-heaven.net/projects/cca"]];
player createDiaryRecord ["CBA_docs", ["Wiki", "http://dev-heaven.net/projects/cca"]];
