#include "script_component.hpp"

if (!hasInterface) exitWith {};

// init pip camera
["featureCamera", {
    params ["_unit", "_camera"];
    [_unit, _camera isEqualTo ""] call CBA_fnc_restartCamera;
}, true] call CBA_fnc_addPlayerEventHandler;

// @todo move to ACE
//["ace_arsenal_displayClosed", {
//    [CBA_fnc_restartCamera, [[] call CBA_fnc_currentUnit, true]] call CBA_fnc_execNextFrame;
//}] call CBA_fnc_addEventHandler;
