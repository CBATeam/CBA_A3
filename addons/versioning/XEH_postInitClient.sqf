#include "script_component.hpp"

if (isServer) exitWith {};

SLX_XEH_STR spawn {
    waitUntil {!(isNil QGVAR(versions_serv))};
    if (!SLX_XEH_DisableLogging) then {
        private "_logMsg";
        _logMsg = "CBA_VERSIONING_SERVER: ";
        [GVAR(versions_serv), { _logMsg = (_logMsg + format["%1=%2, ", _key, (_value select 0) joinString "."])}] call CBA_fnc_hashEachPair;

        diag_log [diag_frameNo, diag_tickTime, time, _logMsg];
    };
    [GVAR(versions_serv), {call FUNC(version_check)}] call CBA_fnc_hashEachPair;
};
