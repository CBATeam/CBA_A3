#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getStatusEffect
Description:
    Retrieves list of current status effects

Parameters:
    _object     - Vehicle that it will be attached to (player or vehicle) <OBJECT>
    _effectName - Effect Name <STRING>

Returns:
    Effect status <ARRAY>
        - 0: is actively set (if false, the effect is ignored and never modified) <BOOL>
        - 1: reasons why it is set true (list of strings, count of 0 = false, 1+ = true) <ARRAY>

Examples
    (begin example)
        [player, "forceWalk"] call CBA_fnc_getStatusEffect
    (end)

Author:
    PabstMirror
---------------------------------------------------------------------------- */
SCRIPT(getStatusEffect);
params [
    ["_object", objNull, [objNull]],
    ["_effectName", "", [""]]
];

if (isNull _object) exitWith {
    TRACE_1("null",_object);
    [false, []]
};

[_object, false] call FUNC(resetVariables); // Check for mismatch

// List of reasons
private _statusReasons = missionNamespace getVariable [(format [QGVAR(statusEffects_%1), _effectName]), []];
if (_statusReasons isEqualTo []) exitWith {
    TRACE_1("no reasons - bad effect?",_statusReasons);
    [false, []]
};

// Get Effect Number
private _effectVarName = format [QGVAR(effect_%1), _effectName];
private _effectNumber = _object getVariable [_effectVarName, -1];
TRACE_2("current",_effectVarName,_effectNumber);

if (_effectNumber == -1) exitWith { // Nil array - no effect
    [false, []]
};
if (_effectNumber == 0) exitWith { // Empty array - false effect
    [true, []]
};

// If no change: skip sending publicVar and events
private _effectBoolArray = [_effectNumber, count _statusReasons] call FUNC(binarizeNumber); // TODO: ACE Function
TRACE_1("bitArray",_effectBoolArray);

private _activeEffects = [];
{
    if (_x) then {
        _activeEffects pushBack (_statusReasons select _forEachIndex);
    };
} forEach _effectBoolArray;

// Non-empty array - true effect
[true, _activeEffects]
