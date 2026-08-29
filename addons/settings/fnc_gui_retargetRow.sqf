#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_retargetRow

Description:
    Points a settings menu row at a setting and a source, and puts the parts of
    it that depend on either into the right state.

    Every control of a row reads the setting and the source back off the row when
    it is used, so this is all that has to happen for a row to start showing
    something else. It does not set the value or the priority, the caller does
    that through the row's updateUI and updateUI_priority.

Parameters:
    _controlsGroup - Setting controls group <CONTROL>
    _setting       - Variable name of the setting to show <STRING>
    _source        - Source to show it for, "client", "mission" or "server" <STRING>

Returns:
    _enabled - Whether the setting can be edited from this source <BOOL>

Examples:
    (begin example)
        [_ctrlSettingGroup, "cba_disposable_replaceDisposableLauncher", "server"] call CBA_settings_fnc_gui_retargetRow;
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */

params ["_controlsGroup", "_setting", "_source"];

_controlsGroup setVariable [QGVAR(setting), _setting];
_controlsGroup setVariable [QGVAR(source), _source];

// has to be known first, everything below only switches a control back on if the
// setting can be edited at all
private _enabled = _controlsGroup call FUNC(gui_setRowEnabled);

// ----- which overwrite checkboxes a row has depends on the source it shows
_controlsGroup call FUNC(gui_setOverwriteVisible);

private _isGlobal = _controlsGroup getVariable [QGVAR(isGlobal), SETTING_LOCAL_OVERRIDABLE];
private _ctrlOverwriteClient = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_CLIENT;

// "overwrite clients" is forced for global settings, so it can't be unticked
_ctrlOverwriteClient setVariable [QGVAR(cbEnabled), !(_isGlobal isNotEqualTo SETTING_LOCAL_OVERRIDABLE && _source isNotEqualTo "mission")];

// what "overwrite clients" goes back to belongs to the source that was shown
_ctrlOverwriteClient setVariable [QGVAR(state), nil];

_enabled
