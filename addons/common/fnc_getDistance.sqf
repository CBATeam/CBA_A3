/* ----------------------------------------------------------------------------
Function: CBA_fnc_getDistance

Description:
    A function used to find out the distance between two positions.

Parameters:
    Array containing two of <MARKER, OBJECT, LOCATION, GROUP, TASK, POSITION>

Example:
    (begin example)
    _distance = [Player, [0, 0, 0]] call CBA_fnc_getDistance
    (end)

Returns:
    Number - Distance in meters

Author:
    Rommel
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(getDistance);

params [
    ["_entity1", objNull, [objNull, grpNull, "", locationNull, taskNull, []]],
    ["_entity2", objNull, [objNull, grpNull, "", locationNull, taskNull, []]]
];

(_entity1 call CBA_fnc_getPos) distance (_entity2 call CBA_fnc_getPos)
