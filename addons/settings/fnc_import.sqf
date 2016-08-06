/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_import

Description:
    Import all setting info from string.

Parameters:
    _info   - Formated settings info, (from CBA_settings_fnc_export), (optional, default: clipboard) <STRING>
    _source - Can be "client", "server" or "mission" (optional, default: "client") <STRING>

Returns:
    None

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_info", "", [""]], ["_source", "client", [""]]];

_info = _info call FUNC(parse);

{
    _x params ["_setting", "_value", "_force"];

    SET_TEMP_NAMESPACE_VALUE(_setting,_value,_source);
    SET_TEMP_NAMESPACE_FORCED(_setting,_force,_source);
} forEach _info;

if (!isNull (uiNamespace getVariable [QGVAR(display), displayNull])) then {
    call FUNC(gui_refresh);
};
