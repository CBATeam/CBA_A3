/* ----------------------------------------------------------------------------
Internal Function: CBA_common_fnc_setCallsign

Description:
    Set call sign of a group via 3den attribute.

Parameters:
    _group    - A group <GROUP>
    _callsign - The call sign the group should receive <STRING>

Returns:
    Nothing

Author:
    snippers, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_group", grpNull, [grpNull]], ["_callsign", "", [""]]];

if (is3DEN) then {
    _group setGroupId [_callsign]; 
};

[{
    params ["_group", "_callsign"];

    _group setGroupIdGlobal [_callsign];
}, [_group, _callsign]] call CBA_fnc_execNextFrame;
