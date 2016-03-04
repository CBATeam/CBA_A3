/* ----------------------------------------------------------------------------
Function: CBA_fnc_isAlive

Description:
    A function used to find out if the group or object is alive.

Parameters:
    _entity - Array, Group or Unit <OBJECT, GROUP, ARRAY>

Example:
    (begin example)
        _alive = (units player) call CBA_fnc_isAlive
    (end)

Returns:
    <BOOLEAN>

Author:
    Rommel
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(isAlive);

[_this] params [["_entity", objNull, [objNull, grpNull, []]]];

switch (typename _entity) do {
    case "ARRAY" : {
        private _return = false;

        {
            if (_x call CBA_fnc_isAlive) exitwith {
                _return = true;
            };
        } foreach _entity;

        _return
    };
    case "OBJECT" : {
        alive _entity;
    };
    case "GROUP" : {
        if (isnull (leader _entity)) then {
            false
        } else {
            (units _entity) call CBA_fnc_isAlive
        };
    };
    default {};
};
