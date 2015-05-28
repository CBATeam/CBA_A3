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

if (tolower (typeName _this) == "GROUP") exitwith {_this};
group _this
