// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL
#include "script_component.hpp"

SCRIPT(test_vectors);

//Need custom func to compare vectors to handle floating point errors
private _fnc_vectorEquals = {
    params ["_vector1", "_vector2"];
    if ((isNil "_vector1") || {isNil "_vector2"}) exitWith {false};
    if (!(_vector1 isEqualTypeArray _vector2)) exitWith {false};
    if ((count _vector1) != (count _vector2)) exitWith {false};
    private _equal = true;
    {
        if ((abs (_x - (_vector2 select _forEachIndex))) > 0.00001) exitWith {
            _equal = false;
        };
    } forEach _vector1;
    _equal
};

//Need custom func to compare matrices to handle floating point errors
private _fnc_matrixEquals = {
    params ["_matrix1", "_matrix2"];
    if ((isNil "_matrix1") || {isNil "_matrix2"}) exitWith {false};
    if (!(_matrix1 isEqualTypeArray _matrix2)) exitWith {false};
    if ((count _matrix1) != (count _matrix2)) exitWith {false};
    private _equal = true;
    {
        if !([ARR_2(_x,_matrix2 select _forEachIndex)] call _fnc_vectorEquals) exitWith {
            _equal = false;
        };
    } forEach _matrix1;
    _equal
};

// ----------------------------------------------------------------------------

LOG('Testing Vectors');

// UNIT TESTS (polar2vect)
private _fn = "CBA_fnc_polar2vect";
TEST_DEFINED("CBA_fnc_polar2vect","");

private _result = [0,0,0] call CBA_fnc_polar2vect;
private _expected = [0,0,0];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [1,0,0] call CBA_fnc_polar2vect;
_expected = [0,1,0];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [5,90,0] call CBA_fnc_polar2vect;
_expected = [5,0,0];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [1,0,90] call CBA_fnc_polar2vect;
_expected = [0,0,1];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);


// UNIT TESTS (scaleVect)
_fn = "CBA_fnc_scaleVect";
TEST_DEFINED("CBA_fnc_scaleVect","");

_result = [[1,2,3], 0] call CBA_fnc_scaleVect;
_expected = [0,0,0];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [[1,2,3], 1] call CBA_fnc_scaleVect;
_expected = [1,2,3];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [[1,2,3], 2] call CBA_fnc_scaleVect;
_expected = [2,4,6];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);


// UNIT TESTS (scaleVectTo)
_fn = "CBA_fnc_scaleVectTo";
TEST_DEFINED("CBA_fnc_scaleVectTo","");

_result = [[1,0,0], 0] call CBA_fnc_scaleVectTo;
_expected = [0,0,0];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [[0,1,0], 1] call CBA_fnc_scaleVectTo;
_expected = [0,1,0];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [[0,0,1], 2] call CBA_fnc_scaleVectTo;
_expected = [0,0,2];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [[1, -2, 3], -3] call CBA_fnc_scaleVectTo;
_expected = [-0.801784,1.60357,-2.40535];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);


// UNIT TESTS (simplifyAngle)
_fn = "CBA_fnc_simplifyAngle";
TEST_DEFINED("CBA_fnc_simplifyAngle","");

_result = [0] call CBA_fnc_simplifyAngle;
_expected = 0;
TEST_DEFINED_AND_OP(_result,==,_expected,_fn);

_result = [3601] call CBA_fnc_simplifyAngle;
_expected = 1;
TEST_DEFINED_AND_OP(_result,==,_expected,_fn);

_result = [-1] call CBA_fnc_simplifyAngle;
_expected = 359;
TEST_DEFINED_AND_OP(_result,==,_expected,_fn);


// UNIT TESTS (simplifyAngle180)
_fn = "CBA_fnc_simplifyAngle180";
TEST_DEFINED("CBA_fnc_simplifyAngle180","");

_result = [0] call CBA_fnc_simplifyAngle180;
_expected = 0;
TEST_DEFINED_AND_OP(_result,==,_expected,_fn);

_result = [3601] call CBA_fnc_simplifyAngle180;
_expected = 1;
TEST_DEFINED_AND_OP(_result,==,_expected,_fn);

