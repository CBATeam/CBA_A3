#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getAreaTerrainGrid

Description:
    Returns all terrain points in the specified area

Parameters:
    _area - the area to get the terrain points within [
        TRIGGER, 
        MARKER, 
        LOCATION, 
        ARRAY in format [center, distance] or [center, [a, b, angle, rect]] or [center, [a, b, angle, rect, height]]
    ]
    see https://community.bistudio.com/wiki/BIS_fnc_getArea

Returns:
    Array of positions [[x1,y1,z1], [x2,y2,z2]...] [ARRAY]

Examples:
    (begin example)
        _allPoints = "marker1" call CBA_fnc_getAreaTerrainGrid;
    (end)

Author:
    Seb
---------------------------------------------------------------------------- */

private _areaArg = _this;

getTerrainInfo params ["", "", "_cellSize", "_resolution", ""];
private _area = _areaArg call BIS_fnc_getArea;
_area set [5, -1]; // Ignore Z value from objects/markers
private _centre = (_area#0) select [0,2];

// Get all points that lie within a rectangle guaranteed to contain the entire area
private _boundarySize = ((_area#1) max (_area#2)) * 1.42;
private _numCells = ceil (2*_boundarySize/_cellSize);
_centre apply {floor ((_x-_boundarySize)/_cellSize)} params ["_cellX", "_cellY"];
private _minX = _cellX max 0;
private _minY = _cellY max 0;
private _maxX = (_cellX + _numCells) min _resolution;
private _maxY = (_cellY + _numCells) min _resolution;
private _positionsAndHeights = [];
for "_cx" from _minX to _maxX do {
    for "_cy" from _minY to _maxY do {
        _positionsAndHeights pushBack ([_cx, _cy, 0] vectorMultiply _cellSize);
    };
};

// Filter list to points actually within the area
_positionsAndHeights = (_positionsAndHeights inAreaArray _area);
{
    _x set [2, getTerrainHeight _x]
} forEach _positionsAndHeights;

_positionsAndHeights
