#include "script_component.hpp"

LOG(MSG_INIT);

#define DOWN [_this, 0]
#define UP [_this, 1]

GVAR(keypressed) = -15;
FUNC(attach_handler) =
{
	waitUntil { format["%1", findDisplay 46] != "No display" };
	if !(isNil QUOTE(GVAR(keydown_handler))) then
	{
		(findDisplay 46) displayRemoveEventHandler ["KeyDown", GVAR(keydown_handler)];
		(findDisplay 46) displayRemoveEventHandler ["KeyDown", GVAR(action_handler)];
		(findDisplay 46) displayRemoveEventHandler ["KeyUp", GVAR(keyup_handler)];
	};
	GVAR(keydown_handler) = (findDisplay 46) displayAddEventHandler ["KeyDown", QUOTE(DOWN call FUNC(keyHandler))];
	GVAR(keyup_handler) = (findDisplay 46) displayAddEventHandler ["KeyUp", QUOTE(UP call FUNC(keyHandler))];
	// Todo: Evaluate combination
	GVAR(action_handler) = (findDisplay 46) displayAddEventHandler ["KeyDown", QUOTE(_this call FUNC(actionHandler))];
};

["CBA_loadGame",
{
	[] spawn FUNC(attach_handler);
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

// Workaround for displayEventhandlers falling off at gameLoad
// Once the last registered keypress is longer than 10 seconds ago, re-attach the handler.
[] spawn
{
	while {true} do
	{
		waitUntil {(time - GVAR(keypressed)) > 10};
		call FUNC(attach_handler);
		GVAR(keypressed) = time;
	};
};
