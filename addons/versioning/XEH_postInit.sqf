#include "script_component.hpp"
SCRIPT(XEH_preInit);

ADDON = false;

GVAR(versions) = [[], "0.00"] call CBA_fnc_hashCreate;

#define __version configFile >> "CfgPatches" >> QUOTE(DOUBLES(configName _prefix,main)) >> "versionstr"

private ["_prefix", "_version"];
for "_i" from 0 to (count (CFGSETTINGS) - 1) do
{
	_prefix = (CFGSETTINGS) select _i;
	if (isClass _prefix) then
	{
		_version = if (isText(__version)) then { getText(__version) } else { "0.00" };
		[GVAR(versions), configName _prefix, _version] call CBA_fnc_hashSet;
	};
};

#define SLEEP(TIME) _i = 0; while {_i < TIME} do { _i = _i + 1; sleep 1 }

[] spawn
{
	TRACE_3("",isServer,GVAR(versions),GVAR(versions_srv));
	SLEEP(4); // Test workaround for JIP issue
	TRACE_3("",isServer,GVAR(versions),GVAR(versions_srv));
	
	if (isServer) then
	{
		GVAR(versions_srv) = GVAR(versions);
		publicVariable QUOTE(GVAR(versions_srv));
	};
};

// Announce initialization complete
ADDON = true;
