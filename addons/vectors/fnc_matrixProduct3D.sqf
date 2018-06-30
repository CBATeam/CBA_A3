#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_matrixProduct3D

Description:
    Returns the resulting matrix from the matrix-matrix product.

    Only accepts 3x3 matrices.

Parameters:
    _matrixA      - first 3x3 matrix. <ARRAY>
    _matrixB      - second 3x3 matrix. <ARRAY>

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

params [["_matrixA", [], [[]], 3], ["_matrixB", [], [[]], 3]];

_matrixB = [_matrixB] call CBA_fnc_matrixTranspose;
_matrixA apply {
    private _rowA = _x; 
    _matrixB apply {_rowA vectorDotProduct _x}
} // return
