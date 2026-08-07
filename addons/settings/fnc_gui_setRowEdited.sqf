#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_setRowEdited

Description:
    Colours a settings menu row's name by whether it still differs from what is
    saved.

    Edited is a comparison, not a flag. Touching a setting and putting it back,
    ticking an overwrite box and unticking it, or typing over a value and typing
    the old one again all leave nothing to apply, so the name goes back to white.

    Does nothing to a disabled row, whose name colour says it cannot be edited.

Parameters:
    _controlsGroup - Settings menu row <CONTROL>

Returns:
    Row differs from the saved setting <BOOL>

Examples:
    (begin example)
        _ctrlSettingGroup call CBA_settings_fnc_gui_setRowEdited;
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */

params ["_controlsGroup"];

private _setting = ROW_SETTING(_controlsGroup);
private _source = ROW_SOURCE(_controlsGroup);

private _edited = (GET_TEMP_NAMESPACE_VALUE_OR_CURRENT(_setting,_source)) isNotEqualTo ([_setting, _source] call FUNC(get))
    || {(GET_TEMP_NAMESPACE_PRIORITY_OR_CURRENT(_setting,_source)) isNotEqualTo ([_setting, _source] call FUNC(priority))};

if (ROW_ENABLED(_controlsGroup)) then {
    (_controlsGroup controlsGroupCtrl IDC_SETTING_NAME) ctrlSetTextColor ([COLOR_TEXT_ENABLED, COLOR_TEXT_ENABLED_WAS_EDITED] select _edited);
};

_edited
