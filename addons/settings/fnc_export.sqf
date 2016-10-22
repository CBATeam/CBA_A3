/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_export

Description:
    Export all setting info to string.

Parameters:
    _source - Can be "client", "mission" or "server" (optional, default: "client") <STRING>

Returns:
    Formatted setting info. <STRING>

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_source", "client", [""]]];

private _info = "";

{
    private _setting = _x;
    private _value = GET_TEMP_NAMESPACE_VALUE(_setting,_source);

    if (isNil "_value") then {
        _value = [_setting, _source] call FUNC(get);
    };

    private _priority = GET_TEMP_NAMESPACE_PRIORITY(_setting,_source);

    if (isNil "_priority") then {
        _priority = [_setting, _source] call FUNC(priority);
    };

    _info = _info + (str ([0,1,2] select _priority) + " " + _setting + " = " + str _value + ";" + NEWLINE);
} forEach GVAR(allSettings);

_info
