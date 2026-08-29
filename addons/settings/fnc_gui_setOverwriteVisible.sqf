#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_setOverwriteVisible

Description:
    Shows the "overwrite" checkboxes that the source a settings menu row is
    pointed at can use, and hides the rest.

    Which of them a row has depends on that source, so this has to be reversible.
    It also has to be repeatable: showing a row shows every control inside it,
    the hidden checkboxes included, so whoever shows one puts them back.

Parameters:
    _controlsGroup - Setting controls group <CONTROL>

Returns:
    None

Examples:
    (begin example)
        _ctrlSettingGroup call CBA_settings_fnc_gui_setOverwriteVisible;
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */

params ["_controlsGroup"];

// a local setting never leaves the client it is set on, so it has nothing to
// point anywhere
private _isLocalOnly = ROW_IS_LOCAL_ONLY(_controlsGroup);
private _source = ROW_SOURCE(_controlsGroup);

private _showClient = _source isNotEqualTo "client" && !_isLocalOnly;
private _showMission = _source isEqualTo "server" && !_isLocalOnly;

private _ctrlOverwriteClient = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_CLIENT;
private _ctrlOverwriteMission = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_MISSION;

_ctrlOverwriteClient ctrlShow _showClient;
_ctrlOverwriteMission ctrlShow _showMission;

// a checkbox that isn't there can't be ticked either. Whether the ones that are
// can be is not this function's task to answer, so it only ever takes that away -
// FUNC(gui_setRowEnabled) and the row's updateUI_priority own the other half.
_ctrlOverwriteClient ctrlEnable (_showClient && ctrlEnabled _ctrlOverwriteClient);
_ctrlOverwriteMission ctrlEnable (_showMission && ctrlEnabled _ctrlOverwriteMission);
