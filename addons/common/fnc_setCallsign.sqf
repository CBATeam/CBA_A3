#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_setCallsign

Description:
    Set call sign of a group.

    Works in SP, MP and Eden-Editor and at any point.

Parameters:
    _group    - A group <GROUP, OBJECT>
    _callsign - The call sign the group should receive <STRING>

Returns:
    Nothing

Example:
    (begin example)
        [group player, "Banana Squad"] call CBA_fnc_setCallsign
    (end)

Author:
    snippers, commy2
---------------------------------------------------------------------------- */
SCRIPT(setCallsign);

params [["_group", grpNull, [grpNull, objNull]], ["_callsign", "", [""]]];

private _group = _group call CBA_fnc_getGroup;

if (is3DEN) then {
    _group setGroupId [_callsign]; 
};

[{
    params ["_group", "_callsign"];

    _group setGroupIdGlobal [_callsign];
}, [_group, _callsign]] call CBA_fnc_execNextFrame;