_result = [-1] call CBA_fnc_simplifyAngle180;
_expected = -1;
TEST_DEFINED_AND_OP(_result,==,_expected,_fn);


// UNIT TESTS (vect2polar)
_fn = "CBA_fnc_vect2Polar";
TEST_DEFINED("CBA_fnc_vect2Polar","");

_result = [0,0,0] call CBA_fnc_vect2Polar;
_expected = [0,0,0];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [0,1,0] call CBA_fnc_vect2Polar;
_expected = [1,0,0];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [0,5,0] call CBA_fnc_vect2Polar;
_expected = [5,0,0];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [0,0,1] call CBA_fnc_vect2Polar;
_expected = [1,0,90];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);


// UNIT TESTS (vectAdd)
// just a wrapper for a bis func
_fn = "CBA_fnc_vectAdd";
TEST_DEFINED("CBA_fnc_vectAdd","");

_result = [[1,2],[3,4]] call CBA_fnc_vectAdd;
_expected = [4,6];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [[-1,-2,-3],[3,4,5]] call CBA_fnc_vectAdd;
_expected = [2,2,2];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);


// UNIT TESTS (vectCross)
// just a wrapper for a bis func
_fn = "CBA_fnc_vectCross";
TEST_DEFINED("CBA_fnc_vectCross","");

_result = [[-1,-2,-3],[3,4,5]] call CBA_fnc_vectCross;
_expected = [2,-4,2];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);


// UNIT TESTS (vectCross2D)
_fn = "CBA_fnc_vectCross2D";
TEST_DEFINED("CBA_fnc_vectCross2D","");

_result = [[-1,-2],[3,4]] call CBA_fnc_vectCross2D;
_expected = 2;
TEST_DEFINED_AND_OP(_result,==,_expected,_fn);


// UNIT TESTS (vectCross2D)
_fn = "CBA_fnc_vectDir";
TEST_DEFINED("CBA_fnc_vectDir","");

_result = [0,1] call CBA_fnc_vectDir;
_expected = 0;
TEST_DEFINED_AND_OP(_result,==,_expected,_fn);

_result = [-1,0] call CBA_fnc_vectDir;
_expected = 270;
TEST_DEFINED_AND_OP(_result,==,_expected,_fn);


// UNIT TESTS (vectDot)
_fn = "CBA_fnc_vectDot";
TEST_DEFINED("CBA_fnc_vectDot","");

_result = [[1,2],[3,4]] call CBA_fnc_vectDot;
_expected = 11;
TEST_DEFINED_AND_OP(_result,==,_expected,_fn);

_result = [[-1,-2,-3],[3,4,5]] call CBA_fnc_vectDot;
_expected = -26;
TEST_DEFINED_AND_OP(_result,==,_expected,_fn);


// UNIT TESTS (vectElev)
_fn = "CBA_fnc_vectElev";
TEST_DEFINED("CBA_fnc_vectElev","");

_result = [0,0,0] call CBA_fnc_vectElev;
_expected = 0;
TEST_DEFINED_AND_OP(_result,==,_expected,_fn);

_result = [1,0,1] call CBA_fnc_vectElev;
_expected = 45;
TEST_DEFINED_AND_OP(_result,==,_expected,_fn);


// UNIT TESTS (vectElev)
_fn = "CBA_fnc_vectMagn";
TEST_DEFINED("CBA_fnc_vectMagn","");

_result = [0,0,0] call CBA_fnc_vectMagn;
_expected = 0;
TEST_DEFINED_AND_OP(_result,==,_expected,_fn);

_result = [400,0,0] call CBA_fnc_vectMagn;
_expected = 400;
TEST_DEFINED_AND_OP(_result,==,_expected,_fn);


// UNIT TESTS (vectMagn2D)
_fn = "CBA_fnc_vectMagn2D";
TEST_DEFINED("CBA_fnc_vectMagn2D","");

_result = [0,0] call CBA_fnc_vectMagn2D;
_expected = 0;
TEST_DEFINED_AND_OP(_result,==,_expected,_fn);

