/* ----------------------------------------------------------------------------
Function: CBA_fnc_spawnAttack

Description:
    A function for spawning and commanding a group to attack a location with information
	parsed from a module.

Parameters:
    - Group (Array of Classnames)
	- Spawn Point (XYZ, Object, Location or Marker)
	- Attack Point (XYZ, Object, Location, Group, or Marker)

Optional:
    - Headless Client (Bool)
    - Spawn Radius (Number)
	- Attack Radius (Number)

Example:
    (begin example)
    [["unit1","unit2",..,"unitN"], true, [0,0,0], getMarkerPos "myMarker"] call CBA_fnc_spawnAttack
    (end)

Returns:
    Nil

Author:
    WiredTiger

---------------------------------------------------------------------------- */

/*#include "script_component.hpp"
SCRIPT(spawnAttack);

params [
    "_logic",
	"_units",
	["_isHeadless",0],
	["_spawnPos",[0,0,0]],
	["_spawnRadius",0],
	["_attackPos",[0,0,0]],
	["_attackRadius",0]
];*/

_logic = param [0,objNull,[objNull]];

/*/Get array if defined otherwise synced units
if (!(_logic getVariable "scriptedUnit" == "")) then {
    _units = _logic getVariable "scriptedUnit";
}else{
    _units = param [1,[],[[]]];
};

_spawnPos = _logic getVariable "";
_spawnRadius = _logic getVariable "";
_attackPos = _logic getVariable "";
_attackRadius = _logic getVariable "";

//Spawn units on headless client otherwise server
if (_logic getVariable "headlessClient" == 0) then {
    //spawn on server
}else{
    //spawn on headless client
};*/

myVar1 = _logic;
//myVar2 = _units;


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

