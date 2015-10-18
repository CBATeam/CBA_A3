/* ----------------------------------------------------------------------------
Internal Function: CBA_fnc_onTeamColorChanged

Description:
    Assigns the units team color if it changed on another machine.

Parameters:
    _unit - unit [OBJECT]
    _team - team the unit got assigned to [STRING]

Returns:
    Nothing

Author:
    BaerMitUmlaut
---------------------------------------------------------------------------- */

#include "script_component.hpp"
params ["_unit", "_team"];

_unit assignTeam _team;
if (isServer) then {
    _unit setVariable [QGVAR(synchedTeam), _team, true];
};
