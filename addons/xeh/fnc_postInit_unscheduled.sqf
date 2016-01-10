/* ----------------------------------------------------------------------------
Function: CBA_fnc_postInit_unscheduled

Description:
    Occurs once per mission after objects and functions are initialized.
    Internal use only.

Parameters:
    None

Returns:
    None

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

XEH_LOG("XEH: PostInit started.");

// call PostInit events
{
    if (_x select 1 == "postInit") then {
        call (_x select 2);
    };
} forEach GVAR(allEventHandlers);

// do InitPost
{
    _x params ["_this"];

    {
        [_this] call _x;
    } forEach (_this getVariable QGVAR(initPost));
} forEach GVAR(initPostStack);

GVAR(initPostStack) = nil;

#ifdef DEBUG_MODE_FULL
    diag_log text format ["isScheduled = %1", call CBA_fnc_isScheduled];
#endif

SLX_XEH_MACHINE set [8, true]; // PostInit passed

XEH_LOG("XEH: PostInit finished.");
