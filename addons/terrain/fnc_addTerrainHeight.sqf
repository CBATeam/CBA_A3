#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addTerrainHeight

Description:
    Add terrain height to an area. 

Parameters:
    _area - argument compatible with https://community.bistudio.com/wiki/BIS_fnc_getArea 
        [TRIGGER, MARKER, LOCATION, ARRAY]
    _height - height in metres to add. Negative number lowers terrain [NUMBER]
    _adjustObjects - Adjust objects to new height [BOOL]
    _smooth - if true, add 0 height at edge of area and _height at centre. UNIMPLEMENTED


Returns:
    Whether the terrain was succesfully changed

Examples:
    ["marker1", 20, false, true] call CBA_fnc_addTerrainHeight

Author:
    Seb
---------------------------------------------------------------------------- */

params [
    "_area",
    "_height",
    "_adjustObjects",
    "_smooth"
];
private _positionsAndHeights = _area call CBA_fnc_getAreaTerrainGrid;
_positionsAndHeights = _positionsAndHeights apply {_x vectorAdd [0, 0, _height]};
// TODO: implement smoothing
private _success = [_positionsAndHeights, _adjustObjects] call CBA_fnc_setTerrainHeight;
_success
