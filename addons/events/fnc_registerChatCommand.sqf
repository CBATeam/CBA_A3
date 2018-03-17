/* ----------------------------------------------------------------------------
Function: CBA_fnc_registerChatCommand

Description:
    Register a custom chat command on the local machine.

Parameters:
    _command      - Chat command <STRING>
    _code         - Code to execute after command was entered. <CODE>
    _availableFor - "all", "admin" or "adminLogged" (optional, default: "admin") <STRING>
    _thisArgs     - Arguments to pass to event chat handler code <ANY>

Returns:
    _return - true: Success, false: Error <BOOLEAN>

Examples:
    (begin example)
        // '#skipTime 12' will make it night
        ["skipTime", {parseNumber (_this select 0) remoteExec ["skipTime"];}, "admin"] call CBA_fnc_registerChatCommand;

        // "Detonate" will blow up the charge
        ["Detonate", {_thisArgs setDamage 1}, "admin", _placedDemoCharge] call CBA_fnc_registerChatCommand;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(registerChatCommand);

if (isNil QGVAR(customChatCommands)) then {
    GVAR(customChatCommands) = [] call CBA_fnc_createNamespace;
};

params [
    ["_command", "", [""]],
    ["_code", {}, [{}]],
    ["_availableFor", "admin", [""]],
    ["_thisArgs", []]
];

if (_command isEqualTo "") exitWith {
    WARNING("chat command cannot be empty string");
    false
};

if (_code isEqualTo {}) exitWith {
    WARNING_1("code for chat command %1 cannot be empty function",str _command);
    false
};

_availableFor = toLower _availableFor;

if !(_availableFor in ["all", "admin", "adminlogged"]) exitWith {
    WARNING_1("wrong argument %2 for chat command %1.",str _command,str _availableFor);
    false
};

GVAR(customChatCommands) setVariable [_command, [_code, _availableFor, _thisArgs]];
true
