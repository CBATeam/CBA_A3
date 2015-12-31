/* ----------------------------------------------------------------------------
Function: CBA_fnc_preStart

Description:
    Occurs once during game start.
    Internal use only.

Parameters:
    None

Returns:
    None

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

// mission namespace does not exist yet.
// spawned threads will not continue.
with uiNamespace do {
    SLX_XEH_DisableLogging = isClass (configFile >> "CfgPatches" >> "Disable_XEH_Logging");

    XEH_LOG("XEH: PreStart started.");

    // pre compile PreInit and PostInit config event handlers
    // stored in function to prevent these from being overwritten
    GVAR(fnc_getAllEventHandlers) = compileFinal str (configFile call CBA_fnc_compileEventHandlers);

    // call PreStart events
    {
        if (_x select 1 == "preStart") then {
            call (_x select 2);
        };
    } forEach (call FUNC(getAllEventHandlers));

    #ifdef DEBUG_MODE_FULL
        diag_log text format ["isSheduled = %1", call CBA_fnc_isSheduled];
    #endif

    XEH_LOG("XEH: PreStart finished.");

    // check extended event handlers compatibility
    {
        _x params ["_classname", "_addon"];

        if (_addon == "") then {
            diag_log text format ["[XEH]: %1 does not support Extended Eventhandlers!", _classname];
        } else {
            diag_log text format ["[XEH]: %1 does not support Extended Eventhandlers! Addon: %2", _classname, _addon];
        };
    } forEach (true call CBA_fnc_supportMonitor);
};
