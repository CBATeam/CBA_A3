#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_changeKeyHandler

Description:
    Changes the key of a key handler.

Parameters:
    _hashKey  - Key handler identifier. <STRING>
    _key      - New key (DIK-Code). <NUMBER>
    _settings - New Settings. Shift, Ctrl, Alt required. (default: [false, false, false]) <ARRAY>
    _type     - "keydown" or "keyup". (optional) (default: "keydown") <STRING>

Returns:
    None

Examples:
    (begin example)
        [_id, 44, [false, false, false]] call CBA_fnc_changeKeyHandler;
    (end)

Author:
    Sickboy, commy2
---------------------------------------------------------------------------- */
SCRIPT(changeKeyHandler);

if (!hasInterface) exitWith {};

params [
    ["_hashKey", "", [""]],
    ["_key", 0, [0]],
    ["_settings", [false, false, false], [[]], 3],
    ["_type", "keydown", [""]]
];

_type = toLower _type;

// add "key" prefix to "down" and "up"
if (_type in ["down", "up"]) then {
    _type = "key" + _type;
};

// check if type is either "keydown" or "keyup"
if !(_type in ["keydown", "keyup"]) exitWith {
    ERROR("Type does not exist");
};

_hashKey = toLower _hashKey;

private _hash = [GVAR(keyHandlersDown), GVAR(keyHandlersUp)] select (_type == "keyup");
private _keyData = _hash getVariable _hashKey;

if (isNil "_keyData") exitWith {
    WARNING_2("Key handler %1 (%2) does not exist",_hashKey,_type);
};

private _oldKey = _keyData select 0;
private _keyHandlers = [GVAR(keyDownStates), GVAR(keyUpStates)] select (_type == "keyup");

// remove from old key
if (count _keyHandlers > _oldKey) then {
    _keyHandlers set [_oldKey, (_keyHandlers select _oldKey) - [_hashKey]];
};

// forget that the handler is held on the old key, its release would not be matched to the new key anymore
GVAR(keyDownActiveList) = GVAR(keyDownActiveList) - [_hashKey];
if (_type == "keyup") then {
    GVAR(keyUpActiveList) = GVAR(keyUpActiveList) - [_hashKey];
    GVAR(keyHoldTimers) setVariable [_hashKey, nil];
};

// add to new key
private _hashKeys = _keyHandlers param [_key, []];
_hashKeys pushBackUnique _hashKey;
_keyHandlers set [_key, _hashKeys];

_keyData set [0, _key];
_keyData set [1, _settings];

// keep the default keyup handler of a keydown handler on the same key
if (_type == "keydown") then {
    [_hashKey + "_cbadefaultuphandler", _key, _settings, "keyup"] call CBA_fnc_changeKeyHandler;
};

if ((_oldKey >= USERACTION_OFFSET && {_oldKey <= USERACTION_OFFSET + 19}) || {_key >= USERACTION_OFFSET && {_key <= USERACTION_OFFSET + 19}}) then {
    GVAR(skipCheckingUserActions) = {count _x > 0} count (GVAR(keyDownStates) select [USERACTION_OFFSET, 20]) == 0;
};

nil
