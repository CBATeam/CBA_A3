#include "script_component.hpp"
/*
Function: CBA_fnc_removePlayerAction

Description:
    Removes player action previously added with <CBA_fnc_addPlayerAction>.

Parameters:
    _actionIndex - Index of action to remove [Number]

Returns:
    True if removed. False if a dedicated server or where the action was not
    defined [Boolean]

Example:
    (begin example)
        actionIndex = [["Teleport", "teleport.sqf"]] call CBA_fnc_addPlayerAction;

        // later

        [actionIndex] call CBA_fnc_removePlayerAction;
    (end)

Author:
    Sickboy

*/

params ["_actionIndex"];
TRACE_1(_this);

private _return = if (isDedicated) then {
    WARNING("Function ran on a dedicated server. Function only usable on a client. Index was: " + str _actionIndex);
    false;
} else {
    if ([GVAR(actionList), _actionIndex] call CBA_fnc_hashHasKey) then {
        [GVAR(actionlist),_actionIndex, nil] call CBA_fnc_hashSet;
        GVAR(actionListUpdated) = true;
        true;
    } else {
        WARNING("Action was not persistent: " + str _actionIndex);
        false;
    };
};

_return;

