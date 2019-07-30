#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getVolume

Description:
    Return the volume of the bounding box of an object's model.
    The bounding box is retrieved using boundingBoxReal instead of boundingBox
    with visual clipping type for more precise measurements.

Parameters:
    _object - Object to calculate the volume of <OBJECT>

Returns:
    _volume - Volume of the bounding box <NUMBER>

Examples:
    (begin example)
        private _volume = _vehicle call CBA_fnc_getVolume
    (end)

Author:
    Anton
---------------------------------------------------------------------------- */
SCRIPT(getVolume);

params [["_object", objNull, [objNull]]];

(0 boundingBoxReal _object) params ["_leftBackBottom", "_rightFrontTop"];
(_rightFrontTop vectorDiff _leftBackBottom) params ["_width", "_length", "_height"];
_width * _length * _height
