/* ----------------------------------------------------------------------------
Function: CBA_fnc_findFirstEmptyEntry

Description:
    A function that return the index of the first Empty Entry in a Array.

Parameters:
    A Array with Nil type of Variable

Example:
    (begin example)
    _index = ["", Player, "test", nil, VARIABLE, nil] call CBA_fnc_findFirstEmptyEntry
    (end)

Returns:
    Index that is the first Empty Entrys in the Array if no Empty in retrun -1

Author:
    joko // Jonas
---------------------------------------------------------------------------- */
#include "script_component.hpp"

scopeName "main";

{
    private "_current";
    _current = _x;
    if (isNil "_current") then {
        _forEachIndex breakOut "main";
    };
} forEach _this;

-1
