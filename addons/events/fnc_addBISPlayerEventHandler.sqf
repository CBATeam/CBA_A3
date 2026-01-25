#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addBISPlayerEventHandler

Description:
    Adds an engine event handler just to the controlled entity.

Parameters:
    _key           - Unique identifier for the event. <STRING>
    _eventType     - Type of event to add. Can be any event supported by addEventHandler. <STRING>
    _eventCode     - Code to run when event is raised. <CODE>
    _ignoreVirtual - Ignore virtual units (spectators, virtual zeus, UAV RC) [optional] (default: true) <BOOLEAN>

Returns:
    Event was added <BOOLEAN>

Examples:
    (begin example)
        ["TAG_MyFiredNearEvent", "FiredNear", {systemChat str _this}] call CBA_fnc_addBISPlayerEventHandler
    (end)

Author:
    PabstMirror
---------------------------------------------------------------------------- */
SCRIPT(addBISPlayerEventHandler);

if (canSuspend) exitWith {
    [CBA_fnc_addBISPlayerEventHandler, _this] call CBA_fnc_directCall;
};

params [
    ["_key", "", [""]],
    ["_type", "", [""]],
    ["_code", {}, [{}]],
    ["_ignoreVirtual", true, [true]]
];

if (isNil QGVAR(playerEventsHash)) then { // first-run init
    GVAR(playerEventsHash) = createHashMap;
    ["unit", {
        params ["_newPlayer", "_oldPlayer"];

        // uav check only applies to direct controlling UAVs from zeus, no effect on normal UAV operation
        private _isVirtual = (unitIsUAV _newPlayer) || {getNumber (configOf _newPlayer >> "isPlayableLogic") == 1};

        TRACE_4("",_newPlayer,_oldPlayer,_isVirtual,count GVAR(playerEventsHash));
        {
            _y params ["_type", "_code", "_ignoreVirtual"];

            private _oldEH = _oldPlayer getVariable [_x, -1];
            if (_oldEH != -1) then {
                _oldPlayer removeEventHandler [_type, _oldEH];
                _oldPlayer setVariable [_x, nil];
            };

            _oldEH = _newPlayer getVariable [_x, -1];
            if (_oldEH != -1) then { continue }; // if respawned then var and EH already exists
            if (_ignoreVirtual && _isVirtual) then { continue };

            private _newEH = _newPlayer addEventHandler [_type, _code];
            _newPlayer setVariable [_x, _newEH];
        } forEach GVAR(playerEventsHash);
    }, false] call CBA_fnc_addPlayerEventHandler;
};


_key = format [QGVAR(playerEvents_%1), toLowerANSI _key];
if (_key in GVAR(playerEventsHash)) exitWith { ERROR_1("bad key %1",_this); false};

GVAR(playerEventsHash) set [_key, [_type, _code, _ignoreVirtual]];

private _player = call CBA_fnc_currentUnit;
if (_ignoreVirtual && {(unitIsUAV _player) || {getNumber (configOf _player >> "isPlayableLogic") == 1}}) exitWith { false };

// Add event now
private _newEH = _player addEventHandler [_type, _code];
_player setVariable [_key, _newEH];

true // return
