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
#define DEBUG_SYNCHRONOUS
#include "script_component.hpp"

params ["_this"];

// fix for https://github.com/CBATeam/CBA_A3/issues/661
if (scriptDone GVAR(LoadingCheck)) exitWith {
    INFO_1("Abort init event during savegame load. Class: %1.",typeOf _this);
};

if !(ISINITIALIZED(_this)) then {
    SETINITIALIZED(_this);

    // run Init
    {
        [_this] call _x;
    } forEach (_this getVariable QGVAR(init));

    // run InitPost or put on stack
    if (SLX_XEH_MACHINE select 8) then {
        [{
            {
                [_this] call _x;
            } forEach (_this getVariable QGVAR(initPost));
        }, _this] call CBA_fnc_execNextFrame;
    } else {
        GVAR(initPostStack) pushBack _this;
    };

    #ifdef DEBUG_MODE_FULL
        diag_log ["Init", _unit, local _unit, typeOf _unit];
    #endif
};
