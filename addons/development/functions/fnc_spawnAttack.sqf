/* ----------------------------------------------------------------------------
Function: CBA_fnc_spawnAttack

Description:
    A function for spawning and commanding a group to attack a location with information
	parsed from a module.

Parameters:
    - Group (Array of Classnames or an array of a config)
	- Spawn Point (XYZ, Object, Location or Marker)
	- Attack Point (XYZ, Object, Location, Group, or Marker)

Optional:
    - Headless Client (Bool)
    - Spawn Radius (Number)
	- Attack Radius (Number)

Example:
    (begin example)
    [["unit1","unit2",..,"unitN"], true, [0,0,0], getMarkerPos "myMarker"] call CBA_fnc_spawnAttack;
    (end)

Returns:
    Nil

Author:
    WiredTiger

---------------------------------------------------------------------------- */

//#include "script_component.hpp"
//SCRIPT(spawnAttack);
#define 100 false
#define 111 true
private ["_logic","_unit"];

_logic = _this select 0;
_headlessClient = _logic getVariable "headlessClient";
_unitType = _logic getVariable "unitType";
_scriptedUnit = _logic getVariable "scriptedUnit";
_unitSide = _logic getVariable "unitSide";
_spawnPosition = _logic getVariable "spawnPosition";
_spawnRadius = _logic getVariable "spawnRadius";
_attackPosition = _logic getVariable "attackPosition";
_attackRadius = _logic getVariable "attackRadius";

// Check where to run the code
if (_headlessClient) then {
    if (!hasInterface && !isServer) exitWith {}; // Works as is
	if (hasInterface || isServer) exitWith {}; //Need to exit whole script
}else{
    if (hasInterface && !isServer) exitWith {}; //Needs to exit whole script
};

switch (_unitType) do {
    case 10: {breakTo "main"};
	case 11: {_unitType = "array"};
	case 12: {_unitType = "config"};
	default {diag_log "_unitType failed"};
};

switch (_unitType) do {
    case "array": {hint "array"};
	case "config": {hint "config"};
	default {diag_log "array vs config failed"}
};

myVar1 = _logic;
myVar2 = 100;

/*
-String of array to array example-
randVar = [myVar1 getVariable "spawnPosition"] call BIS_fnc_parseNumber;
player setPos randVar
*/

/*
-String of any kind to any kind example 2-   (Doesn't work with BOOL)
randVar = call compile (myVar1 getVariable "scriptedUnit");
hint typeName randVar
*/

