//#define DEBUG_MODE_FULL
#include "script_component.hpp"
#include "script_dialog_defines.hpp"

disableSerialization;
params ["_ctrl"];
private ["_idc", "_cfg"];

//NOTE: preinit hasn't defined fnc variables yet on main menu, do it manually for now
if (isNil "CBA_fnc_defaultParam") then { CBA_fnc_defaultParam = uiNamespace getVariable "CBA_fnc_defaultParam" };

_idc = ((str _ctrl) splitString "#") select 1;

_cfg = configFile>>"CBA_MouseTrapEvent">>("IDC_" + _idc);

if (isClass _cfg) then {
    for "_i" from 0 to (count _cfg - 1) do {
        _this call compile preprocessFileLineNumbers getText (_cfg select _i);
    }
};

