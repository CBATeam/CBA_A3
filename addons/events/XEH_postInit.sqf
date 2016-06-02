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


if (isServer) then {
    CBA_clientID = [0, 2] select isMultiplayer;
    addMissionEventHandler ["PlayerConnected", {
        params ["_id", "_uid", "_name", "_jip", "_owner"];
        TRACE_5("PlayerConnected eh",_id,_uid,_name,_jip,_owner);

        if (_owner != 2) then {
            CBA_clientID = _owner;
            _owner publicVariableClient "CBA_clientID";
            CBA_clientID = [0, 2] select isMultiplayer;
        };
    }];
};
