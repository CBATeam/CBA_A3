//#define DEBUG_MODE_FULL
#include "script_component.hpp"
/*
	Custom events
*/
LOG(MSG_INIT);

// Initialisation required by CBA events.
CBA_eventHandlers = "Logic" createVehicleLocal [0, 0];
CBA_eventHandlersLocal = "Logic" createVehicleLocal [0, 0];
CBA_EVENTS_DONE = false;

// TODO: Verify if this code is okay; there can be no player object ready at PreInit, thus it's not very useful
if (isServer || alive player) then {
	// We want all events, as soon as they start arriving.
	"CBA_e" addPublicVariableEventHandler { (_this select 1) call CBA_fnc_localEvent };
	"CBA_l" addPublicVariableEventHandler { (_this select 1) call FUNC(remoteLocalEvent) };
} else {
	// Ignore the last event that was sent out before we joined.
	SLX_XEH_STR spawn {
		waitUntil { alive player };
		"CBA_e" addPublicVariableEventHandler { (_this select 1) call CBA_fnc_localEvent };
		"CBA_l" addPublicVariableEventHandler { (_this select 1) call FUNC(remoteLocalEvent) };
	};
};

// Display Eventhandlers - Abstraction layer
GVAR(handler_hash) = [[], ""] call CBA_fnc_hashCreate;

// Display Eventhandlers - Higher level API specially for keyDown/Up and Action events
/*
	Example:
	class CfgSettings { class CBA { class Keys { class sys_attachments { cqb = 33 }; }; }; };

	- Script (in sys_attachments addon (it has COMPONENT defined as sys_attachments)):
	[QUOTE(COMPONENT), "cqb", { _this call GVAR(keyPressed) }] call cba_fnc_AddKeyHandlerFromConfig;
*/
private ["_arUp", "_arDown"];
GVAR(keyhandler_hash) = [[], []] call CBA_fnc_hashCreate;
GVAR(keyhandlers_down) = [[], []] call CBA_fnc_hashCreate;
GVAR(keyhandlers_up) = [[], []] call CBA_fnc_hashCreate;
_arUp = [GVAR(keyhandler_hash), "keyup"] call CBA_fnc_hashGet;
_arDown = [GVAR(keyhandler_hash), "keydown"] call CBA_fnc_hashGet;
for "_i" from 0 to 250 do {
	_arUp set [_i, []];
	_arDown set [_i, []];
};

// Due to limitation, have to actually set the first time
[GVAR(keyhandler_hash), "keyup", _arUp] call CBA_fnc_hashSet;
[GVAR(keyhandler_hash), "keydown", _arDown] call CBA_fnc_hashSet;

PREP(keyHandler);
PREP(remoteLocalEvent);

CBA_fnc_remoteLocalEvent = FUNC(remoteLocalEvent); // BWC

/*
	// Action Handler
	// Disabled - SB - 2010-01-22: Bugged, and not working anyway.
	// FIXME: #define __cfg ??
	GVAR(actions) = "LOGIC" createVehicleLocal [0, 0, 0];
	for "_i" from 0 to ((count (__cfg)) - 1) do
	{
		_entry = (__cfg) select _i;
		if (isArray(_entry)) then
		{
			GVAR(actions) setVariable [configName _entry, []];
		};
	};

	PREP(actionHandler);
*/

/*
// loadGame EventHandler
["CBA_loadGame", { LOG("Game load detected!") }] call CBA_fnc_addEventHandler;

// Disabled - SB - 2009-07-22: Script scheduling seems to mess this up. Mostly spotted at dedicated server.
FUNC(initLoadGameEvent) = {
	// Based on the pretty much assumption that loadedGames are always back in time, not forward
	private ["_history"];
	_history = diag_frameNo;

	waitUntil
	{
		// Instead of + 1, using + 10, it seems script scheduling or something else can allow more than 1 frame skip per iteration
		if (_history + 10 < diag_frameNo) then
		{
				["CBA_loadGame"] call CBA_fnc_localEvent;
				diag_log text format["%1", _history];
		};
		_history = diag_frameNo;
		false
	};
};
["CBA_MISSION_START", { SLX_XEH_STR spawn FUNC(initLoadGameEvent) }] CBA_fnc_addEventHandler;
*/

CBA_MISSION_START = false;
objNull spawn { waitUntil {time > 0}; [objNull, {CBA_MISSION_START = true; ["CBA_MISSION_START", time] call CBA_fnc_localEvent}] call CBA_common_fnc_directCall; };

nil;
