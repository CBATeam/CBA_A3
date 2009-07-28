#include "script_component.hpp"

LOG(MSG_INIT);

// Create centers that do not exist yet
// TODO: Evaluate handling this in some createGroup function instead of creating them all?
#define CREATE_CENTER _center = createCenter

{
	/*
	private ["_group", "_center"];
	_group = [_x] call CBA_fnc_getSharedGroup;
	if (isNil "_group") then
	{
		CREATE_CENTER _x;
		_group = [_x] call CBA_fnc_getSharedGroup;
	} else {
		if (isNull _group) then { CREATE_CENTER _x; _group = [_x] call CBA_fnc_getSharedGroup };
	};
	deleteGroup _group;
	*/

	CREATE_CENTER _x;
} forEach [east, west, resistance, civilian, sideLogic];


// NOTE: Due to the way the BIS functions initializations work, and the requirement of BIS_functions_mainscope to be a unit (in a group)
//       the logic is created locally on MP dedicated client, to still allow this early, called precompilation of the functions.
//       But initialization doesn't officially finish until the official (server created / mission.sqm included) logic is available.
//		 In SP or as server (dedicated or clientServer), the logic is created with group and createUnit.
private ["_group", "_logic"];
if (isNil "BIS_functions_mainscope") then
{
	if (isServer) then
	{
/*
		_group = [sideLogic] call CBA_fnc_getSharedGroup;
		if (isNil "_group") then
		{
			CREATE_CENTER sideLogic;
			_group = [sideLogic] call CBA_fnc_getSharedGroup;
		} else {
			if (isNull _group) then { CREATE_CENTER sideLogic; _group = [sideLogic] call CBA_fnc_getSharedGroup };
		};
*/
		// CREATE_CENTER sideLogic; // Handled above
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
