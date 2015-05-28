/* ----------------------------------------------------------------------------
Function: CBA_fnc_getVolume

Description:
    Return the volume of an object based on the object's model's bounding
    box.

Parameters:
    _object - an object to calculate the volume of. [Object]

Returns:
    _volume - the volume. [Number]

Examples:
    (begin example)
    _vol = _vehicle call CBA_fnc_getVolume
    (end)

Author:
    Rommel
---------------------------------------------------------------------------- */

#include <script_component.hpp>

PARAMS_1(_object);

private "_bounds";
_bounds = (boundingBox _object) select 1;

((_bounds select 0) * (_bounds select 1) * (_bounds select 2));