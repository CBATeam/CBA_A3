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

#include "script_component.hpp"
SCRIPT(spawnAttack);

private ["_logic"];

_logic = _this select 0;
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

