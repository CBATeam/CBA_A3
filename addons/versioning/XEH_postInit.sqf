#include "script_component.hpp"
SCRIPT(XEH_postInit);

/*
    Basic, Generic Version Checking System - By Sickboy <sb_at_dev-heaven.net>
*/

if (!SLX_XEH_DisableLogging) then {
    private ["_logMsg", "_filter"];
    _logMsg = "CBA_VERSIONING: ";
    _filter = {if (_x isEqualType 1) then {[_x] call CBA_fnc_formatNumber} else {_x}};
    [GVAR(versions), { _logMsg = (_logMsg + format["%1=%2, ", _key, ([_value select 0, _filter] call CBA_fnc_filter) joinString "."])}] call CBA_fnc_hashEachPair;

    diag_log [diag_frameNo, diag_tickTime, time, _logMsg];
};

// Dependency check and warn
[GVAR(dependencies), {
    private ["_mod", "_dependencyInfo", "_class", "_f","_dependencyIsPresent"];
    _f = {
        diag_log text _this;
        sleep 1;
        CBA_logic globalChat _this;
    };
    {
        _mod = _x select 0;
        _dependencyInfo = _x select 1;
        _class = (configFile >> "CfgPatches" >> (_dependencyInfo select 0));
        missionNamespace setVariable ["_dependencyIsPresent", _dependencyInfo select 2];
        if (_dependencyIsPresent) then {
            if !(isClass(_class)) then {
                format["WARNING: %1 requires %2 (@%3) at version %4 (or higher). You have none.", _key, _dependencyInfo select 0, _mod, _dependencyInfo select 1] spawn _f;
            } else {
                if !(isArray(_class >> "versionAr")) then {
                    format["WARNING: %1 requires %2 (@%3) at version %4 (or higher). No valid version info found.", _key, _dependencyInfo select 0, _mod, _dependencyInfo select 1] spawn _f;
                } else {
                    if ([_dependencyInfo select 1, getArray(_class >> "versionAr")] call FUNC(version_compare)) then {
                        format["WARNING: %1 requires %2 (@%3) at version %4 (or higher). You have: %5", _key, _dependencyInfo select 0, _mod, _dependencyInfo select 1, getArray(_class >> "versionAr")] spawn _f;
                    };
                };
            };
        };
    } forEach _value;
}] call CBA_fnc_hashEachPair;
