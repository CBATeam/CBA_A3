/* ----------------------------------------------------------------------------
Function: CBA_fnc_moduleAttack

Description:
    A function for spawning and commanding a group to attack a parsed location.

Parameters:
    - Group (Group or Object)
    - Position (XYZ, Object, Location or Group)

Optional:
    - Search Radius (Scalar)

Example:
    (begin example)
    [group player, getpos (player findNearestEnemy player), 100] call CBA_fnc_taskAttack
    (end)

Returns:
    Nil

Author:
    WiredTiger

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(moduleAttack);

hint "It works!";