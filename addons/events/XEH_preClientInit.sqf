// Any registered functions used in the PreINIT phase must use the uiNamespace copies of the variable. 
// So uiNamespace getVariable "CBA_fnc_hashCreate" instead of just CBA_fnc_hashCreate -VM
// #define DEBUG_MODE_FULL
#include "script_component.hpp"
/*
	Custom events
*/
LOG(MSG_INIT);

// ["CBA_loadGame", { SLX_XEH_STR spawn FUNC(attach_handler) }] call CBA_fnc_addEventHandler; // EH is unimplemented due to unreliable
["CBA_playerSpawn", { LOG("Player spawn detected!") }] call (uiNamespace getVariable "CBA_fnc_addEventHandler");

SLX_XEH_STR spawn {
	private ["_lastPlayer", "_newPlayer"];
	waitUntil {player == player};
	_lastPlayer = objNull;
	while {true} do {
		waitUntil {player != _lastPlayer};
		waitUntil {!isNull player};
		_newPlayer = player; // Cumbersome but ensures refering to the same object
		["CBA_playerSpawn", [_newPlayer, _lastPlayer]] call (uiNamespace getVariable "CBA_fnc_localEvent");
		_lastPlayer = _newPlayer;
	};
};


// Display Eventhandlers - Abstraction layer
GVAR(attaching) = false;

FUNC(handle_retach) = {
	private ["_id", "_ar2"];
	// _key and _value
	TRACE_2("",_key,_value);
	{
		_id = _x select 0;
		if !(isNil "_id") then {
			TRACE_2("Removing",_key,_id);
			(findDisplay 46) displayRemoveEventHandler [_key, _id];
		};
		if (count _x != 1) then {
			TRACE_2("Adding",_key,_x select 1);
			_x set [0, (findDisplay 46) displayAddEventHandler [_key, _x select 1]];
		};
	} forEach _value;
};

CBA_EVENT_KEY_LOGIC = objNull;

GVAR(keypressed) = -100;
GVAR(attach_count) = 0;

// TODO: Stack/multiplex into single events per type ?
FUNC(attach_handler) = {
	if !(isNull (findDisplay 46)) then {
		TRACE_2("ReAttaching",GVAR(keypressed),GVAR(attach_count));
		GVAR(keypressed) = time;
		[GVAR(handler_hash), {call FUNC(handle_retach)}] call (uiNamespace getVariable "CBA_fnc_hashEachPair");
		CBA_EVENTS_DONE = true;
		INC(GVAR(attach_count));
	};
};

// Display Eventhandlers - Higher level API specially for keyDown/Up and Action events
#define TIMEOUT 10
// Workaround , in macros
#define UP [_this, 'keyup']
#define DOWN [_this, 'keydown']

["KeyUp", QUOTE(UP call FUNC(keyHandler))] call (uiNamespace getVariable "CBA_fnc_addDisplayHandler");
["KeyDown", QUOTE(DOWN call FUNC(keyHandler))] call (uiNamespace getVariable "CBA_fnc_addDisplayHandler");

SLX_XEH_STR spawn {
	waitUntil { !isNull (findDisplay 46) };
	// Workaround for Single Player, mission editor, or mission, preview/continue, whatever, adding double handlers
	if !(isMultiplayer) then { { (findDisplay 46) displayRemoveAllEventHandlers _x } forEach ["KeyUp", "KeyDown"] };

	// Trigger will attach it..
	// call FUNC(attach_handler);

	// ["KeyDown", QUOTE(_this call FUNC(actionHandler))] call CBA_fnc_addDisplayHandler;

	// Workaround for displayEventhandlers falling off at gameLoad after gameRestart
	// Once the last registered keypress is longer than TIMEOUT seconds ago, re-attach the handler.
	if (isServer) then { // isServer = SP or MP server-client
		// Use a trigger, runs every 0.5s, unscheduled execution
		GVAR(keyTrigger) = createTrigger["EmptyDetector", [0,0,0]];
		GVAR(keyTrigger) setTriggerStatements[QUOTE(if ((GVAR(keypressed) + TIMEOUT) < time) then { call FUNC(attach_handler) }), "", ""];
	} else { // dedicatedClient
		// TODO: Find better dummy class to use
		CBA_EVENT_KEY_LOGIC = SLX_XEH_DUMMY createVehicleLocal [0,0,0];
		CBA_EVENT_KEY_LOGIC addEventHandler ["Killed", {
			call FUNC(attach_handler);
			deleteVehicle CBA_EVENT_KEY_LOGIC;
		}];
		CBA_EVENT_KEY_LOGIC setDamage 1;
	};
};
