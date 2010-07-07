#define DEBUG_MODE_FULL
#include "script_component.hpp"
#define SLEEP(TIME) _i = 0; while {_i < TIME} do { _i = _i + 1; sleep 1 }

TRACE_1("",GVAR(versions));

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
				format["WARNING: %1 requires %2 (@%3) at version %4 (or higher)", _key, _data select 0, _mod, _data select 1] spawn _f;
			} else {
				if !(isArray(_class >> "versionAr")) then {
					format["WARNING: %1 requires %2 (@%3) at version %4 (or higher)", _key, _data select 0, _mod, _data select 1] spawn _f;
				} else {
					if ([_data select 1, getArray(_class >> "versionAr")] call FUNC(version_compare)) then {
						format["WARNING: %1 requires %2 (@%3) at version %4 (or higher). You have: %5", _key, _data select 0, _mod, _data select 1, getArray(_class >> "versionAr")] spawn _f;
					};
				};
			};
		};
	} forEach _value;
}] call CBA_fnc_hashEachPair;


SLEEP(3); // Test workaround for JIP issue

if (isNil QUOTE(GVAR(mismatch))) then { GVAR(mismatch) = [] };

if (isServer) then
{
	// For latest versions
	GVAR(versions_server) = GVAR(versions);
	// For legacy versions
	GVAR(versions_srv) = [[], "0.0.0"] call CBA_fnc_hashCreate;
	[GVAR(versions_server), { _str = [_value select 0, "."] call CBA_fnc_join; [GVAR(versions_srv),_key, _str] call CBA_fnc_hashSet }] call CBA_fnc_hashEachPair;
	publicVariable QUOTE(GVAR(versions_server));
	publicVariable QUOTE(GVAR(versions_srv));

	QUOTE(GVAR(mismatch)) addPublicVariableEventHandler
	{
		private ["_params"];
		_params = _this select 1;
		[format["%1 - Not running! (Machine: %2)", _params select 1, _params select 0], QUOTE(COMPONENT), [true, true, true]] call CBA_fnc_debug;
	};

	private ["_logic", "_str"];
	_logic = ([sideLogic] call CBA_fnc_getSharedGroup) createUnit ["LOGIC", [0,0,0], [], 0, ""];
	_str = 'if(isServer)exitWith{};0 = [] spawn { sleep 1; sleep 1; _func={GVAR(mismatch)=[format["%2 (%1)",name player, player],_this];publicVariable QUOTE(GVAR(mismatch));_this spawn{_t=format["You are missing the following mod: %1",_this];diag_log text _t;sleep 2;player globalChat _t}};';
	[GVAR(versions_server), {_str = _str + format['if !(isClass(configFile >> "CfgPatches" >> "%1_main"))exitWith{"%1_main" call _func};', _key]}] call CBA_fnc_hashEachPair;
	ADD(_str,"};");
	// Actually disconnect em? 
	// endMission "END1"
	_logic setVehicleInit _str;
	processInitCommands;
} else {
	waitUntil {!(isNil QUOTE(GVAR(versions_server)))};
	TRACE_1("",GVAR(versions_server));
	[GVAR(versions_server), {call FUNC(version_check)}] call CBA_fnc_hashEachPair;
};
