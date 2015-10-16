/* ----------------------------------------------------------------------------
Function: CBA_fnc_getGroup

Description:
    A function used to find out the group of an object.

Parameters:
    Group or Unit

Example:
    (begin example)
    _group = player call CBA_fnc_getGroup
    (end)

Returns:
    Group

Author:
    Rommel

---------------------------------------------------------------------------- */
params [["_group", grpNull, [grpNull, objNull]]];
if ((typeName _group) isEqualTo "GROUP") exitWith {_group};
group _group
