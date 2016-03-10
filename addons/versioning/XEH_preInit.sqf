#include "script_component.hpp"
SCRIPT(XEH_preInit);

LOG(MSG_INIT);

ADDON = false;

#include "init_dependencies.sqf"

if (isNil "CBA_display_ingame_warnings") then {
    CBA_display_ingame_warnings = true;
};

GVAR(mismatch) = [];

if (isServer) then {
    ["handleMismatch", {
        params ["_machine", "_addon"];
        CBA_logic globalChat format ["%1 - Not running! (Machine: %2)", _machine, _addon];
    }] call CBA_fnc_addEventHandler;
};

ADDON = true;
