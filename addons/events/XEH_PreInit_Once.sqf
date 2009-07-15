#include "script_component.hpp"
/*
	MainDisplay KeyHandler, by Sickboy <sb_at_dev-heaven.net>

	Example:
	class CfgSettings { class CBA { class Keys { class sys_attachments { cqb = 33 }; }; }; };

	- Script (in sys_attachments addon (it has COMPONENT defined as sys_attachments)):
	[QUOTE(COMPONENT), "cqb", { _this call GVAR(keyPressed) }] call cba_keys_fAddHandlerFromConfig;
*/
LOG(MSG_INIT);

GVAR(keys) = [];
for "_i" from 0 to 250 do
{
	GVAR(keys) set [_i, []];
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

[QUOTE(GVAR(loadgame)), { LOG("Game load detected!") }] call CBA_fnc_addEventHandler;
[] spawn
{
	private ["_history"];
	waitUntil { time > 0 };
	_history = [diag_tickTime];
	
	waitUntil
	{
		PUSH(_history,diag_tickTime);
		_c = count _history;
		if (_c > 1) then
		{
			if (diag_tickTime > (_history select (_c - 1)) + 5 || diag_tickTime > (_history select (_c - 2)) + 6) then
			{
				[QUOTE(GVAR(loadgame))] call CBA_fnc_localEvent;
			};
			if (_c > 3) then
			{
				REM(_history,[_history select 0]);
			};
		};
		false
	};
};

nil;
