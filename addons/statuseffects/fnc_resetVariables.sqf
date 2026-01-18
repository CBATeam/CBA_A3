#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_statusEffects_fnc_resetVariables
Description:
    Resets all effect numbers to 0 when an object respawns (but does not apply the effect event).

Parameters:
    _object       - Vehicle that it will be attached to (player or vehicle) <OBJECT>
    _setObjectRef - Explicitly set object reference (optional, default: false) <BOOL>

Returns:
    None

Examples
    (begin example)
        [player, true] call CBA_statusEffects_fnc_resetVariables
    (end)

Author:
    PabstMirror
---------------------------------------------------------------------------- */
SCRIPT(resetVariables);
params [
    ["_object", objNull, [objNull]],
    ["_setObjectRef", false, [false]]
];

if (isNull _object) exitWith {};

private _objectRef = _object getVariable QGVAR(object);
TRACE_2("testing",_object,_objectRef);

// If nothing was ever set, or objects match, exit (always true unless respawned)
if (isNil "_objectRef") exitWith {
    if (_setObjectRef) then {
        _object setVariable [QGVAR(object), _object, true]; // Explicitly set new object ref
    };
};
if (_object == _objectRef) exitWith {};

// Mismatch, so if effect has ever been defined, reset to 0
{
    private _effectVarName = format [QGVAR(effect_%1), _x];
    private _effectNumber = _object getVariable [_effectVarName, -1];
    if (_effectNumber != -1) then {
        TRACE_2("forced reset defined array on object mismatch",_x,_effectNumber);
        _object setVariable [_effectVarName, 0, true]; // This always resets to 0 (not -1/nil)!
    };
} forEach GVAR(statusEffects);

_object setVariable [QGVAR(statusEffect_object), _object, true];
