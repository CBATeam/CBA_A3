#include "script_component.hpp"

LOG(MSG_INIT);

["CBA_loadGame",
{
	[] spawn
	{
		waitUntil { format["%1", findDisplay 46] != "No display" };
		(findDisplay 46) displayAddEventHandler ["KeyDown", QUOTE([_this, 0] call FUNC(keyHandler))];
		(findDisplay 46) displayAddEventHandler ["KeyUp", QUOTE([_this, 1] call FUNC(keyHandler))];
		// Todo: Evaluate combination
		(findDisplay 46) displayAddEventHandler ["KeyDown", QUOTE(_this call FUNC(actionHandler))];
	};
}] call CBA_fnc_addEventHandler;

["CBA_playerSpawn", { LOG("Player spawn detected!") }] call CBA_fnc_addEventHandler;

[] spawn
{
	private ["_lastPlayer", "_newPlayer"];
	waitUntil {player == player};
	_lastPlayer = objNull;
	while {true} do
	{
		waitUntil {player != _lastPlayer};
		waitUntil {!(isNull player)};
		_newPlayer = player; // Cumbersome but ensures refering to the same object
		["CBA_playerSpawn", [_newPlayer, _lastPlayer]] call CBA_fnc_localEvent;
		_lastPlayer = _newPlayer;
	};
};

[] spawn
{
	waitUntil { format["%1", findDisplay 46] != "No display" };
	(findDisplay 46) displayAddEventHandler ["KeyDown", QUOTE([_this, 0] call FUNC(keyHandler))];
	(findDisplay 46) displayAddEventHandler ["KeyUp", QUOTE([_this, 1] call FUNC(keyHandler))];

	// Todo: Evaluate combination
	(findDisplay 46) displayAddEventHandler ["KeyDown", QUOTE(_this call FUNC(actionHandler))];
};
