/* ----------------------------------------------------------------------------
Internal Function: CBA_common_fnc_synchTeamColors

Description:
    Synchs the team colors. Does not need to be called manually.

Parameters:
    None

Returns:
    Nothing

Author:
    BaerMitUmlaut
---------------------------------------------------------------------------- */
#include "script_component.hpp"

if (leader player == player) then {
    {
        if ((assignedTeam _x) != (_x getVariable [QGVAR(synchedTeam), "MAIN"])) then {
            //Local team != currently synched team, so we need to synchronize them again
            ["CBA_teamColorChanged", [_x, assignedTeam _x]] call CBA_fnc_globalEvent;
        };
        true
    } count units player;
};
