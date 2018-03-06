 /* ----------------------------------------------------------------------------
Function: CBA_fnc_vectRotate3D
Description:
    Rotates the first vector around the second, clockwise by theta degrees

Parameters:
    Vector, Rotation Axis, Angle
Returns:
    The rotated vector
Author:
    LorenLuke
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params ["vector", "_rotationAxis", "_theta"];

private _normalVector = vectorNormalized _rotationAxis;
private _s_theta = sin(_theta);
private _c_theta = cos(_theta);

// Rodrigues Rotation Formula;
// https://wikimedia.org/api/rest_v1/media/math/render/svg/2d63efa533bdbd776434af1a7af3cdafaff1d578
private _returnVector = 
    (_vector1 vectorMultiply _c_theta) vectorAdd 
    ((_normalVector vectorCrossProduct _vector1) vectorMultiply _s_theta) vectorAdd 
    (
    _normalVector vectorMultiply ((_normalVector vectorDotProduct _vector1) * (1 - _c_theta))
    );

_returnVector;
