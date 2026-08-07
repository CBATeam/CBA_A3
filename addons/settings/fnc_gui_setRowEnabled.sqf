#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_setRowEnabled

Description:
    Works out whether the setting a row is showing can be edited from here, and
    enables or disables the whole row to match.

    The answer is kept on the row because the controls that are switched on and
    off for other reasons - the "reset to default" button, the overwrite
    checkboxes - have to check it before they enable themselves again.

Parameters:
    _controlsGroup - Setting controls group <CONTROL>

Returns:
    _enabled - Whether the setting can be edited <BOOL>

Examples:
    (begin example)
        private _enabled = _ctrlSettingGroup call CBA_settings_fnc_gui_setRowEnabled;
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */

params ["_controlsGroup"];

private _setting = ROW_SETTING(_controlsGroup);
private _source = ROW_SOURCE(_controlsGroup);

private _enabled = switch (_source) do {
    case "client": {CAN_SET_CLIENT_SETTINGS && {isNil {GVAR(userconfig) getVariable _setting}}};
    case "mission": {CAN_SET_MISSION_SETTINGS && {isNil {GVAR(missionConfig) getVariable _setting}}};
    case "server": {CAN_SET_SERVER_SETTINGS && {isNil {GVAR(serverConfig) getVariable _setting}}};
    default {false};
};

_controlsGroup setVariable [QGVAR(enabled), _enabled];

{
    (_controlsGroup controlsGroupCtrl _x) ctrlEnable _enabled;
} forEach (_controlsGroup call FUNC(gui_rowClassInfo) select 1);

private _ctrlSettingName = _controlsGroup controlsGroupCtrl IDC_SETTING_NAME;
_ctrlSettingName ctrlSetTextColor ([COLOR_TEXT_DISABLED, COLOR_TEXT_ENABLED] select _enabled);

_enabled
