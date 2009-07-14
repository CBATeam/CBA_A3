/* ----------------------------------------------------------------------------
Function: CBA_fnc_players

Description:
	Get a list of current player objects.
	
	In multi-player missions, returns list of human players, rather than all
	playable units (playableUnits includes playable AI). Will include dead
	player objects for players who are waiting to respawn.

	In single-player missions, just returns an array containing the current
	player object.
	
	This command is similar to BIS_fnc_listPlayers. In fact, it is the same in
	MP, but in SP it returns a result which is consistent to prevent the need
	to handle things differently in different types of game 
	(BIS_fnc_listPlayers uses different criteria for the list in SP and MP).

Parameters:
	None.
	
Returns:
	List of player objects [Array of Objects].
	
Examples:
	(begin example)
		_players = call CBA_fnc_players;
	(end)

Author:
	Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(players);

private "_return";

_return = if (isMultiplayer) then
{
	[playableUnits, { isPlayer _x }] call BIS_fnc_conditionalSelect;
}
else
{
	[player];
};

_return;
