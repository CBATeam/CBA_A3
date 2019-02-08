#include "script_component.hpp"
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

// mission namespace does not exist yet.
// spawned threads will not continue.
with uiNamespace do {
    SLX_XEH_DisableLogging = isClass (configFile >> "CfgPatches" >> "Disable_XEH_Logging");

    XEH_LOG("XEH: PreStart started.");

    SLX_XEH_COMPILE = compileFinal "compile preprocessFileLineNumbers _this"; //backwards comps
    SLX_XEH_COMPILE_NEW = CBA_fnc_compileFunction; //backwards comp

    PREP(initDisplay3DEN);

    // call PreStart events
    {
        private _eventFunc = "";

        if (isClass _x) then {
            private _entry = _x >> "init";

            if (isText _entry) then {
                _eventFunc = _eventFunc + getText _entry + ";";
            };
        } else {
            if (isText _x) then {
                _eventFunc = getText _x + ";";
            };
        };

        if !(_eventFunc isEqualTo "") then {
            [] call compile _eventFunc;
        };
    } forEach configProperties [configFile >> XEH_FORMAT_CONFIG_NAME("preStart")];

    #ifdef DEBUG_MODE_FULL
        diag_log text format ["isScheduled = %1", call CBA_fnc_isScheduled];
    #endif

    XEH_LOG("XEH: PreStart finished.");

    // check extended event handlers compatibility
    {
        _x params ["_classname", "_addon"];

        if (_addon == "") then {
            diag_log text format ["[XEH]: %1 does not support Extended Event Handlers!", _classname];
        } else {
            diag_log text format ["[XEH]: %1 does not support Extended Event Handlers! Addon: %2", _classname, _addon];
        };
    } forEach (true call CBA_fnc_supportMonitor);

    // cache incompatible classes that are needed in preInit
    GVAR(incompatibleClasses) = compileFinal str ([false, true] call CBA_fnc_supportMonitor);
};
