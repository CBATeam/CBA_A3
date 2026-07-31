#include "script_component.hpp"

params ["_controlsGroup", "_setting", "_source", "_currentPriority", "_isGlobal"];

private _ctrlOverwriteClient = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_CLIENT;
private _ctrlOverwriteMission = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_MISSION;

// which checkboxes the row has, and whether they can be ticked, depends on the
// source it is showing. FUNC(gui_retargetRow) owns that.

_ctrlOverwriteClient ctrlAddEventHandler ["CheckedChanged", {
    _this call ((_this select 0) getVariable QFUNC(event));
}];

_ctrlOverwriteClient setVariable [QFUNC(event), {
    params ["_ctrlOverwriteClient", "_state"];
    private _controlsGroup = ctrlParentControlsGroup _ctrlOverwriteClient;
    private _ctrlOverwriteMission = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_MISSION;
    private _setting = _controlsGroup getVariable QGVAR(setting);
    private _source = _controlsGroup getVariable QGVAR(source);

    SET_TEMP_NAMESPACE_PRIORITY(_setting,_state,_source);

    _controlsGroup call (_controlsGroup getVariable QFUNC(updateUI_locked));

    _controlsGroup call FUNC(gui_setRowEdited);
}];

_controlsGroup setVariable [QFUNC(auto_check_overwrite), {
    params ["_controlsGroup", "_source"];

    if (_source isEqualTo "mission") then {
        private _ctrlOverwriteClient = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_CLIENT;

        if (!cbChecked _ctrlOverwriteClient) then {
            _ctrlOverwriteClient cbSetChecked true;
            [_ctrlOverwriteClient, 1] call (_ctrlOverwriteClient getVariable QFUNC(event));
        };
    };

    _controlsGroup call FUNC(gui_setRowEdited);
}];

_ctrlOverwriteMission ctrlAddEventHandler ["CheckedChanged", {
    params ["_ctrlOverwriteMission", "_state"];
    private _controlsGroup = ctrlParentControlsGroup _ctrlOverwriteMission;
    private _ctrlOverwriteClient = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_CLIENT;
    private _setting = _controlsGroup getVariable QGVAR(setting);
    private _source = _controlsGroup getVariable QGVAR(source);

    if (_state isEqualTo 1) then {
        _ctrlOverwriteClient setVariable [QGVAR(state), cbChecked _ctrlOverwriteClient];
        _ctrlOverwriteClient cbSetChecked true;
        _ctrlOverwriteClient ctrlEnable false;

        SET_TEMP_NAMESPACE_PRIORITY(_setting,2,_source);
    } else {
        private _wasChecked = _ctrlOverwriteClient getVariable QGVAR(state);
        _ctrlOverwriteClient cbSetChecked _wasChecked;
        ROW_ENABLE(_controlsGroup,IDC_SETTING_OVERWRITE_CLIENT,_ctrlOverwriteClient getVariable [ARR_2(QGVAR(cbEnabled),true)]);

        _state = parseNumber _wasChecked;
        SET_TEMP_NAMESPACE_PRIORITY(_setting,_state,_source);
    };

    _controlsGroup call (_controlsGroup getVariable QFUNC(updateUI_locked));

    _controlsGroup call FUNC(gui_setRowEdited);
}];

// update overwrite checkboxes
_controlsGroup setVariable [QFUNC(updateUI_priority), {
    params ["_controlsGroup", "_priority"];

    private _ctrlOverwriteClient = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_CLIENT;
    private _ctrlOverwriteMission = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_MISSION;

    if (_priority > 1) then {
        _ctrlOverwriteMission cbSetChecked true;

        _ctrlOverwriteClient cbSetChecked true;
        _ctrlOverwriteClient ctrlEnable false;

        // A setting saved as overwriting the mission comes back with no memory of
        // what "overwrite clients" was before that. Overwriting the mission
        // includes overwriting the clients, so unticking it drops back to just
        // the clients rather than to nothing.
        if (isNil {_ctrlOverwriteClient getVariable QGVAR(state)}) then {
            _ctrlOverwriteClient setVariable [QGVAR(state), true];
        };
    } else {
        _ctrlOverwriteMission cbSetChecked false;

        _ctrlOverwriteClient cbSetChecked (_priority > 0);
        ROW_ENABLE(_controlsGroup,IDC_SETTING_OVERWRITE_CLIENT,_ctrlOverwriteClient getVariable [ARR_2(QGVAR(cbEnabled),true)]);

        // what to go back to when "overwrite mission" is unticked again. Only kept
        // while it is unticked, so it always belongs to the source being shown.
        _ctrlOverwriteClient setVariable [QGVAR(state), _priority > 0];
    };

    _controlsGroup call (_controlsGroup getVariable QFUNC(updateUI_locked));
}];

