#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_import

Description:
    Import all setting info from string.

Parameters:
    _info   - Formated settings info, (from CBA_settings_fnc_export) <STRING>
    _source - Can be "client", "mission" or "server" (optional, default: "client") <STRING>

Returns:
    None

Author:
    commy2
---------------------------------------------------------------------------- */

params [["_info", "", [""]], ["_source", "client", [""]]];

_info = [_info, true, _source] call FUNC(parse);

{
    _x params ["_setting", "_value", "_priority"];
    _priority = SANITIZE_PRIORITY(_setting,_priority,_source);

    SET_TEMP_NAMESPACE_VALUE(_setting,_value,_source);
    SET_TEMP_NAMESPACE_PRIORITY(_setting,_priority,_source);
} forEach _info;

if (!isNull (uiNamespace getVariable [QGVAR(display), displayNull])) then {
    call FUNC(gui_refresh);
};
