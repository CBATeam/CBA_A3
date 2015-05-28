/* ----------------------------------------------------------------------------
Function: CBA_fnc_getNearestBuilding

Description:
    A function used to find out the nearest building and appropriate building positions available.

Parameters:
    Object

Example:
    (begin example)
    _array = player call CBA_fnc_getNearestBuilding
    (end)

Returns:
    Array with [building object, building positions (count)]

Author:
    Rommel
---------------------------------------------------------------------------- */

private ["_building", "_i"];

_building = nearestBuilding _this;
_i = 0;

while {str(_building buildingPos _i) != "[0,0,0]"} do {_i = _i + 1;};
[_building, _i]
