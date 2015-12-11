/* ----------------------------------------------------------------------------
Function: CBA_fnc_findNull

Description:
    A function that returns the index of the first null entry in an array.

Parameters:
    The array to search in.

Example:
    (begin example)
    _index = ["", player, "test", objNull, _variable] call CBA_fnc_findNull
    (end)

Returns:
    Index of the first null entry in the array. If there is no null entry, the function returns -1

Author:
    joko // Jonas
---------------------------------------------------------------------------- */
#include "script_component.hpp"

[_this] params [["_array", [], [[]]]];

scopeName "main";

private _nullTypes = [objNull, controlNull, displayNull, grpNull, teamMemberNull, locationNull, taskNull, scriptNull, configNull];

{
    if (_x in _nullTypes) then {
        _forEachIndex breakOut "main";
    };
} forEach _array;

-1
