#define DEBUG_MODE_FULL
#include "script_component.hpp"
SCRIPT(XEH_preInit);
/*
	Basic, Generic Version Checking System - By Sickboy <sb_at_dev-heaven.net>

*/
LOG(MSG_INIT);
ADDON = false;

// Build versions hash
GVAR(versions) = [[], "0.00"] call CBA_fnc_hashCreate;
private ["_prefix", "_version", "_verCfg"];
for "_i" from 0 to (count (CFGSETTINGS) - 1) do
{
	_prefix = (CFGSETTINGS) select _i;
	if (isClass _prefix) then
	{
		_verCfg = (configFile >> "CfgPatches" >> format["%1_main", configName _prefix] >> "versionstr");
		_version = if (isText(_verCfg)) then { getText(_verCfg) } else { "0.00" };
		[GVAR(versions), configName _prefix, _version] call CBA_fnc_hashSet;
	};
};

PREP(version_check);

ADDON = true;
