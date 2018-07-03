// Any registered functions used in the PreINIT phase must use the uiNamespace copies of the variable.
// So uiNamespace getVariable "CBA_fnc_hashCreate" instead of just CBA_fnc_hashCreate -VM

#include "script_component.hpp"
SCRIPT(XEH_preInit);
/*
    Basic, Generic Version Checking System - By Sickboy <sb_at_dev-heaven.net>

*/
LOG(MSG_INIT);
ADDON = false;

if (isNil "CBA_display_ingame_warnings") then { CBA_display_ingame_warnings = true };
if (isNil QGVAR(mismatch)) then { GVAR(mismatch) = [] };

// Build versions hashes
GVAR(versions) = [[], [[0, 0, 0], 0]] call (uiNamespace getVariable "CBA_fnc_hashCreate");
GVAR(dependencies) = [[], ["", [0, 0, 0], "true"]] call (uiNamespace getVariable "CBA_fnc_hashCreate");

#define DATA configName _entry,(getArray(_entry))
for "_i" from 0 to (count (CFGSETTINGS) - 1) do
{
    private _prefix = (CFGSETTINGS) select _i;
    if (isClass _prefix) then
    {
        private _cfgPatches = if (isText(_prefix >> "main_addon")) then { getText(_prefix >> "main_addon") } else { format["%1_main", configName _prefix] };
        private _verCfg = (configFile >> "CfgPatches" >> _cfgPatches >> "versionAr");
        private _level = if (isNumber(_prefix >> "level")) then { getNumber(_prefix >> "level") } else { -1 };
        private _version = if (isArray(_verCfg)) then { [getArray(_verCfg), _level] } else { [[0, 0, 0], 0] };
        [GVAR(versions), toLower(configName _prefix), _version] call (uiNamespace getVariable "CBA_fnc_hashSet");
        private _deps = (_prefix >> "dependencies");
        if (isClass(_deps)) then {
            private _dependencies = [];
            for "_j" from 0 to ((count _deps) - 1) do {
                private _entry = _deps select _j;
                if (isArray(_entry)) then {
                    _dependencies pushBack [DATA];
                };
            };
            [GVAR(dependencies), toLower(configName _prefix), _dependencies] call (uiNamespace getVariable "CBA_fnc_hashSet");
        };
    };
};

PREP(version_check);
FUNC(version_compare) = {
    params ["_value","_localValue"];

    //Handle non-number arrays - eg. {"mod", {"1.0"}, "(true)"}
    if ((!(_value isEqualTo [])) && {!(_value isEqualTypeAll 0)}) exitWith {true};
    if ((!(_localValue isEqualTo [])) && {!(_localValue isEqualTypeAll 0)}) exitWith {true};

    private _failed = false;
    private _c = count _localValue;

    for "_i" from 0 to ((count _value) - 1) do {
        if (_i == _c) exitWith { _failed = true}; // Woobs
        if ((_localValue select _i) > (_value select _i)) exitWith {}; // All good
        if ((_localValue select _i) < (_value select _i)) exitWith {_failed = true}; // Woobs
    };
    _failed;
};

ADDON = true;
