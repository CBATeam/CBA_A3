#define DEBUG_MODE_FULL
#include "script_component.hpp"
SCRIPT(XEH_postInit);
LOG(MSG_INIT);

#define SLEEP(TIME) _i = 0; while {_i < TIME} do { _i = _i + 1; sleep 1 }
/*
	Basic, Generic Version Checking System - By Sickboy <sb_at_dev-heaven.net>
*/

[] spawn
{
	TRACE_3("",isServer,GVAR(versions),GVAR(versions_srv));
	SLEEP(4); // Test workaround for JIP issue
	TRACE_3("",isServer,GVAR(versions),GVAR(versions_srv));
	
	if (isNil QUOTE(GVAR(mismatch))) then { GVAR(mismatch) = [] };
	
	if (isServer) then
	{
		GVAR(versions_srv) = GVAR(versions);
		publicVariable QUOTE(GVAR(versions_srv));
		QUOTE(GVAR(mismatch)) addPublicVariableEventHandler
		{
			private ["_params"];
			_params = _this select 1;
			[format["%1 - Not running! (Machine: %2)", _params select 1, _params select 0], QUOTE(COMPONENT), [true, true, true]] call CBA_fnc_debug;
		};
		private ["_logic", "_str"];
		_logic = ([sideLogic] call CBA_fnc_getSharedGroup) createUnit ["LOGIC", [0,0,0], [], 0, ""];
		_str = 'if(isServer)exitWith{};_func={GVAR(mismatch)=[format["%1",player],_this];publicVariable QUOTE(GVAR(mismatch));_this spawn{_t=format["You are missing the following mod: %1",_this];diag_log text _t;sleep 2;player globalChat _t}};';
		[GVAR(versions_srv), {_str = _str + format['if !(isClass(configFile >> "CfgPatches" >> "%1_main"))exitWith{"%1_main" call _func};', _key]}] call CBA_fnc_hashEachPair;
		// Actually disconnect em? 
		// endMission "END1"
		_logic setVehicleInit _str;
		processInitCommands;
	} else {
		waitUntil {!(isNil QUOTE(GVAR(versions_srv)))};
		[GVAR(versions_srv), {_this call FUNC(version_check)}] call CBA_fnc_hashEachPair;
	};
};
