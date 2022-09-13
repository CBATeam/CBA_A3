#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_chunkOrigin

Description:
    Returns the origin (south-west) corner position of the chunk containing the provided position

Parameters:
    _pos - Position to check the chunk origin of [ARRAY]

Returns:
    The origin position of the chunk containing the provided position. Z is always 0. [ARRAY]

Examples:
    (begin example)
        _origin = [getPos player] call CBA_fnc_chunkOrigin
        systemchat str ["The origin of your chunk is:", _origin]
    (end)

Author:
    Seb
---------------------------------------------------------------------------- */
params ["_pos"];
getTerrainInfo params ["", "", "_cellSize", "_resolution", ""];
private _step = _cellSize*CHUNKSIZE;
private _origin = _pos apply {(floor (_x/_step))*_step};
_origin set [2, 0];
_origin
