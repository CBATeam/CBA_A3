#include "script_component.hpp"
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
SCRIPT(isTerrainObject);

params [["_object", objNull, [objNull]]];

if (isNull _object) exitWith { false };

// Terrain objects always have an owner of 1, but `owner` command is server exec. So we just check first character of netId
// They also have a negative netId, but Dedmen said not to rely on it in the case that BI fixes it
(netId _object) select [0, 2] == "1:"
