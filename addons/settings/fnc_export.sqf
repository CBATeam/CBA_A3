#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_export

Description:
    Export all setting info to string.

Parameters:
    _source - Can be "client", "mission" or "server" (optional, default: "client") <STRING>
    _exportDefault - true: export all settings,
                    false: only changed settings (optional, default: false) <BOOL>

Returns:
    Formatted setting info. <STRING>

Author:
    commy2
---------------------------------------------------------------------------- */

params [["_source", "client", [""]], ["_exportDefault", true, [false]]];

private _info = "";
private _temp = [];

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

    (GVAR(default) getVariable _setting) params ["_defaultValue", "", "", "", "_category"];

    if (_exportDefault || {
        !(_value isEqualTo _defaultValue) ||
        SANITIZE_PRIORITY(_setting,_priority,_source) > SANITIZE_PRIORITY(_setting,0,_source)
    }) then {
        _temp pushBack [_category, _setting, _value, _priority];
    };
} forEach GVAR(allSettings);

_temp sort true;

private _last = "";

{
    _x params ["_category", "_setting", "_value", "_priority"];

    if (_category != _last) then {
        _last = _category;
        _info = _info + NEWLINE + "// " + _category + NEWLINE;
    };

    _info = _info + ((["", "force ", "force force "] select _priority) + _setting + " = " + str _value + ";" + NEWLINE);
} forEach _temp;

_info select [1] // return
