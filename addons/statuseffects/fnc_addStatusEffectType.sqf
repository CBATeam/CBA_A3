#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addStatusEffectType
Description:
    Adds a status effect that will be handled.

Parameters:
    _name               - Status Effect Name, this should match a corresponding event name <STRING>
    _isGlobal           - Send event globally (optional, default: false) <BOOL>
    _commonReasonsArray - Common Effect Reasons to pre-seed during init (optional, default: []) <ARRAY>
    _sendJIP            - Send event to JIP (requires sending event globally) <BOOL> (default: false)
    _eventName          - Event name <STRING> (default: "CBA_statusEffects_<effect>")

Returns:
    None

Examples
    (begin example)
        ["setCaptive", true, []] call CBA_fnc_addStatusEffectType
    (end)

Author:
    PabstMirror
---------------------------------------------------------------------------- */
SCRIPT(addStatusEffectType);
params [
    ["_name", "", [""]],
    ["_isGlobal", false, [false]],
    ["_commonReasonsArray", [], [[]]],
    ["_sendJIP", false, [false]],
    ["_eventName", "", [""]]
];

_name = toLowerANSI _name;
if (_name == "") exitWith {ERROR_1("addStatusEffectType - Bad Name %1",_this)};
if (_name in GVAR(statusEffects)) exitWith {WARNING_1("addStatusEffectType - Effect Already Added (note, will not update global bit) %1",_this)};
if (_sendJIP && !_isGlobal) exitWith {WARNING_1("addStatusEffectType - Trying to add non-global JIP effect %1",_this)};
if (_eventName == "") then { _eventName = format [QGVAR(%1), _name]; };

GVAR(statusEffects) set [_name, [_isGlobal, _sendJIP, _eventName]];

// We add reasons at any time, but more efficenet to add all common ones at one time during init
if (isServer && {_commonReasonsArray isNotEqualTo []}) then {
    // Switch case to lower:
    _commonReasonsArray = _commonReasonsArray apply { toLowerANSI _x };
    missionNamespace setVariable [(format [QGVAR(statusEffects_%1), _name]), _commonReasonsArray, true];
};
