#include "script_component.hpp"

params ["_controlsGroup", "_setting", "_source", "_currentPriority", "_isGlobal"];

private _ctrlOverwriteClient = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_CLIENT;
private _ctrlOverwriteMission = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_MISSION;

if (_source isEqualTo "client") then {
    _ctrlOverwriteClient ctrlEnable false;
    _ctrlOverwriteClient ctrlSetPosition [0, 0, -1, -1];
    _ctrlOverwriteClient ctrlCommit 0;
};

if (_source isNotEqualTo "server") then {
    _ctrlOverwriteMission ctrlEnable false;
    _ctrlOverwriteMission ctrlSetPosition [0, 0, -1, -1];
    _ctrlOverwriteMission ctrlCommit 0;
};

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

    private _ctrlSettingName = _controlsGroup controlsGroupCtrl IDC_SETTING_NAME;
    _ctrlSettingName ctrlSetTextColor COLOR_TEXT_ENABLED_WAS_EDITED;
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

    private _ctrlSettingName = _controlsGroup controlsGroupCtrl IDC_SETTING_NAME;
    _ctrlSettingName ctrlSetTextColor COLOR_TEXT_ENABLED_WAS_EDITED;
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
        _ctrlOverwriteClient ctrlEnable (_ctrlOverwriteClient getVariable [QGVAR(enabled), true]);

        _state = parseNumber _wasChecked;
        SET_TEMP_NAMESPACE_PRIORITY(_setting,_state,_source);
    };

    _controlsGroup call (_controlsGroup getVariable QFUNC(updateUI_locked));

    private _ctrlSettingName = _controlsGroup controlsGroupCtrl IDC_SETTING_NAME;
    _ctrlSettingName ctrlSetTextColor COLOR_TEXT_ENABLED_WAS_EDITED;
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
    } else {
        _ctrlOverwriteMission cbSetChecked false;

        _ctrlOverwriteClient cbSetChecked (_priority > 0);
        _ctrlOverwriteClient ctrlEnable (_ctrlOverwriteClient getVariable [QGVAR(enabled), true]);
    };

    _controlsGroup call (_controlsGroup getVariable QFUNC(updateUI_locked));
}];

// update "locked" ui icon
_controlsGroup setVariable [QFUNC(updateUI_locked), {
    params ["_controlsGroup"];
    private _setting = _controlsGroup getVariable QGVAR(setting);
    private _priority = TEMP_PRIORITY(_setting);
    private _tempValue = TEMP_VALUE(_setting);

    {
        private _source = _x getVariable QGVAR(source);
        private _sourceValue = TEMP_VALUE_SOURCE(_setting,_source);
        private _ctrlLocked = _x controlsGroupCtrl IDC_SETTING_LOCKED;

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

            switch [_source, _priority] do {
                case ["client", "server"];
                case ["mission", "server"]: {
                    _ctrlLocked ctrlSetText ICON_OVERWRITTEN;
                    _ctrlLocked ctrlSetTextColor _overwriteColor;
                    _ctrlLocked ctrlSetTooltip ([LLSTRING(overwritten_by_server_tooltip), LLSTRING(overwritten_by_server_equal_tooltip)] select _overwriteEqual);
                };
                case ["client", "mission"];
                case ["server", "mission"]: {
                    _ctrlLocked ctrlSetText ICON_OVERWRITTEN;
                    _ctrlLocked ctrlSetTextColor _overwriteColor;
                    _ctrlLocked ctrlSetTooltip ([LLSTRING(overwritten_by_mission_tooltip), LLSTRING(overwritten_by_mission_equal_tooltip)] select _overwriteEqual);
                };
                case ["mission", "client"]: {
                    _ctrlLocked ctrlSetText ICON_OVERWRITTEN;
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
                        _ctrlLocked ctrlSetText ICON_OVERWRITTEN;
                        _ctrlLocked ctrlSetTextColor COLOR_OVERWRITTEN;
                        _ctrlLocked ctrlSetTooltip LLSTRING(overwritten_by_client_tooltip_server);
                    };
                };
            };
        };
    } forEach (_controlsGroup getVariable QGVAR(groups));
}];

[_controlsGroup, _currentPriority] call (_controlsGroup getVariable QFUNC(updateUI_priority));
_ctrlOverwriteClient setVariable [QGVAR(state), cbChecked _ctrlOverwriteClient];

// disable certain checkboxes
if (_isGlobal > 0) then {
    if (_source != "mission") then {
        _ctrlOverwriteClient ctrlEnable false;
        _ctrlOverwriteClient setVariable [QGVAR(enabled), false];
    };

    if (_isGlobal > 1) then {
        _ctrlOverwriteClient ctrlEnable false;
        _ctrlOverwriteClient ctrlSetPosition [0, 0, -1, -1];
        _ctrlOverwriteClient ctrlCommit 0;

        _ctrlOverwriteClient setVariable [QGVAR(enabled), false];

        _ctrlOverwriteMission ctrlEnable false;
        _ctrlOverwriteMission ctrlSetPosition [0, 0, -1, -1];
        _ctrlOverwriteMission ctrlCommit 0;
    };
};
