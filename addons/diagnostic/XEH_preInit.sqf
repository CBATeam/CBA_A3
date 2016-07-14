// Any registered functions used in the PreINIT phase must use the uiNamespace copies of the variable.
// So uiNamespace getVariable "CBA_fnc_hashCreate" instead of just CBA_fnc_hashCreate -VM
#include "script_component.hpp"

LOG(MSG_INIT);

[QUOTE(GVAR(debug)), { _this call (uiNamespace getVariable "CBA_fnc_debug") }] call (uiNamespace getVariable "CBA_fnc_addEventHandler");

if (SLX_XEH_MACHINE select 3) then
{
    FUNC(handle_peak) =
    {
        params ["_variable"];
        if (isNil _variable) then
        {
            [QUOTE(GVAR(receive_peak)), [_variable, nil]] call (uiNamespace getVariable "CBA_fnc_globalEvent");
        } else {
            [QUOTE(GVAR(receive_peak)), [_variable, call compile _variable]] call (uiNamespace getVariable "CBA_fnc_globalEvent");
        };

    };
    [QUOTE(GVAR(peek)), { _this call CBA_fnc_handle_peak }] call (uiNamespace getVariable "CBA_fnc_addEventHandler");
};

PREP(perf_loop);
