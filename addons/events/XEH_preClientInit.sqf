//#define DEBUG_MODE_FULL
#include "script_component.hpp"
/*
	Custom events
*/
LOG(MSG_INIT);

["CBA_loadGame", { [] spawn FUNC(attach_handler) }] call CBA_fnc_addEventHandler;
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


// Display Eventhandlers - Abstraction layer
GVAR(attaching) = false;

FUNC(handle_retach) = 
{
	private ["_id", "_ar2"];
	// _key and _value
	TRACE_2("",_key,_value);
	{
		_id = _x select 0;
		if !(isNil "_id") then
		{
			TRACE_2("Removing",_key,_id);
			(findDisplay 46) displayRemoveEventHandler [_key, _id];
		};
		if (count _x != 1) then
		{
			TRACE_2("Adding",_key,_x select 1);
			_x set [0, (findDisplay 46) displayAddEventHandler [_key, _x select 1]];
		};
	} forEach _value;
};

// TODO: Stack/multiplex into single events per type ?
FUNC(attach_handler) =
{
	if (GVAR(attaching)) exitWith {}; // Already busy
	TRACE_3("ReAttaching",GVAR(attaching),GVAR(keypressed),time);
	GVAR(attaching) = true;

	waitUntil { !(isNull (findDisplay 46)) };
	TRACE_1("Display found!",time);
	_handle = { [GVAR(handler_hash), {call FUNC(handle_retach)}] call CBA_fnc_hashEachPair } execFSM CBA_common_delayLess;
	waitUntil {completedFSM _handle};
	GVAR(attaching) = false;
};


// Display Eventhandlers - Higher level API specially for keyDown/Up and Action events
// Workaround , in macros
#define UP [_this, 1]
#define DOWN [_this, 0]

[] spawn
{
	waitUntil { !(isNull (findDisplay 46)) };
	{ (findDisplay 46) displayRemoveAllEventHandlers _x } forEach ["KeyUp", "KeyDown"];
	// IMPORTANT: Case Sensitive Strings!
	["KeyUp", QUOTE(UP call FUNC(keyHandler))] call CBA_fnc_addDisplayHandler;
	["KeyDown", QUOTE(DOWN call FUNC(keyHandler))] call CBA_fnc_addDisplayHandler;
	["KeyDown", QUOTE(_this call FUNC(actionHandler))] call CBA_fnc_addDisplayHandler;


	// Workaround for displayEventhandlers falling off at gameLoad
	// Once the last registered keypress is longer than 10 seconds ago, re-attach the handler.
	GVAR(keypressed) = time;
	while {true} do
	{
		waitUntil {(time - GVAR(keypressed)) > 10};
		TRACE_1("Longer than 10 seconds ago",_this);
		call FUNC(attach_handler);
		GVAR(keypressed) = time;
	};
};
