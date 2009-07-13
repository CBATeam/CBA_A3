#include "script_component.hpp"
///////////////////////////////////////////////////////////
// ArmA - actionmonitor.sqf v1.0 Original by BN880, converted by Sickboy (sb_at_dev-heaven.net), 6th Sense - Share the Spirit
// THIS IS FOR PLAYER ACTIONS ONLY  CoC Bn880 11/2003
///////////////////////////////////////////////////////////
private ["_actionIndexes", "_veh"];

GVAR(actionList) = call CBA_fnc_hashCreate;
GVAR(actionListUpdated) = false; // Set true to force recreation of actions.
GVAR(nextActionIndex) = 0; // Next index that will be given out.

LOG("Action monitor started");

[] spawn
{
	while { true } do
	{
		// Don't mess around endlessly adding and re-adding to a 
		// corpse/destroyed vehicle.
		waitUntil { alive (vehicle player) };
		
		// Add actions to new vehicle.
		_veh = vehicle player;
		_actionIndexes = [];
		[GVAR(actionList), { PUSH(_actionIndexes,_veh addAction _value) }] call
			CBA_fnc_hashEachPair;
			
		TRACE_2("Added actions",_veh,count _actionIndexes);
		
		waitUntil
		{
			(vehicle player) != _veh || !(alive player) || GVAR(actionListUpdated)
		};
		
		// Remove actions from previous vehicle.
		GVAR(actionListUpdated) = false;
		{ _veh removeAction _x } foreach _actionIndexes;
		
		TRACE_2("Removed actions",_veh,count _actionIndexes);
		
		sleep 1;
	};
};

nil;

