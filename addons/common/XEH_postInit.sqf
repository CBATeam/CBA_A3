// #define DEBUG_MODE_FULL
#include "script_component.hpp"

LOG(MSG_INIT);

// NOTE: Due to the way the BIS functions initializations work, and the requirement of BIS_functions_mainscope to be a unit (in a group)
//       the logic is created locally on MP dedicated client, to still allow this early, called precompilation of the functions.
//       But initialization doesn't officially finish until the official (server created / mission.sqm included) logic is available.
//		 In SP or as server (dedicated or clientServer), the logic is created with group and createUnit.
private ["_group", "_logic"];
if (isNil "BIS_functions_mainscope") then
{
	if (SLX_XEH_MACHINE select 3) then
	{
		// CREATE_CENTER sideLogic; // Handled in function
		_group = [sideLogic] call CBA_fnc_getSharedGroup;
		_logic = _group createUnit ["FunctionsManager", [0,0,0], [], 0, "none"];
		TRACE_2("Created FunctionsManager Logic",_group,_logic);
	} else {
		// TODO: Evaluate cleanup for this one
		_logic = "LOGIC" createVehicleLocal [0, 0];
		TRACE_1("Created FunctionsManager Logic (local)",_logic);
	};
} else {
	_logic = BIS_functions_mainscope;
	TRACE_1("Using already available BIS_functions_mainscope",_logic);
};

CBA_logic = _logic;

if (isNil "RE" && isNil "BIS_MPF_logic") then
{
	LOG("Initialising the MP module early.");
	_this call compile preprocessFileLineNumbers "\ca\Modules\MP\data\scripts\MPframework.sqf";
};

// A2 / Operation Arrowhead, standalone / combined operations check
TRACE_1("OA Check",nil);
private ["_hasCbaOa", "_hasCbaA2", "_hasA2", "_hasOa"];
_hasCbaA2 = isClass(configFile >> "CfgMods" >> "CBA_A2");
_hasCbaOa = isClass(configFile >> "CfgMods" >> "CBA_OA");
_hasA2 = isClass(configFile >> "CfgPatches" >> "Chernarus");
_hasOa = isClass(configFile >> "CfgPatches" >> "Takistan");

if (_hasA2 && _hasCbaOa) then { (localize "STR_CBA_COMMON_OA_CO_HAS_CBA_OA") spawn FUNC(log) };
if (!_hasA2 && !_hasCbaOa) then { (localize "STR_CBA_COMMON_OA_ST_NO_CBA_OA") spawn FUNC(log) };

if (_hasOa && _hasCbaA2) then { (localize "STR_CBA_COMMON_OA_HAS_CBA_A2") spawn FUNC(log) };
if (!_hasOa && !_hasCbaA2) then { (localize "STR_CBA_COMMON_A2_ST_NO_CBA_A2") spawn FUNC(log) };

// Upgrade check - Registry for removed addons, warn the user if found
// TODO: Evaluate registry of 'current addons' and verifying that against available CfgPatches
TRACE_1("Upgrade Check",nil);
#define CFG configFile >> "CfgSettings" >> "CBA" >> "registry"
private ["_entry"];
for "_i" from 0 to ((count (CFG)) - 1) do {
	_entry = (CFG) select _i;
	if (isClass(_entry)) then {
		if (isArray(_entry >> "removed")) then {
			{
				if (isClass(configFile >> "CfgPatches" >> _x)) then {
					format["WARNING: Found addon that should be removed: %1; Please remove and restart game", _x] spawn FUNC(log);
				};
			} forEach (getArray(_entry >> "removed"));
		};
	};
};
