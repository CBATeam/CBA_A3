/* ----------------------------------------------------------------------------
Function: CBA_fnc_isTerrainObject

Description:
    Check if object is a terrain object.

Parameters:
    _object - any object <OBJECT>

Returns:
    true for terrain objects, false otherwise <BOOLEAN>

Examples:
    (begin example)
        cursorObject call CBA_fnc_isTerrainObject
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(isTerrainObject);

params [["_object", objNull, [objNull]]];

_object in nearestTerrainObjects [_object, [], 1, false, true] // return
