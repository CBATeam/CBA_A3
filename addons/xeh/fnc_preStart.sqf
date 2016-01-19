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

    // call PreStart events
    {
        if (_x select 1 == "preStart") then {
            call (_x select 2);
        };
    } forEach (configFile call CBA_fnc_compileEventHandlers);

    #ifdef DEBUG_MODE_FULL
        diag_log text format ["isScheduled = %1", call CBA_fnc_isScheduled];
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
