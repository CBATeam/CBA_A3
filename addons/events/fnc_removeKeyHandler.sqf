/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeKeyHandler

Description:
    Removes an action from a keybind.

Parameters:
    _hashKey - Key handler identifier. <STRING>
    _type    - "keydown" or "keyup". [optional] (default: "keydown") <STRING>

Returns:
    None

Examples:
    (begin example)
        _id call CBA_fnc_removeKeyHandler;
        ["cba_anothersystem_keyup", "keyup"] call CBA_fnc_removeKeyHandler;
    (end)

Author:
    Sickboy, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(removeKeyHandler);

if (!hasInterface) exitWith {};

params [
    ["_hashKey", "", [""]],
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

// remove default keyup handler from keydown
if (_type == "keydown") then {
    [_hashKey + "_cbadefaultuphandler", "keyup"] call CBA_fnc_removeKeyHandler;
};

private _hash = [GVAR(keyHandlersDown), GVAR(keyHandlersUp)] select (_type == "keyup");
private _key = (_hash getVariable _hashKey) select 0;

private _keyHandlers = [GVAR(keyDownStates), GVAR(keyUpStates)] select (_type == "keyup");

if (count _keyHandlers > _key) then {
    private _hashKeys = _keyHandlers select _key;
    _hashKeys = _hashKeys - [_hashKey];
    _keyHandlers set [_key, _hashKeys];
};

if ((_key >= USERACTION_OFFSET) && {_key <= USERACTION_OFFSET + 19}) then {
    private _hasUserActionsBound = {count _x > 0} count (GVAR(keyDownStates) select [USERACTION_OFFSET, 20]) > 0;

    if (!_hasUserActionsBound) then {
        GVAR(skipCheckingUserActions) = true;
    };
};

nil
