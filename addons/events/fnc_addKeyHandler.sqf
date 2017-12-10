/* ----------------------------------------------------------------------------
Function: CBA_fnc_addKeyHandler

Description:
    Adds an action to a keybind.

Parameters:
    _key       - Key (DIK-Code) to attach action to. <NUMBER>
    _settings  - Shift, Ctrl, Alt required. (default: [false, false, false]) <ARRAY>
    _code      - Code to execute upon event. <CODE>
    _type      - "keydown" or "keyup". [optional] (default: "keydown") <STRING>
    _hashKey   - Key handler identifier. Randomly generated if not supplied. [optional] <STRING>
    _allowHold - Will the key fire every frame while hold down? [optional] (default: true) <BOOLEAN>
    _holdDelay - How long after keydown will the key event fire, in seconds. [optional] <NUMBER>

Returns:
    _hashKey - Key handler identifier. Used to remove or change the key handler. <STRING>

Examples:
    (begin example)
        _id = [47, [true, false, false], {_this call myAction}] call CBA_fnc_addKeyHandler;
    (end)

Author:
    Sickboy, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addKeyHandler);

if (!hasInterface) exitWith {""};

params [
    ["_key", 0, [0]],
    ["_settings", [false, false, false], [[]], 3],
    ["_code", {}, [{}]],
    ["_type", "keydown", [""]],
    ["_hashKey", "", [""]],
    ["_allowHold", true, [false]],
    ["_holdDelay", 0, [0]]
];

_type = toLower _type;

// add "key" prefix to "down" and "up"
if (_type in ["down", "up"]) then {
    _type = "key" + _type;
};

// check if type is either "keydown" or "keyup"
if !(_type in ["keydown", "keyup"]) exitWith {
    ERROR("Type does not exist");
    ""
};

// create random hash if none was supplied
if (_hashKey isEqualTo "") then {
    _hashKey = format ["%1%2%3%4", floor random 1E4, floor random 1E4, floor random 1E4, floor random 1E4];
};

_hashKey = toLower _hashKey;

private _hash = [GVAR(keyHandlersDown), GVAR(keyHandlersUp)] select (_type == "keyup");

// fix using addKeyHander twice on different keys makes old handler unremovable
if (!isNil {_hash getVariable _hashKey}) then {
    [_hashKey, _type] call CBA_fnc_removeKeyHandler;
};

// add default keyup handler to keydown
if (_type isEqualTo "keydown") then {
    private _params = + _this;
    _params set [2, FUNC(handleKeyDownUp)];
    _params set [3, "keyup"];
    _params set [4, _hashKey + "_cbadefaultuphandler"];
    _params call CBA_fnc_addKeyHandler;
};

_hash setVariable [_hashKey, [_key, _settings, _code, _allowHold, _holdDelay]];

private _keyHandlers = [GVAR(keyDownStates), GVAR(keyUpStates)] select (_type == "keyup");

private _hashKeys = _keyHandlers param [_key, []];
_hashKeys pushBackUnique _hashKey; // pushBackUnique. Fixes using addKeyHander twice with the same keyHash/id executing the newly added action twice.

_keyHandlers set [_key, _hashKeys];

if ((_key >= USERACTION_OFFSET) && {_key <= USERACTION_OFFSET + 19}) then {
    private _hasUserActionsBound = {count _x > 0} count (GVAR(keyDownStates) select [USERACTION_OFFSET, 20]) > 0;

    if (_hasUserActionsBound) then {
        GVAR(checkUserActions) = true;
    };
};

_hashKey
