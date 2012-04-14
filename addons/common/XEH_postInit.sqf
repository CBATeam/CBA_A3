// #define DEBUG_MODE_FULL
#include "script_component.hpp"

LOG(MSG_INIT);

// if (true) exitWith {};

// NOTE: Due to the way the BIS functions initializations work, and the requirement of BIS_functions_mainscope to be a unit (in a group)
//       the logic is created locally on MP dedicated client, to still allow this early, called precompilation of the functions.
//       But initialization doesn't officially finish until the official (server created / mission.sqm included) logic is available.
//		 In SP or as server (dedicated or clientServer), the logic is created with group and createUnit.
SLX_XEH_STR spawn {
	waitUntil {!isNil "BIS_MPF_InitDone"}; //functions init must be after MPF init
	waitUntil {!isNil "bis_functions_mainscope"};
	BIS_fnc_init = true;
	#ifdef DEBUG_MODE_FULL
		diag_log [diag_frameNo, diag_tickTime, time, "BLA: Function module init true!"];
	#endif
};

private ["_group", "_logic"];
if (isNil "BIS_functions_mainscope") then
{
	if (SLX_XEH_MACHINE select 3) then
	{
		// CREATE_CENTER sideLogic; // Handled in function
		_group = [sideLogic] call CBA_fnc_getSharedGroup;
		_logic = _group createUnit ["FunctionsManager", [0,0,0], [], 0, "none"];
		TRACE_2("Created FunctionsManager Logic",_group,_logic);
		BIS_OO_grpLogic = _group;
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
	_this call COMPILE_FILE2(\ca\Modules\MP\data\scripts\MPframework.sqf);
};
SLX_XEH_STR spawn {
	_done = false;
	while {true} do {
		sleep 1;
		if (typeName nil == "STRING" || str(nil) != "ANY") then {
			if !(CBA_NIL_CHECKED) then { "WARNING: NIL VARIABLE OVERRIDEN; Please fix Mission or loaded addon-scripts" spawn FUNC(log); CBA_NIL_CHECKED = true; };
			nil = CBA_nil select 0; // TODO: This doesn't work properly.. it will at least undefine nil, making the error more apparant, yet not exactly what we want.
		};
	};
};

// A2 / Operation Arrowhead, standalone / combined operations check
TRACE_1("OA Check",nil);
private ["_hasCbaOa", "_hasCbaA2", "_hasA2", "_hasOa"];
_hasCbaA2 = isClass(configFile >> "CfgPatches" >> "CBA_A2_main");
_hasCbaOa = isClass(configFile >> "CfgPatches" >> "CBA_OA_main");
_hasA2 = isClass(configFile >> "CfgPatches" >> "Chernarus");
_hasOa = isClass(configFile >> "CfgPatches" >> "Takistan");

if (_hasA2 && !_hasCbaA2) then { "Running A2 Content but missing @CBA_A2, please install and enable @CBA_A2, or disable A2 content" spawn FUNC(log) };
if (_hasOA && !_hasCbaOA) then { "Running OA Content but missing @CBA_OA, please install and enable @CBA_OA, or disable OA content" spawn FUNC(log) };
if (!_hasA2 && _hasCbaA2) then { "Not Running A2 Content but running @CBA_A2, please disable @CBA_A2 or enable A2 content" spawn FUNC(log) };
if (!_hasOa && _hasCbaOa) then { "Not Running OA Content but running @CBA_OA, please disable @CBA_OA or enable OA content" spawn FUNC(log) };


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

FUNC(initPerFrameHandlers) = {
	7771 cutRsc ["CBA_FrameHandlerTitle", "PLAIN"];

	GVAR(lastFrameRender) = diag_frameNo;
	// Use a trigger, runs every 0.5s, unscheduled execution
	GVAR(perFrameTrigger) = createTrigger["EmptyDetector", [0,0,0]];
	GVAR(perFrameTrigger) setTriggerStatements[QUOTE(call FUNC(monitorFrameRender)), "", ""];
};

// Run the per frame handler init code, bringing up the hidden map control
if !(CBA_MISSION_START) then {
	["CBA_MISSION_START", { SLX_XEH_STR call FUNC(initPerFrameHandlers) }] call CBA_fnc_addEventHandler;
} else {
	SLX_XEH_STR call FUNC(initPerFrameHandlers);
};

if !(isDedicated) then {
	SLX_XEH_STR spawn
	{
		LOG("Action monitor started");
		while { true } do
		{
			// Don't mess around endlessly adding and re-adding to a
			// corpse/destroyed vehicle.
			waitUntil { alive (vehicle player) };
			
			// Add actions to new vehicle.
			_veh = vehicle player;
			_actionIndexes = [];
			[GVAR(actionList), { PUSH(_actionIndexes,_veh addAction _value) }] call CBA_fnc_hashEachPair;
			TRACE_2("Added actions",_veh,count _actionIndexes);
			waitUntil
			{
				sleep 1;
				(vehicle player) != _veh || !(alive player) || GVAR(actionListUpdated)
			};
	
			// Remove actions from previous vehicle.
			GVAR(actionListUpdated) = false;
			{ _veh removeAction _x } foreach _actionIndexes;
	
			TRACE_2("Removed actions",_veh,count _actionIndexes);
	
			sleep 1;
		};
	};
};

// TODO: Consider a waitUntil loop with tickTime check to wait for some frames as opposed to trying to sleep until time > 0. Re MP Briefings etc.
/*
[CBA_COMMON_ADDONS] spawn {
	PARAMS_1(_addons);
	TRACE_1("Activating addons",nil);
	activateAddons _addons;
	sleep 0.001;
	if (SLX_XEH_MACHINE select 1) then { sleep 0.001 }; // JIP, sleep uses time, and time skips for JIP.
	TRACE_1("Activating addons",nil);
	activateAddons _addons;
};
*/
