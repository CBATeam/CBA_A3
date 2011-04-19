// #define DEBUG_MODE_FULL
#include "script_component.hpp"
///////////////////////////////////////////////////////////
// ArmA - actionmonitor.sqf v1.0 Original by BN880, converted by Sickboy (sb_at_dev-heaven.net), 6th Sense - Share the Spirit
// THIS IS FOR PLAYER ACTIONS ONLY  CoC Bn880 11/2003
///////////////////////////////////////////////////////////

private ["_actionIndexes", "_veh"];

GVAR(actionList) = [] call CBA_fnc_hashCreate;
GVAR(actionListUpdated) = false; // Set true to force recreation of actions.
GVAR(nextActionIndex) = 0; // Next index that will be given out.