_result = [1,0] call CBA_fnc_vectMagn2D;
_expected = 1;
TEST_DEFINED_AND_OP(_result,==,_expected,_fn);


// UNIT TESTS (vectRotate2D)
_fn = "CBA_fnc_vectRotate2D";
TEST_DEFINED("CBA_fnc_vectRotate2D","");

_result = [[1,1],[2,4],90] call CBA_fnc_vectRotate2D;
_expected = [-2,2];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [[5,-5],[-10,0],-270] call CBA_fnc_vectRotate2D;
_expected = [0,-20];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

// UNIT TESTS (vectRotate3D)
_fn = "CBA_fnc_vectRotate3D";
TEST_DEFINED("CBA_fnc_vectRotate3D","");

_result = [[0,0,1],[0,0,1],0] call CBA_fnc_vectRotate3D;
_expected = [0,0,1];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [[0,0,1],[0,0,1],90] call CBA_fnc_vectRotate3D;
_expected = [0,0,1];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [[0,1,0],[0,0,-1],90] call CBA_fnc_vectRotate3D;
_expected = [1,0,0];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [[0,1,0],[0,0,-10],90] call CBA_fnc_vectRotate3D;
_expected = [1,0,0];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [[0,1,0],[1,0,0],90] call CBA_fnc_vectRotate3D;
_expected = [0,-0.00000004371138828674,1];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [[0,1,0],[0,0,1],-45] call CBA_fnc_vectRotate3D;
_expected = [sqrt 2/2,sqrt 2/2,0];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

// UNIT TESTS (vectSubtract)
_fn = "CBA_fnc_vectSubtract";
TEST_DEFINED("CBA_fnc_vectSubtract","");

_result = [[0,1,2],[3,1,-1]] call CBA_fnc_vectSubtract;
_expected = [-3,0,3];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);


//Complex Testing:
_expected = [100,30,45];
private _temp = (+_expected) call CBA_fnc_polar2vect;
_result = _temp call CBA_fnc_vect2Polar;
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,"complex polar 1");

_expected = [1,4,-9];
_temp = (+_expected) call CBA_fnc_vect2Polar;
_result = _temp call CBA_fnc_polar2vect;
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,"complex polar 2");


// UNIT TESTS (vectMap3D)
_fn = "CBA_fnc_vectMap3D";
TEST_DEFINED("CBA_fnc_vectMap3D","");

_result = [[[0,1,0],[0,0,1],[1,0,0]], [1,2,3]] call CBA_fnc_vectMap3D;
_expected = [2,3,1];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

_result = [[[1,2,5],[2,-1,3],[5,6,-1]], [1,2,3]] call CBA_fnc_vectMap3D;
_expected = [20,9,14];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_vectorEquals,_fn);

// UNIT TESTS (matrixTranspose)
_fn = "CBA_fnc_matrixTranspose";
TEST_DEFINED("CBA_fnc_matrixTranspose","");

_result = [[[1,2,5],[-2,4,3],[5,6,8]]] call CBA_fnc_matrixTranspose;
_expected = [[1,-2,5],[2,4,6],[5,3,8]];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_matrixEquals,_fn);

// UNIT TESTS (matrixProduct3D)
_fn = "CBA_fnc_matrixProduct3D";
TEST_DEFINED("CBA_fnc_matrixProduct3D","");

_result = [[[1,2,5],[2,-1,3],[5,6,-1]], [[1,2,3],[3,1,2],[2,3,1]]] call CBA_fnc_matrixProduct3D;
_expected = [[17,19,12],[5,12,7],[21,13,26]];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_matrixEquals,_fn);

private _orthogonalMatrix = [[2/3,-1/3,2/3],[2/3,2/3,-1/3],[-1/3,2/3,2/3]];
private _orthogonalMatrixTransposed = [_orthogonalMatrix] call CBA_fnc_matrixTranspose;
_result = [_orthogonalMatrix, _orthogonalMatrixTransposed] call CBA_fnc_matrixProduct3D;
_expected = [[1,0,0],[0,1,0],[0,0,1]];
TEST_TRUE([ARR_2(_result,_expected)] call _fnc_matrixEquals,_fn);


nil;
