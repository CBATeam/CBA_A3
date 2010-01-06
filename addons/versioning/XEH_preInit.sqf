#define DEBUG_MODE_FULL
#include "script_component.hpp"
SCRIPT(XEH_preInit);
/*
	Basic, Generic Version Checking System - By Sickboy <sb_at_dev-heaven.net>

*/
LOG(MSG_INIT);
ADDON = false;

GVAR(versions) = [[], "0.00"] call CBA_fnc_hashCreate;

FUNC(version_check) =
{
	private ["_localVersion"]; // _key, _value  are injected by the CBA_fnc_hashEachPair
	_localVersion = [GVAR(versions), _key] call CBA_fnc_hashGet;
	if (_localVersion != _value) then
	{
		// Default version mismatch handling, broadcast to all!
		[format["%1 - Version Mismatch! (Machine: %2, Server: %3, Local: %4)", _key, player, _value, _localVersion], QUOTE(COMPONENT), [true, true, true]] call CBA_fnc_debug;

		// Allow custom handler
		if (isText ((CFGSETTINGS) >> _key >> "handler")) then
		{
			// TODO: PreCompile and spawn from Hash or so?
			[_value, _localVersion, player] spawn (call compile getText((CFGSETTINGS) >> _key >> "handler"));
		};
		// Actually disconnect em? 
		// endMission "END1"
	};
};

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

ADDON = true;
