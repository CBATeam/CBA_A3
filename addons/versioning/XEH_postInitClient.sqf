#include "script_component.hpp"

SLX_XEH_STR spawn {
    waitUntil {!(isNil QGVAR(versions_serv))};
    if (!SLX_XEH_DisableLogging) then {
        private "_logMsg";
        _logMsg = "CBA_VERSIONING_SERVER: ";
        [GVAR(versions_serv), { _logMsg = (_logMsg + format["%1=%2, ", _key, [_value select 0, "."] call CBA_fnc_join])}] call CBA_fnc_hashEachPair;

        [QUOTE(PREFIX), QUOTE(COMPONENT), _logMsg, CBA_LOGLEVEL_INFO, [CBA_fnc_diagLogWriter]] call CBA_fnc_logDynamic;
    };
    [GVAR(versions_serv), {call FUNC(version_check)}] call CBA_fnc_hashEachPair;
};
