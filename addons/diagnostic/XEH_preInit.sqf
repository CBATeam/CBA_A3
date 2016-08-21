// Any registered functions used in the PreINIT phase must use the uiNamespace copies of the variable.
// So uiNamespace getVariable "CBA_fnc_hashCreate" instead of just CBA_fnc_hashCreate -VM
#include "script_component.hpp"

LOG(MSG_INIT);

[QUOTE(GVAR(debug)), { _this call (uiNamespace getVariable "CBA_fnc_debug") }] call (uiNamespace getVariable "CBA_fnc_addEventHandler");

if (isServer) then {
    [QGVAR(peak), {
        params ["_varName", "_targetID"];

        private _value = missionNamespace getVariable _varName;

        [QGVAR(receivePeak), [_varName, _value], _targetID] call CBA_fnc_ownerEvent;
    }] call CBA_fnc_addEventHandler;
};

PREP(perf_loop);
