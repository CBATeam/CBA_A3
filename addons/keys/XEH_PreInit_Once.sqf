#include "script_component.hpp"
/*
	MainDisplay KeyHandler, by Sickboy <sb_at_dev-heaven.net>

	Example:
	class CfgSettings { class CBA { class Keys { class sys_attachments { cqb = 33 }; }; }; };

	- Script (in sys_attachments addon (it has COMPONENT defined as sys_attachments)):
	[QUOTE(COMPONENT), "cqb", { _this call GVAR(keyPressed) }] call cba_keys_fAddHandlerFromConfig;
*/
["Initializing...", QUOTE(ADDON), DEBUG_SETTINGS] call CBA_fDebug;

GVAR(actions) = [];
for "_i" from 0 to 250 do
{
	GVAR(actions) set [_i, []];
};

// TODO: Evaluate if functions should be loaded on servers!
PREP(fHandler);
PREP(fAddHandler);
PREP(fAddHandlerFromConfig);
PREP(fReadKeyFromConfig);
