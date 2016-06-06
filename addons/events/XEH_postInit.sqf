#include "script_component.hpp"

// execute JIP events after post init to guarantee execution of events added during postInit
[{
    {
        private _event = GVAR(eventNamespaceJIP) getVariable _x;
        if (_event isEqualType []) then {
            if ((_event select 0) isEqualTo EVENT_PVAR_STR) then {
                (_event select 1) call CBA_fnc_localEvent;
            };
        };
    } forEach allVariables GVAR(eventNamespaceJIP);
}, []] call CBA_fnc_execNextFrame;
