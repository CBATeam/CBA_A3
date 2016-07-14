/* ----------------------------------------------------------------------------
Function: CBA_fnc_readKeyFromConfig

Description:
    Reads key setting from config.

Parameters:
    _component - Classname under "CfgSettings" >> "CBA" >> "events" <STRING>
    _action    - Action name <STRING>

Returns:
    _key      - Key (DIK-Code) <NUMBER>
    _settings - Shift, Ctrl, Alt modifiers <ARRAY>

Examples:
    (begin example)
        _keyConfig = ["cba_sys_nvg", "nvgon"] call CBA_fnc_readKeyFromConfig;
    (end)

Author:
    Sickboy, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(readKeyFromConfig);

params [["_component", "", [""]], ["_action", "", [""]]];

private _config = CFGSETTINGS >> _component >> _action;

private _key = -1;
private _settings = [false, false, false];

if (isNumber _config) then {
    TRACE_2("",_this,getNumber _config);
    _key = getNumber _config;
};

if (isClass _config) then {
    TRACE_2("",_this,getNumber (_config >> "key"));
    _key = getNumber (_config >> "key");

    {
        if (getNumber (_config >> _x) == 1) then {
            _settings set [_forEachIndex, true];
        };
    } forEach ["shift", "ctrl", "alt"];
};

[_key, _settings]
