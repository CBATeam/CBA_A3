#include "script_component.hpp"

if (isServer) exitWith {};

SLX_XEH_STR spawn {
    waitUntil {!(isNil QGVAR(versions_serv))};
    if (!SLX_XEH_DisableLogging) then {
        private _logMsgs = [];
        [GVAR(versions_serv), { _logMsgs pushBack format["%1=%2", _key, (_value select 0) joinString "."]}] call CBA_fnc_hashEachPair;
        private _logMsg = _logMsgs joinString ", ";

        INFO_2("%1 VERSIONING_SERVER:%2", [ARR_3(diag_frameNo, diag_tickTime, time)], _logMsg);
    };
    [GVAR(versions_serv), {call FUNC(version_check)}] call CBA_fnc_hashEachPair;
};
