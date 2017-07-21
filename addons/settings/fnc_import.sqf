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
#include "script_component.hpp"

params [["_info", "", [""]], ["_source", "client", [""]]];

_info = [_info, true] call FUNC(parse);

{
    _x params ["_setting", "_value", "_priority"];

    _priority = _priority min ([0,1,2] param [["client", "mission", "server"] find toLower _source, 0]);

    SET_TEMP_NAMESPACE_VALUE(_setting,_value,_source);
    SET_TEMP_NAMESPACE_PRIORITY(_setting,_priority,_source);
} forEach _info;

if (!isNull (uiNamespace getVariable [QGVAR(display), displayNull])) then {
    call FUNC(gui_refresh);
};
