#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getVolume

Description:
    Return the volume of the bounding box of an object's model.
    An optional parameter can specify the calculation to use either boundingBox or boundingBoxReal.

Parameters:
    0: _object - Object to calculate the volume of <OBJECT>
    1: _real   - false: use boundingBox, true: use boundingBoxReal (optional, default: true) <BOOLEAN>

Returns:
    _volume - Volume of the bounding box <NUMBER>

Examples:
    (begin example)
        // Less precise volume using boundingBox
        _volume = [_vehicle, false] call CBA_fnc_getVolume

        // More precise volume using boundingBoxReal
        volume = [_vehicle] call CBA_fnc_getVolume
    (end)

Author:
    Anton
---------------------------------------------------------------------------- */
SCRIPT(getVolume);

params [
    ["_object", objNull, [objNull]],
    ["_real", true, [true]]
];

private _boundingBox = [boundingBox _object, boundingBoxReal _object] select _real;
_boundingBox params ["_leftBackBottom", "_rightFrontTop"];
(_rightFrontTop vectorDiff _leftBackBottom) params ["_width", "_length", "_height"];
_width * _length * _height
