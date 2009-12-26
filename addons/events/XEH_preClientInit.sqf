#include "script_component.hpp"

LOG(MSG_INIT);

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

// Display Eventhandlers

// Higher level API specially for keyDown/Up and Action events
#define DOWN [_this, 0]
#define UP [_this, 1]

waitUntil { format["%1", findDisplay 46] != "No display" };
["KeyUp", QUOTE(UP call FUNC(keyHandler))] call CBA_fnc_addDisplayHandler;
["KeyDown", QUOTE(DOWN call FUNC(keyHandler))] call CBA_fnc_addDisplayHandler;
["KeyDown", QUOTE(_this call FUNC(actionHandler))] call CBA_fnc_addDisplayHandler;


// Workaround for displayEventhandlers falling off at gameLoad
// Once the last registered keypress is longer than 10 seconds ago, re-attach the handler.
GVAR(keypressed) = time;
[] spawn
{
	while {true} do
	{
		waitUntil {(time - GVAR(keypressed)) > 10};
		call FUNC(attach_handler);
		GVAR(keypressed) = time;
	};
};