// update "locked" ui icon
_controlsGroup setVariable [QFUNC(updateUI_locked), {
    params ["_controlsGroup"];
    private _setting = _controlsGroup getVariable QGVAR(setting);
    private _priority = TEMP_PRIORITY(_setting);
    private _tempValue = TEMP_VALUE(_setting);

    private _source = ROW_SOURCE(_controlsGroup);
    private _sourceValue = TEMP_VALUE_SOURCE(_setting,_source);
    private _ctrlLocked = _controlsGroup controlsGroupCtrl IDC_SETTING_LOCKED;

    if (_source isEqualTo _priority) then {
        if (toLower _setting in GVAR(awaitingRestartTemp)) then {
            _ctrlLocked ctrlSetText ICON_NEED_RESTART;
            _ctrlLocked ctrlSetTextColor COLOR_NEED_RESTART;
            _ctrlLocked ctrlSetTooltip LLSTRING(need_restart);
        } else {
            _ctrlLocked ctrlSetText ICON_APPLIES;
            _ctrlLocked ctrlSetTextColor COLOR_APPLIES;
            _ctrlLocked ctrlSetTooltip LLSTRING(applies);
        };
    } else {
        private _overwriteEqual = _sourceValue isEqualTo _tempValue;
        private _overwriteColor = [COLOR_OVERWRITTEN, COLOR_OVERWRITTEN_EQUAL] select _overwriteEqual;

        // Three states, three shapes, so none of them rely on colour alone to be
        // told apart. Another source winning with the same value leaves this value
        // in effect either way, which is what the tilde says.
        private _overwriteIcon = [ICON_OVERWRITTEN, ICON_OVERWRITTEN_EQUAL] select _overwriteEqual;

        switch [_source, _priority] do {
            case ["client", "server"];
            case ["mission", "server"]: {
                _ctrlLocked ctrlSetText _overwriteIcon;
                _ctrlLocked ctrlSetTextColor _overwriteColor;
                _ctrlLocked ctrlSetTooltip ([LLSTRING(overwritten_by_server_tooltip), LLSTRING(overwritten_by_server_equal_tooltip)] select _overwriteEqual);
            };
            case ["client", "mission"];
            case ["server", "mission"]: {
                _ctrlLocked ctrlSetText _overwriteIcon;
                _ctrlLocked ctrlSetTextColor _overwriteColor;
                _ctrlLocked ctrlSetTooltip ([LLSTRING(overwritten_by_mission_tooltip), LLSTRING(overwritten_by_mission_equal_tooltip)] select _overwriteEqual);
            };
            case ["mission", "client"]: {
                _ctrlLocked ctrlSetText _overwriteIcon;
                _ctrlLocked ctrlSetTextColor _overwriteColor;
                _ctrlLocked ctrlSetTooltip ([LLSTRING(overwritten_by_client_tooltip), LLSTRING(overwritten_by_client_equal_tooltip)] select _overwriteEqual);
            };
            case ["server", "client"]: {
                if (isServer) then {
                    if (toLower _setting in GVAR(awaitingRestartTemp)) then {
                        _ctrlLocked ctrlSetText ICON_NEED_RESTART;
                        _ctrlLocked ctrlSetTextColor COLOR_NEED_RESTART;
                        _ctrlLocked ctrlSetTooltip LLSTRING(need_restart);
                    } else {
                        _ctrlLocked ctrlSetText ICON_APPLIES;
                        _ctrlLocked ctrlSetTextColor COLOR_APPLIES;
                        _ctrlLocked ctrlSetTooltip LLSTRING(applies);
                    };
                } else {
                    _ctrlLocked ctrlSetText _overwriteIcon;
                    _ctrlLocked ctrlSetTextColor COLOR_OVERWRITTEN;
                    _ctrlLocked ctrlSetTooltip LLSTRING(overwritten_by_client_tooltip_server);
                };
            };
        };
    };
}];

[_controlsGroup, _currentPriority] call (_controlsGroup getVariable QFUNC(updateUI_priority));
