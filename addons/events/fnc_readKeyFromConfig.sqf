/* ----------------------------------------------------------------------------
Function: CBA_fnc_readKeyFromConfig

Description:
    Reads key setting from config

Parameters:
    _component - Classname under "CfgSettings" >> "CBA" >> "events" [String].
    _action - Action classname [String].

Returns:

Examples:
    (begin example)
        _keyConfig = ["cba_sys_nvg", "nvgon"] call CBA_fnc_readKeyFromConfig;
    (end)

Author:
    Sickboy
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(readKeyFromConfig);

private ["_component", "_action", "_settings"];
PARAMS_2(_component,_action);
_settings = [false, false, false];
if (isNumber(CFGSETTINGS >> _component >> _action)) exitWith {
    TRACE_2("",_this,getNumber(CFGSETTINGS >> _component >> _action));
    [getNumber(CFGSETTINGS >> _component >> _action), _settings];
};

if (isClass(CFGSETTINGS >> _component >> _action)) exitWith {
    TRACE_2("",_this,getNumber(CFGSETTINGS >> _component >> _action >> "key"));
    {
        if (getNumber(CFGSETTINGS >> _component >> _action >> _x) == 1) then { _settings set [_forEachIndex, true] };
    } forEach ["shift", "ctrl", "alt"];
    [getNumber(CFGSETTINGS >> _component >> _action >> "key"), _settings];
};

[-1, _settings];
