#define MESSAGE "ERROR: You seem to be an Operation Arrowhead Standalone user, but have not loaded @CBA_OA modfolder! Please restart the game with the mod."
#define MESSAGE2 "ERROR: You seem to be an A2: Operation Arrowhead Combined Operations user, but have loaded the @CBA_OA modfolder! Please restart the game without the mod."
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

if (isnil "RE") then
{
	LOG("Initialising the MP module early.");
	_this call compile preprocessFileLineNumbers "\ca\Modules\MP\data\scripts\MPframework.sqf";
};

FUNC(log) = {
		diag_log text _this;
		sleep 1;
		BIS_functions_mainscope globalChat _this;
		hintC _this;
};

// Nil check
[] spawn {
	_done = false;
	while {true} do {
		if (typeName nil == "STRING" || str(nil) != "ANY") then {
			if !(_done) then { "WARNING: NIL VARIABLE OVERRIDEN; Please fix Mission or loaded addon-scripts" spawn FUNC(log); _done = true; };
			nil = CBA_nil select 0; // TODO: This doesn't work properly.. it will at least undefine nil, making the error more apparant, yet not exactly what we want.
		};
		sleep 1;
	};
};

// A2 / Operation Arrowhead, standalone / combined operations check
private ["_hasCbaOa", "_hasA2"];
_hasCbaOa = isClass(configFile >> "CfgMods" >> "CBA_OA");
_hasA2 = isClass(configFile >> "CfgPatches" >> "Chernarus");

if (_hasA2 && _hasCbaOa) then { MESSAGE2 spawn FUNC(log) };
if (!_hasA2 && !_hasCbaOa) then { MESSAGE spawn FUNC(log) };

// Upgrade check - Registry for removed addons, warn the user if found
// TODO: Evaluate registry of 'current addons' and verifying that against available CfgPatches
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
