/* ----------------------------------------------------------------------------
Function: CBA_fnc_matrixTranspose

Description:
   Returns the transposed matrix.

   Accepts any mxn matrix.

Parameters:
    _matrix        - mxn matrix to transpose. <ARRAY>

Returns:
     _returnMatrix - nxm matrix <ARRAY>

Examples:
    (begin example)
    // returns the transposed matrix [[1,3,2], [2,1,3], [3,2,1]]
    [[[1,2,3], [3,1,2], [2,3,1]]] call CBA_fnc_matrixTranspose;
    (end)

Author:
    Kyle Kotowick, Kex
---------------------------------------------------------------------------- */

#include "script_component.hpp"

params [["_matrix", [], [[]]]];

private _m = count _matrix;
private _n = count (_matrix select 0);

private _returnMatrix = [];

for "_j" from 0 to (_n - 1) do
{
    private _returnRow = [];
    for "_i" from 0 to (_m - 1) do
    {
        _returnRow pushBack ((_matrix select _i) select _j);
    };
    _returnMatrix pushBack _returnRow;
};

_returnMatrix;
