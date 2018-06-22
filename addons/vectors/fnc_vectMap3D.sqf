/* ----------------------------------------------------------------------------
Function: CBA_fnc_vectMap3D

Description:
    Returns the resulting vector of the product matrix-vector product.

    Only accepts a 3x3 matrices and 3D vector.

Parameters:
    _matrix       - 3x3 matrix, which serves as a map. <ARRAY>
    _vector       - 3D vector that is mapped. <ARRAY>

Returns:
    _returnVector - 3D vector returned after matrix multiplication <ARRAY>

Examples:
    (begin example)
    // point reflection at origin [0,0,0]
    [[[-1,0,0],[0,-1,0],[0,0,-1]], [1,2,3]] call CBA_fnc_vectMap3D;
    (end)

Author:
    Kex
---------------------------------------------------------------------------- */

#include "script_component.hpp"

params[["_matrix", [], [[]], 3], ["_vector", [], [[]], 3]];
_matrix apply {_x vectorDotProduct _vector};
