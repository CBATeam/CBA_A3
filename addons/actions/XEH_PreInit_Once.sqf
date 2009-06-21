#include "script_component.hpp"
/*
	ActionHandler, by Sickboy <sb_at_dev-heaven.net>

	Example:
	- Config (in actions, it has PREFIX defined as CBA, and COMPONENT as keys):
	class CfgSettings { class PREFIX { class COMPONENT { class sys_attachments { cqb = 33 }; }; }; };

	- Script (in sys_attachments addon (it has COMPONENT defined as sys_attachments)):
	[QUOTE(COMPONENT), "cqb", { _this call GVAR(actionPressed) }] call CBA_keys_fAddHandlerFromConfig;
*/
#define __cfg configFile >> "CfgDefaultKeysMapping"
["Initializing...", QUOTE(ADDON), DEBUG_SETTINGS] call CBA_fDebug;

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

// TODO: Evaluate if functions should be loaded on servers!
PREP(fHandler);
PREP(fAddHandler);
PREP(fAddHandlerFromConfig);
PREP(fReadActionFromConfig);
