/* ----------------------------------------------------------------------------
Function: CBA_fnc_init

Description:
    Runs Init and InitPost event handlers on this object.
    Internal use only.

Parameters:
    0: Any CfgVehicles object <OBJECT>

Returns:
    None

Examples:
    (begin example)
        [_unit] call CBA_fnc_init;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params ["_this"];

if !(ISINITIALIZED(_this)) then {
    SETINITIALIZED(_this);

    // run Init
    {
        [_this] call _x;
    } forEach (_this getVariable QGVAR(init));

    // run InitPost or put on stack
    if (SLX_XEH_MACHINE select 8) then {
        {
            [_x, [_this]] call CBA_fnc_execNextFrame;
        } forEach (_this getVariable QGVAR(initPost));
    } else {
        GVAR(initPostStack) pushBack _this;
    };

    #ifdef DEBUG_MODE_FULL
        diag_log ["Init", _unit, local _unit, typeOf _unit];
    #endif
};
