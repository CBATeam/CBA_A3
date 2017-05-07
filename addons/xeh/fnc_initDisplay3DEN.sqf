#include "script_component.hpp"

// fix for preInit = 1 functions not being executed when entering 3den from main menu
[] call CBA_fnc_preInit;

// since 1.60, preInit = 1 functions aren't executed when returning from a preview either ...
add3DENEventHandler ["OnMissionPreviewEnd", {[] call CBA_fnc_preInit}];

// switching terrains in 3den will reset missionNamespace
add3DENEventHandler ["OnTerrainNew", {[] call CBA_fnc_preInit}];

private _fnc_preInitMissionConfig = {
    {
        if (_x select 0 == "" && {_x select 1 == "preInit"}) then {
            [] call (_x select 2);
        };
    } forEach (missionConfigFile call CBA_fnc_compileEventHandlers);
};

add3DENEventHandler ["OnMissionNew", _fnc_preInitMissionConfig];
add3DENEventHandler ["OnMissionLoad", _fnc_preInitMissionConfig];
