/* ----------------------------------------------------------------------------
Function: CBA_fnc_changeKeyHandler

Description:
    Changes the key of a key handler.

Parameters:
    _hashKey  - Key handler identifier. <STRING>
    _key      - New key (DIK-Code). <NUMBER>
    _settings - New Settings. Shift, Ctrl, Alt required. (default: [false, false, false]) <ARRAY>
    _type     - "keydown" or "keyup". [optional] (default: "keydown") <STRING>

Returns:
    None

Examples:
    (begin example)
        [_id, 44, [false, false, false]] call CBA_fnc_changeKeyHandler;
    (end)

Author:
    Sickboy, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
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
private _key = _keyData select 0;
private _keyHandlers = [GVAR(keyDownStates), GVAR(keyUpStates)] select (_type == "keyup");

if (count _keyHandlers > _key) then {
    private _hashKeys = _keyHandlers select _key;

    _hashKeys = _hashKeys - [_hashKey];
    _hashKeys pushBack _hashKey;
    _keyHandlers set [_key, _hashKeys];

    _keyData set [0, _key];
    _keyData set [1, _settings];
};

nil
