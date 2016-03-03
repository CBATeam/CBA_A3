/* ----------------------------------------------------------------------------
Function: CBA_fnc_getNearestBuilding

Description:
    A function used to find out the nearest building and appropriate building positions available.

Parameters:
    _position - <OBJECT, POSITION>

Example:
    (begin example)
        _array = player call CBA_fnc_getNearestBuilding
    (end)

Returns:
    Array with [building object, building positions (count)]

Author:
    Rommel
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(getNearestBuilding);

[_this] params [["_position", objNull, [objNull, []]]];

private _building = nearestBuilding _position;

[_building, count (_building buildingPos -1)]
