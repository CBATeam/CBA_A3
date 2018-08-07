#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_findEntity

Description:
    A function used to find out the first entity of parsed type in a nearEntitys call

Parameters:
    - Type (Classname or Object) <STRING, OBJECT>
    - Position <OBJECT, LOCATION, GROUP, TASK, MARKER, POSITION>

Optional:
    - Radius <NUMBER>

Example:
    (begin example)
        _veh = ["LaserTarget", player] call CBA_fnc_findEntity
    (end)

Returns:
    First entity; nil return if nothing

Author:
    Rommel
---------------------------------------------------------------------------- */
SCRIPT(findEntity);

params [["_type", "", [objNull, ""]], ["_position", objNull], ["_radius", 50, [0]]];

if (_type isEqualType objNull) then {
    _type = typeOf _type;
};

private _return = (_position call CBA_fnc_getPos) nearEntities [[_type], _radius];

_return param [0]
