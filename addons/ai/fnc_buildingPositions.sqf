#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_buildingPositions

Description:
    Reports positions of the building including nearby custom building positions.

Parameters:
    0: _building - The building. <OBJECT>
    1: _max      - Maximum number of positions. (optional, default: all) <NUMBER>

Example:
    (begin example)
        [_building, _maxNumberOfPositions] call CBA_fnc_buildingPositions
    (end)

Returns:
    Available building positions including custom positions <ARRAY <PosAGL>>

Author:
    commy2
---------------------------------------------------------------------------- */

params [["_building", objNull, [objNull]], ["_max", -1, [0]]];

private _availablePositions = _building buildingPos -1;

// add nearby custom building positions
(0 boundingBoxReal _building) params ["_pos1", "_pos2", "_diameter"];
_pos1 params ["_x1", "_y1", "_z1"];
_pos2 params ["_x2", "_y2", "_z2"];

private _polygonTop = [
    [_x1, _y1, 0],
    [_x2, _y1, 0],
    [_x2, _y2, 0],
    [_x1, _y2, 0]
];

private _polygonSide = [
    [_x1, _z1, 0],
    [_x2, _z1, 0],
    [_x2, _z2, 0],
    [_x1, _z2, 0]
];

private _customPositions = nearestObjects [_building, ["CBA_buildingPos"], _diameter, true] apply {
    _x buildingPos 0
} select {
    private _customPositionTop = _building worldToModel _x;
    private _customPositionSide = +_customPositionTop;
    _customPositionSide pushBack (_customPositionSide deleteAt 1); // swap y and z

    _customPositionTop inPolygon _polygonTop && _customPositionSide inPolygon _polygonSide
};

_availablePositions append _customPositions;

if (_max >= 0) then {
    _availablePositions resize (_max min count _availablePositions);
};

_availablePositions
