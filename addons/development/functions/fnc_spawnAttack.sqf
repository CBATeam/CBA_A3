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

#include "script_component.hpp"
SCRIPT(moduleAttack);

params [];