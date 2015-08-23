/* ----------------------------------------------------------------------------
Function: CBA_fnc_findFirstNullEntry

Description:
    A function that return the index of the first Null Entry in a Array.

Parameters:
    A Array with Any type of Variable

Example:
    (begin example)
    _index = ["", Player, "test", objNull, VARIABLE, ] call CBA_fnc_findFirstNullEntry
    (end)

Returns:
    Index that is the first Null Entrys in the Array if no Null in retrun -1

Author:
    joko // Jonas
---------------------------------------------------------------------------- */
#include "script_component.hpp"

scopeName "main";

{
    if (isNull _x) then {
        _forEachIndex breakOut "main";
    };
} forEach _this;

-1
