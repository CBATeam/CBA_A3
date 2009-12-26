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

// Abstraction layer
GVAR(handler_hash) = [[], []] call CBA_fnc_hashCreate;

CBA_fnc_addDisplayHandler =
{
	private ["_ar", "_id", "_idx"];
	PARAMS_2(_type,_code);

	_ar = [GVAR(handler_hash), _type] CBA_fnc_hashGet;
	_id = (findDisplay 46) displayAddEventhandler [_type, _code];
	_idx = count _ar;
	_ar set [_idx, [_id, _code]]
	[GVAR(handler_hash), _type, _ar] CBA_fnc_hashSet; // this actually required, since we're only referencing ?
	_idx;
};

CBA_fnc_removeDisplayHandler =
{
	private ["_ar"];
	PARAMS_3(_type,_index);

	_ar = [GVAR(handler_hash), _type] CBA_fnc_hashGet;
	(findDisplay 46) displayRemoveEventhandler [_type, (_ar select _index) select 0];
	_ar set [_index, nil];
	[GVAR(handler_hash), _type, _ar] CBA_fnc_hashSet;
};


FUNC(handle_retach) = 
{
	PARAMS_3(_type,_ar);
	_i = 0;
	{
		if !(isNil "_x") then
		{
			(findDisplay 46) displayRemoveEventHandler [_type, _x select 0]
			_id = (findDisplay 46) displayAddEventHandler [_type, _x select 1];
			_ar2 = _ar select _i;
			_ar2 set [0, _id];
			_ar set [_i, _ar2];
		};
		_i = _i + 1;
	} forEach _ar;
};

FUNC(attach_handler) =
{
	waitUntil { format["%1", findDisplay 46] != "No display" };
	[GVAR(handler_hash), FUNC(handle_retach)] call CBA_fnc_hashEachPair;
};




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
