/* ----------------------------------------------------------------------------
Function: CBA_fnc_initPostObject

Description:
    Runs InitPost event handlers on this object.
    Internal use only.

Parameters:
    0: Any CfgVehicles object <OBJECT>

Returns:
    None

Examples:
    (begin example)
        _unit call CBA_fnc_initPostObject;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params ["_unit"];

private _class = configFile >> "CfgVehicles" >> typeOf _unit;

while {isClass _class} do {
    // call InitPost event handlers
    {
        // is matching class name if inheritance is disabled and is not a child of any of the excluded classes
        if ((_x select 1 || {typeOf _unit isEqualTo configName _class}) && {{_unit isKindOf _x} count (_x select 2) == 0}) then {
            // prevent variable from being overwritten and causing issues without proper use of private
            private _class = nil;

            [_unit] call (_x select 0);
        };
    } forEach EVENTHANDLERS("initPost",configName _class);

    _class = inheritsFrom _class;
};

#ifdef DEBUG_MODE_FULL
    diag_log ["InitPost", _unit, local _unit, typeOf _unit];
#endif
