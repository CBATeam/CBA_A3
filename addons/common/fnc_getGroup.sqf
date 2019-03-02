#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getGroup

Description:
    A function used to find out the group of an object.

Parameters:
    _entity - <OBJECT, GROUP>

Example:
    (begin example)
        _group = player call CBA_fnc_getGroup
    (end)

Returns:
    Group

Author:
    Rommel
---------------------------------------------------------------------------- */
SCRIPT(getGroup);

params [["_entity", grpNull, [grpNull, objNull]]];

if (_entity isEqualType grpNull) exitWith {_entity};

group _entity
