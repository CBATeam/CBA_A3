#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_nearestTerrainPoint

Description:
    Given a a coordinate, return the closest terrain point and the Z value of that terrain point

Parameters:
    _pos = position to find the nearest chunk to

Returns:
    positionASL of the nearest terrain point [ARRAY] 

Examples:
    (begin example)
    player setPosASL ([getPos player] call CBA_fnc_nearestTerrainPoint);
    (end)

Author:
    Seb
---------------------------------------------------------------------------- */
params [
    ["_position", [0,0,0], [[]], [2,3]]
];
getTerrainInfo params ["", "", "_cellSize", "_resolution", ""];
private _pos = (_position select [0,2]) apply {
    (round (_x/_cellsize))*_cellSize
};
_pos set [2, getTerrainHeight _pos];
_pos
