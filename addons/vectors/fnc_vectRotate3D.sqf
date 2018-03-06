/* ----------------------------------------------------------------------------
Function: CBA_vectors_fnc_vectRotate3D
Description:
    Rotates the first vector around the second, clockwise by theta degrees.
Parameters:
    _vector       - 3D vector that is to be rotated <ARRAY>
    _rotationAxis - 3D vector that the first argument is rotated around <ARRAY>
    _theta        - Angle, in degrees clockwise, about which the first vector is rotated <NUMBER>
Returns:
    _returnVector - 3D vector returned after rotation <ARRAY>
Examples:
    (begin example)
    //Rotate 25 degrees right of player weapon direction;
    [weaponDirection player, [0,0,1], 25] call CBA_vectors_fnc_vectRotate3D;

    //Pitch a projectile's velocity down 10 degrees;
    [velocity _projectile, (velocity _projectile) vectorCrossProduct [0,0,1], 10] call CBA_vectors_fnc_vectRotate3D;
    (end)
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
