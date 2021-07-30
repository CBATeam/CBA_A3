#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_players

Description:
    Reports all (human) player objects. Does not include headless client entities.

    Unlike "BIS_fnc_listPlayers", this function will not report the game logics of headless clients.

Parameters:
    _listLogics - List player game logics (Zeus, Spectator, etc). (optional, default: false) <BOOL>

Returns:
    List of all player objects <ARRAY>

Examples:
    (begin example)
        [] call CBA_fnc_players
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(players);

params [["_listLogics", false]];

private _units = allUnits + allDeadMen;
if _listLogics then {
    _units append units sideLogic;
};

_units select {isPlayer _x && {!(_x isKindOf "HeadlessClient_F")}}
