#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_postInit

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

isNil {
    XEH_LOG("PostInit started. " + PFORMAT_9("MISSIONINIT",missionName,missionVersion,worldName,isMultiplayer,isServer,isDedicated,CBA_isHeadlessClient,hasInterface,didJIP));

    // fix CBA_missionTime being -1 on (non-JIP) clients at mission start.
    if (CBA_missionTime == -1) then {
        CBA_missionTime = 0;
    };

    // call PostInit events
    {
        if (_x select 1 == "postInit") then {
            (_x select 2) call {
                private "_x";

                [] call (_this select 0);

                if (!isDedicated) then {
                    [] call (_this select 1);
                };

                if (isServer) then {
                    [] call (_this select 2);
                };
            };
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

    XEH_LOG("PostInit finished.");
};

nil
