#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeBISPlayerEventHandler

Description:
    Remove event handlers added via CBA_fnc_addBISPlayerEventHandler.

Parameters:
    _key - Unique identifier for the event. <STRING>

Returns:
    Event was removed <BOOLEAN>

Examples:
    (begin example)
        ["TAG_MyFiredNearEvent"] call CBA_fnc_removeBISPlayerEventHandler
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */
SCRIPT(removeBISPlayerEventHandler);

if (canSuspend) exitWith {
    [CBA_fnc_removeBISPlayerEventHandler, _this] call CBA_fnc_directCall;
};

params [
    ["_key", "", [""]]
];

if (isNil QGVAR(playerEventsHash)) exitWith {false};

_key = format [QGVAR(playerEvents_%1), toLowerANSI _key];
if !(_key in GVAR(playerEventsHash)) exitWith {false};

(GVAR(playerEventsHash) deleteAt _key) params ["_type", "", "_ignoreVirtual"];

private _player = call CBA_fnc_currentUnit;
private _ehIdx = _player getVariable [_key, -1]; // don't touch any events if it wasn't one we added
if (_ehIdx != -1) then {
    _player removeEventHandler [_type, _ehIdx];
    _player setVariable [_key, nil];
};

true // return
