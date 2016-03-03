/* ----------------------------------------------------------------------------
Function: CBA_fnc_mapDirTo

Description:
    Gets the direction between two map grid references.

Parameters:
    _pos1 - Origin position array in format [Easting, Northing] [Array]
    _pos2 - End position in format [Easting, Northing] [Array]

Returns:
    Direction from _pos1 to _pos2 [Number]

Examples:
    (begin example)
        _dir = [[024,015], [025,014]] call CBA_fnc_mapDirTo;
        // _dir will be 45 degrees
    (end)
    (begin example)
        _dir = [["024","015"], ["025","014"]] call CBA_fnc_mapDirTo;
        // _dir will be 45 degrees
    (end)
    (begin example)
        _dir = ["024015", "025014"] call CBA_fnc_mapDirTo;
        // _dir will be 45 degrees
    (end)


Author:
    Nou (with credit to Headspace for the real math :p)
---------------------------------------------------------------------------- */
#include "script_component.hpp"

SCRIPT(mapDirTo);

params ["_pos1","_pos2"];
_pos1 = _pos1 call CBA_fnc_mapGridToPos;
_pos2 = _pos2 call CBA_fnc_mapGridToPos;

(([_pos1,_pos2] call BIS_fnc_dirTo) + 360) mod 360;
