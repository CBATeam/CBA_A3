#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getAlive

Description:
    A function used to find out who is alive in an array or a group.

Parameters:
    _entities - Array or Group <GROUP, ARRAY>

Example:
    (begin example)
        _alive = (units player) call CBA_fnc_getAlive
    (end)

Returns:
    <ARRAY>

Author:
    Rommel
---------------------------------------------------------------------------- */
SCRIPT(getAlive);

[_this] params [["_entities", [], [objNull, grpNull, []]]];

if (_entities isEqualType objNull) exitWith {
    alive _entities;
};

if (_entities isEqualType grpNull) then {
    _entities = units _entities;
};

_entities select {alive _x} // return
