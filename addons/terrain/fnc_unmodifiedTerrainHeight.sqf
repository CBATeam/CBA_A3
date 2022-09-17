#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_unmodifiedTerrainHeight

Description:
    Given a a coordinate, return the original Z value of the nearest terrain point.
    Note that if the terrain was modified through a non-CBA function before this is called, it will 
    be returned as the original terrain height.

Parameters:
    _pos = position to find the nearest unmodified terrain hieght [ARRAY]

Returns:
    positionASL of the nearest terrain point at its pre-modification height [ARRAY] 

Examples:
    (begin example)
        player setPosASL ([getPos player] call CBA_fnc_unmodifiedTerrainHeight);
    (end)

Author:
    Seb
---------------------------------------------------------------------------- */
params ["_pos"];
getTerrainInfo params ["", "", "_cellSize", "_resolution", ""];
_pos = [_pos] call CBA_fnc_nearestTerrainPoint;
private _chunkOrigin = [_pos] call FUNC(chunkOrigin);
private _key = str _chunkOrigin;
private _chunk = GVAR(originalTerrainChunks) get _key;
if (isNil "_chunk") then {
    _chunk = [_chunkOrigin] call FUNC(getChunk);
};
private _inChunk = _pos vectorDiff _chunkOrigin;
(_inChunk select [0,2]) apply {_x/_cellSize} params ["_indexX", "_indexY"];
(_chunk#(_indexX*CHUNKSIZE + _indexY))
