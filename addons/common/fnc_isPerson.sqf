#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_isPerson

Description:
    Checks if an object is a person - soldier or civilian.

Parameters:
    _unit - A unit or classname <OBJECT, STRING>

Returns:
    True if object is a person, otherwise false <BOOLEAN>

Examples:
    (begin example)
    player call CBA_fnc_isPerson;
    -> true

    "CAManBase" call CBA_fnc_isPerson;
    -> true

    (vehicle player) call CBA_fnc_isPerson;
    -> false

    _projectile call CBA_fnc_isPerson;
    -> false
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(isPerson);

params [["_unit", "", [objNull, ""]]];

if (_unit isEqualType objNull) then {
    _unit = typeOf _unit;
};

private _config = configFile >> "CfgVehicles" >> _unit;

isClass _config && {getNumber (_config >> "isMan") == 1}
