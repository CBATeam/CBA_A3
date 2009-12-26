#include "script_component.hpp"
/*
	MainDisplay KeyHandler, by Sickboy <sb_at_dev-heaven.net>

	Example:
	class CfgSettings { class CBA { class Keys { class sys_attachments { cqb = 33 }; }; }; };

	- Script (in sys_attachments addon (it has COMPONENT defined as sys_attachments)):
	[QUOTE(COMPONENT), "cqb", { _this call GVAR(keyPressed) }] call cba_keys_fAddHandlerFromConfig;
*/
LOG(MSG_INIT);

GVAR(keys_down) = []; GVAR(keys_up) = [];
for "_i" from 0 to 250 do
{
	GVAR(keys_down) set [_i, []];
	GVAR(keys_up) set [_i, []];
};

private ["_count"];
_count = (count (__cfg)) -1;
GVAR(actions) = "LOGIC" createVehicleLocal [0, 0, 0];

for "_i" from 0 to _count do
{
	_entry = (__cfg) select _i;
	if (isArray(_entry)) then
	{
		GVAR(actions) setVariable [configName _entry, []];
	};
};

PREP(actionHandler);
PREP(keyHandler);
//PREP(globalHitEvent);
//PREP(globalKilledEvent);

// Display Eventhandlers - Abstraction layer
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
	private ["_i", "_id", "_ar2"];
	PARAMS_2(_type,_ar); // _key and _value
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


// Initialisation required by CBA events.
CBA_eventHandlers = "Logic" createVehicleLocal [0, 0];
// TODO: Verify if this code is okay; there can be no player object ready at PreInit, thus it's not very useful
if (isServer or (alive player)) then
{
	// We want all events, as soon as they start arriving.
	"CBA_e" addPublicVariableEventHandler { (_this select 1) call CBA_fnc_localEvent };
}
else
{
	// Ignore the last event that was sent out before we joined.
	[] spawn
	{
		waitUntil { alive player };
		"CBA_e" addPublicVariableEventHandler { (_this select 1) call CBA_fnc_localEvent};
	};
};

// loadGame EventHandler
//["CBA_loadGame", { LOG("Game load detected!") }] call CBA_fnc_addEventHandler;

/*
// Disabled - SB - 2009-07-22: Script scheduling seems to mess this up. Mostly spotted at dedicated server.
[] spawn
{
	// Based on the pretty much assumption that loadedGames are always back in time, not forward
	private ["_history"];
	waitUntil { time > 0 };
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
*/

nil;
