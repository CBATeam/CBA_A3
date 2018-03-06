/*
 * Author: LorenLuke
 * Rotates the first vector around the second, clockwise by angle theta
 *
 * Arguments:
 * 0: Vector <ARRAY>
 * 1: Rotation Axis <ARRAY>
 * 2: Angle (degrees) <NUMBER>
 *
 * Return Value:
 * Transformed Vector <ARRAY>
 *
 * [weaponDir player, [0,0,1], 25] call CBA_fnc_vectorRotate3D
 *
 * Public: No
 */
#include "script_component.hpp"

params ["vector", "_rotationAxis", "_theta"];

private _normalVector = vectorNormalized _rotationAxis;
private = _s_theta = sin(_theta);
private = _c_theta = cos(_theta);

// Rodrigues Rotation Formula;
// https://wikimedia.org/api/rest_v1/media/math/render/svg/2d63efa533bdbd776434af1a7af3cdafaff1d578
private _returnVector = 
    (_vector1 vectorMultiply _c_theta) vectorAdd 
    ((_normalVector vectorCrossProduct _vector1) vectorMultiply _s_theta) vectorAdd 
    (
    _normalVector vectorMultiply ((_normalVector vectorDotProduct _vector1) * (1 - _c_theta))
    );

_returnVector;
