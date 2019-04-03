#include "script_component.hpp"

if (getNumber (configFile >> "CBA_useScriptedOpticsFramework") != 1) exitWith {};
if (!hasInterface) exitWith {};

// Init pip camera.
["featureCamera", {
    params ["_unit", "_camera"];
    [_unit, _camera isEqualTo ""] call FUNC(restartCamera);
}, true] call CBA_fnc_addPlayerEventHandler;
