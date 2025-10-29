#include "script_component.hpp"

add3DENEventHandler ["OnEditableEntityAdded", {
    params ["_entity"];
    if !(_entity isEqualType objNull) exitWith {};

    {
        _x call CBA_fnc_setIdentity3DEN;
        _x call CBA_fnc_randomizeLoadout;
        _x call CBA_fnc_fixAnimation3DEN;
    } forEach (crew _entity); // Returns [_unit] when running on a unit
}];

add3DENEventHandler ["OnPaste", {
    {
        _x call CBA_fnc_setIdentity3DEN;
        _x call CBA_fnc_randomizeLoadout;
        _x call CBA_fnc_fixAnimation3DEN;
    } forEach flatten (get3DENSelected "object" apply { crew _x });
}];
