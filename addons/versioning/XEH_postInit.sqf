#include "script_component.hpp"
SCRIPT(XEH_postInit);

/*
	Basic, Generic Version Checking System - By Sickboy <sb_at_dev-heaven.net>
*/

if (!XEH_DisableLogging) then
{
	diag_log [diag_frameNo, diag_tickTime, time, "CBA_VERSIONING", GVAR(versions)];
};

// Depency check and warn
[GVAR(dependencies), {
	private ["_mod", "_data", "_class", "_f"];
	_f = {
		diag_log text _this;
		sleep 1;
		BIS_functions_mainscope globalChat _this;
	};
	{
		_mod = _x select 0;
		_data = _x select 1;
		_class = (configFile >> "CfgPatches" >> (_data select 0));
		if (call compile(_data select 2)) then {
			if !(isClass(_class)) then {
				format["WARNING: %1 requires %2 (@%3) at version %4 (or higher). You have none.", _key, _data select 0, _mod, _data select 1] spawn _f;
			} else {
				if !(isArray(_class >> "versionAr")) then {
					format["WARNING: %1 requires %2 (@%3) at version %4 (or higher). No valid verion info found.", _key, _data select 0, _mod, _data select 1] spawn _f;
				} else {
					if ([_data select 1, getArray(_class >> "versionAr")] call FUNC(version_compare)) then {
						format["WARNING: %1 requires %2 (@%3) at version %4 (or higher). You have: %5", _key, _data select 0, _mod, _data select 1, getArray(_class >> "versionAr")] spawn _f;
					};
				};
			};
		};
	} forEach _value;
}] call CBA_fnc_hashEachPair;
