#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_terrain_fnc_getChunk

Description:
    Given a a coordinate, return all terrain points in the chunk containing the coordinate. 

Parameters:
    _pos = Position inside chunk [ARRAY]

Returns:
    Array of positions [[x1,y1,z1], [x2,y2,z2]...] [ARRAY]

Examples:
    (begin example)
    private _chunkData = [getPos player] call CBA_terrain_fnc_getChunk;
    (end)

Author:
    Seb
---------------------------------------------------------------------------- */
params [
    ["_pos", [0,0,0], [[]], [2,3]]
];
_pos = [_pos] call FUNC(chunkOrigin);
getTerrainInfo params ["", "", "_cellSize", "_resolution", ""];
private _chunkPositionsAndHeights = [];
for "_cellX" from 0 to CHUNKSIZE - 1 do {
    for "_cellY" from 0 to CHUNKSIZE - 1 do {
        private _coordPos = _pos vectorAdd ([_cellX, _cellY, 0] vectorMultiply _cellSize);
        _coordPos set [2, getTerrainHeight _coordPos];
        _chunkPositionsAndHeights pushBack _coordPos;
    };
};
// If this is the first time getting this chunk, save original terrain.
private _key = str _pos;
if (isServer && {!(_key in GVAR(originalTerrainChunks))}) then {
    GVAR(originalTerrainChunks) set [_key, +_chunkPositionsAndHeights];
};

_chunkPositionsAndHeights
