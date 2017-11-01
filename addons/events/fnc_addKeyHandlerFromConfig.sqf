/* ----------------------------------------------------------------------------
Function: CBA_fnc_addKeyHandlerFromConfig

Description:
    Adds an action to a keybind from config.

Parameters:
    _component - Classname under "CfgSettings" >> "CBA" >> "events" <STRING>
    _action    - Action name <STRING>
    _code      - Code to execute upon event. <CODE>
    _type      - "keydown" or "keyup". [optional] (default: "keydown") <STRING>

Returns:
    _hashKey - Key handler identifier. Used to remove or change the key handler. <STRING>

Examples:
    (begin example)
        ["cba_sys_nvg", "nvgon", {_this call myAction}] call CBA_fnc_addKeyHandlerFromConfig
    (end)

Author:
    Sickboy, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addKeyHandlerFromConfig);

if (!hasInterface) exitWith {""};

params [
    ["_component", "", [""]],
    ["_action", "", [""]],
    ["_code", {}, [{}]],
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
    ""
};

private _hashKey = toLower format ["%1_%2", _component, _action];

([_component, _action] call CBA_fnc_readKeyFromConfig) params ["_key", "_settings"];

if (_key <= 0) exitWith {""};

[_key, _settings, _code, _type, _hashKey] call CBA_fnc_addKeyHandler // return
