/* ----------------------------------------------------------------------------
Internal Function: CBA_fnc_synchTeamColors

Description:
    Synchs the team colors per frame. Does not need to be called manually and
    is executed every frame.

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
            ["CBA_teamColorChanged", [_x, assignedTeam _x]] call CBA_fnc_remoteEvent;
        };
        true
    } count units player;
};
