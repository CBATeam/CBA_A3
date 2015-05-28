/* ----------------------------------------------------------------------------
Function: CBA_fnc_addKeyHandlerFromConfig

Description:
    Adds an action to a keyhandler, read from config

Parameters:
    _component - Classname under "CfgSettings" >> "CBA" >> "events" [String].
    _action - Action classname [String].
    _code - Code to execute upon event [Code].
    _type - "keydown" (default) = keyDown,  "keyup" = keyUp [String].

Returns:

Examples:
    (begin example)
        ["cba_sys_nvg", "nvgon", { _this call myAction }] call CBA_fnc_addKeyHandlerFromConfig
    (end)

Author:
    Sickboy
---------------------------------------------------------------------------- */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"
SCRIPT(addKeyHandlerFromConfig);

private ["_key", "_type"];
PARAMS_3(_component,_action,_code);
_type = if (count _this > 3) then { _this select 3 } else { "keydown" };
_type = toLower _type;
if (_type in KEYS_ARRAY_WRONG) then { _type = ("key" + _type) };
if !(_type in KEYS_ARRAY) exitWith { ERROR("Type does not exist") };
_hashKey = toLower(format["%1_%2", _component, _action]);

_key = [_component, _action] call CBA_fnc_readKeyFromConfig;
if (_key select 0 > -1) exitWith {
    [_key select 0, _key select 1, _code, _type, _hashKey] call CBA_fnc_addKeyHandler;
    _hashKey;
};

"";
