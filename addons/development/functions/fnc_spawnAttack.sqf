/* ----------------------------------------------------------------------------
Function: CBA_fnc_spawnAttack

Description:
    A function for spawning and commanding a group to attack a parsed location.

Parameters:
    - Group (Config or Array of Classnames)
    - Headless Client (Bool)
	- Spawn Point (XYZ, Object, Location or Marker)
	- Attack Point (XYZ, Object, Location, Group, or Marker)

Optional:
    - Nil

Example:
    (begin example)
    [(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad"), true, [0,0,0], getMarkerPos "myMarker"] call CBA_fnc_spawnAttack
    (end)

Returns:
    Nil

Author:
    WiredTiger

---------------------------------------------------------------------------- */

//#include "script_component.hpp"
//SCRIPT(moduleAttack);

private ["_logic","_units","_activated","_isHeadless","_spawnPos","_attackPos"];

_logic = param [0,objNull,[objNull]];
_activated = param [2,true,[true]];

if (!(_logic getVariable "scriptedUnit" == "") then {
    _units = _logic getVariable "scriptedUnit";
}else{
    _units = param [1,[],[[]]];
};

myVar1 = _logic;
myVar2 = _units;
myVar3 = _activated;

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

