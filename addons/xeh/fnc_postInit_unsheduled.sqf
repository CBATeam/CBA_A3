/* ----------------------------------------------------------------------------
Function: CBA_fnc_postInit_unsheduled

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
    _x call CBA_fnc_initPostObject;
} forEach GVAR(InitPostStack);
GVAR(InitPostStack) = nil;

#ifdef DEBUG_MODE_FULL
    diag_log text format ["isSheduled = %1", call CBA_fnc_isSheduled];
#endif

SLX_XEH_MACHINE set [8, true]; // PostInit passed

XEH_LOG("XEH: PostInit finished.");
