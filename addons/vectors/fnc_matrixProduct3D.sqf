/* ----------------------------------------------------------------------------
Function: CBA_fnc_matrixProduct3D

Description:
   Returns the resulting matrix from the matrix-matrix product.

   Only accepts a 3x3 matrices.

Parameters:
    _matrixA       - first 3x3 matrix. <ARRAY>
    _matrixB       - second 3x3 matrix. <ARRAY>

Returns:
     _returnMatrix - 3x3 matrix returned after matrix multiplication <ARRAY>

Examples:
    (begin example)
    // point reflection at origin [0,0,0] for every vector in matrix B
    [[[-1,0,0],[0,-1,0],[0,0,-1]], [[1,2,3], [3,1,2], [2,3,1]]] call CBA_fnc_matrixProduct3D;
    (end)

Author:
    Kex
---------------------------------------------------------------------------- */

#include "script_component.hpp"

params [["_matrixA", [], [[]], 3], ["_matrixB", [], [[]], 3]];

_matrixB = [_matrixB] call CBA_fnc_matrixTranspose;

private _returnMatrix = [];
for "_i" from 0 to (count _matrixA -1) do
{
    private _returnRow = [];
    private _rowA = _matrixA select _i;
	  for "_j" from 0 to (count _matrixB -1) do
	  {
	      _returnRow pushBack (_rowA vectorDotProduct ( _matrixB select _j));
	  };
	  _returnMatrix pushBack _returnRow;
};
_returnMatrix;
