#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_setStatusEffect
Description:
    Adds or removes an id to a status effect and will send an event to apply.

Parameters:
    _object     - Vehicle that it will be attached to (player or vehicle) <OBJECT>
    _effectName - Effect Name <STRING>
    _id         - Unique Reason ID <STRING>
    _set        - Is Set (true adds/false removes) <BOOL>

Returns:
    None

Examples
    (begin example)
        [player, "setCaptive", "reason1", true] call CBA_fnc_setStatusEffect
    (end)

Author:
    PabstMirror
---------------------------------------------------------------------------- */
SCRIPT(sendEffects);
params [
    ["_object", objNull, [objNull]],
    ["_effectName", "", [""]],
    ["_id", "", [""]],
    ["_set", true, [false]]
];

// Only run this after the settings are initialized
if !(GVAR(settingsInitFinished)) exitWith { // TODO: Switch to CBA equivalent, was ace_common_...
    TRACE_1("pushing to runAtSettingsInitialized",_this);
    GVAR(runAtSettingsInitialized) pushBack [CBA_fnc_setStatusEffect, _this];
};

if (isNull _object) exitWith {TRACE_1("null",_object);};

[_object, true] call FUNC(resetVariables); // Check for mismatch, and set object ref

// Check ID case and set globally if not already set:
_id = toLowerANSI _id;
private _statusReasons = missionNamespace getVariable [(format [QGVAR(statusEffects_%1), _effectName]), []];
private _statusIndex = _statusReasons find _id;
if (_statusIndex == -1) then {
    TRACE_2("ID not in global reasons, adding",_statusReasons,_id);
    _statusIndex = _statusReasons pushBack _id;
    missionNamespace setVariable [(format [QGVAR(statusEffects_%1), _effectName]), _statusReasons, true];
};

private _effectVarName = format [QGVAR(effect_%1), _effectName];
private _effectNumber = _object getVariable [_effectVarName, -1];
TRACE_2("current",_effectVarName,_effectNumber);

if ((_effectNumber == -1) && {!_set}) exitWith {
    // Optimization for modules that always set an ID to false even if never set true
    TRACE_2("Set False on nil array, exiting",_set,_effectNumber);
};

if (_effectNumber == -1) then {_effectNumber = 0}; // Reset (-1/nil) to 0

// If no change: skip sending publicVar and events
private _effectBoolArray = [_effectNumber, count _statusReasons] call FUNC(binarizeNumber); // TODO: ACE function
TRACE_2("bitArray",_statusIndex,_effectBoolArray);
if (_set isEqualTo (_effectBoolArray select _statusIndex)) exitWith {
    TRACE_2("No Change, exiting",_set,_effectBoolArray select _statusIndex);
};

TRACE_2("Setting to new value",_set,_effectBoolArray select _statusIndex);
_effectBoolArray set [_statusIndex, _set];
private _newEffectNumber = _effectBoolArray call FUNC(toBitmask); // Convert array back to number // TODO: ACE function

TRACE_2("Saving globally",_effectVarName,_newEffectNumber);
_object setVariable [_effectVarName, _newEffectNumber, true];

if (_effectNumber == 0 || {_newEffectNumber == 0}) then {
    [_object, _effectName] call FUNC(sendEffects);
} else {
    LOG("not sending more than once");
};
