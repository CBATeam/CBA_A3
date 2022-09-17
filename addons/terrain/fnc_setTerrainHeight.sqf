#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_setTerrainHeight

Description:
    Replicate functionality of setTerrainHeight command, but internally split the provided set of 
    positions up into 'chunks' and save the resulting changes for save serialisation/deserialisation

Parameters:
    _positionsAndHeights - array of [[x1,y1,z1], [x2,y2,z2]...]  [ARRAY]
    _adjustObjects - if true then objects on modified points are moved up/down to keep the same ATL height  [BOOL]

Returns:
    Whether the terrain was successfully edited [BOOL];

Examples:
    (begin example)
    [
        [
            [1000, 1000, 25], 
            [1005, 1000, 25], 
            [1000, 1005, 25], 
            [1005, 1005, 25]
        ],
        true
    ] call CBA_fnc_setTerrainHeight;
    (end)

Author:
    Seb
---------------------------------------------------------------------------- */
params [
    ["_positionsAndHeights", [], [[]]],
    ["_adjustObjects", true, [true]]
];
if !(isServer) exitWith {false};
private _chunksData = [_positionsAndHeights] call FUNC(positionsAndHeightsToChunks);
{
    private _key = _x;
    private _chunkPositionsAndHeights = _y;
    setTerrainHeight [_chunkPositionsAndHeights, _adjustObjects];
    GVAR(modifiedTerrainChunks) set [_key, +[_chunkPositionsAndHeights, _adjustObjects]];
} forEach _chunksData;
true
