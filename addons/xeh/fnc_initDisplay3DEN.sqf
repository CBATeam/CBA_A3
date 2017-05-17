#include "script_component.hpp"

// fix for preInit = 1 functions not being executed when entering 3den from main menu
[] call CBA_fnc_preInit;

// since 1.60, preInit = 1 functions aren't executed when returning from a preview either ...
add3DENEventHandler ["OnMissionPreviewEnd", {[] call CBA_fnc_preInit}];

// switching terrains in 3den will reset missionNamespace
add3DENEventHandler ["OnTerrainNew", {[] call CBA_fnc_preInit}];
add3DENEventHandler ["OnMissionNew", {[] call CBA_fnc_preInit}];
add3DENEventHandler ["OnMissionLoad", {[] call CBA_fnc_preInit}];
