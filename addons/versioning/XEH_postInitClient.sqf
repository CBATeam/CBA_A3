#include "script_component.hpp"

if (isServer) exitWith {};

SLX_XEH_STR spawn {
    waitUntil {!(isNil QGVAR(versions_serv))};
    if (!SLX_XEH_DisableLogging) then {
        private _logMsgs = [];
        {
            _logMsgs pushBack format ["%1=%2", _x, (_y select 0) joinString "."];
        } forEach GVAR(versions_serv);
        private _logMsg = _logMsgs joinString ", ";

        INFO_2("%1 VERSIONING_SERVER:%2", [ARR_3(diag_frameNo, diag_tickTime, time)], _logMsg);
    };
    {
        [_x, _y] call FUNC(version_check);
    } forEach GVAR(versions_serv);
};
