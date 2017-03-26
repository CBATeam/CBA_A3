#include "script_component.hpp"

params ["_controlsGroup", "_setting", "_source", "_currentPriority"];

private _ctrlOverwriteClient = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_CLIENT;
private _ctrlOverwriteClientText = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_CLIENT_TEXT;
private _ctrlOverwriteMission = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_MISSION;
private _ctrlOverwriteMissionText = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_MISSION_TEXT;

if (_source isEqualTo "client") then {
    _ctrlOverwriteClient ctrlEnable false;
    _ctrlOverwriteClient ctrlSetPosition [0,0,-1,-1];
    _ctrlOverwriteClient ctrlCommit 0;

    _ctrlOverwriteClientText ctrlSetPosition [0,0,-1,-1];
    _ctrlOverwriteClientText ctrlCommit 0;
};

if !(_source isEqualTo "server") then {
    _ctrlOverwriteMission ctrlEnable false;
    _ctrlOverwriteMission ctrlSetPosition [0,0,-1,-1];
    _ctrlOverwriteMission ctrlCommit 0;

    _ctrlOverwriteMissionText ctrlSetPosition [0,0,-1,-1];
    _ctrlOverwriteMissionText ctrlCommit 0;
};

if (_currentPriority > 0) then {
    _ctrlOverwriteClient cbSetChecked true;

    if (_currentPriority > 1) then {
        _ctrlOverwriteMission cbSetChecked true;

        _ctrlOverwriteClient ctrlEnable false;
        _ctrlOverwriteClientText ctrlSetTextColor COLOR_TEXT_DISABLED;
    };
};

_ctrlOverwriteClient setVariable [QGVAR(state), cbChecked _ctrlOverwriteClient];

_ctrlOverwriteClient ctrlAddEventHandler ["CheckedChanged", {
    params ["_ctrlOverwriteClient", "_state"];
    private _controlsGroup = ctrlParentControlsGroup _ctrlOverwriteClient;
    private _ctrlOverwriteMission = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_MISSION;
    private _setting = _controlsGroup getVariable QGVAR(setting);
    private _source = _controlsGroup getVariable QGVAR(source);

    SET_TEMP_NAMESPACE_PRIORITY(_setting,_state,_source);

    _controlsGroup call (_controlsGroup getVariable QFUNC(updateUI_locked));
}];

_ctrlOverwriteMission ctrlAddEventHandler ["CheckedChanged", {
    params ["_ctrlOverwriteMission", "_state"];
    private _controlsGroup = ctrlParentControlsGroup _ctrlOverwriteMission;
    private _ctrlOverwriteClient = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_CLIENT;
    private _ctrlOverwriteClientText = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_CLIENT_TEXT;
    private _setting = _controlsGroup getVariable QGVAR(setting);
    private _source = _controlsGroup getVariable QGVAR(source);

    if (_state isEqualTo 1) then {
        _ctrlOverwriteClient setVariable [QGVAR(state), cbChecked _ctrlOverwriteClient];
        _ctrlOverwriteClient cbSetChecked true;
        _ctrlOverwriteClient ctrlEnable false;
        _ctrlOverwriteClientText ctrlSetTextColor COLOR_TEXT_DISABLED;

        SET_TEMP_NAMESPACE_PRIORITY(_setting,2,_source);
    } else {
        private _wasChecked = _ctrlOverwriteClient getVariable QGVAR(state);
        _ctrlOverwriteClient cbSetChecked _wasChecked;
        _ctrlOverwriteClient ctrlEnable true;
        _ctrlOverwriteClientText ctrlSetTextColor COLOR_TEXT_ENABLED;

        _state = [0,1] select _wasChecked;
        SET_TEMP_NAMESPACE_PRIORITY(_setting,_state,_source);
    };

    _controlsGroup call (_controlsGroup getVariable QFUNC(updateUI_locked));
}];

_controlsGroup setVariable [QFUNC(updateUI_priority), {
    params ["_controlsGroup", "_priority"];

    private _ctrlOverwriteClient = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_CLIENT;
    private _ctrlOverwriteClientText = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_CLIENT_TEXT;
    private _ctrlOverwriteMission = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_MISSION;
    private _ctrlOverwriteMissionText = _controlsGroup controlsGroupCtrl IDC_SETTING_OVERWRITE_MISSION_TEXT;

    if (_priority > 1) then {
        _ctrlOverwriteMission cbSetChecked true;

        _ctrlOverwriteClient cbSetChecked true;
        _ctrlOverwriteClient ctrlEnable false;
        _ctrlOverwriteClientText ctrlSetTextColor COLOR_TEXT_DISABLED;
    } else {
        _ctrlOverwriteMission cbSetChecked false;

        _ctrlOverwriteClient cbSetChecked (_priority > 0);
        _ctrlOverwriteClient ctrlEnable true;
        _ctrlOverwriteClientText ctrlSetTextColor COLOR_TEXT_ENABLED;
    };

    _controlsGroup call (_controlsGroup getVariable QFUNC(updateUI_locked));
}];

// update "locked" ui icon
_controlsGroup setVariable [QFUNC(updateUI_locked), {
    params ["_controlsGroup"];
    private _source = _controlsGroup getVariable QGVAR(source);
    private _setting = _controlsGroup getVariable QGVAR(setting);
    private _priority = TEMP_PRIORITY(_setting);

    private _ctrlLocked = _controlsGroup controlsGroupCtrl IDC_SETTING_LOCKED;

    if (_source isEqualTo _priority) then {
        _ctrlLocked ctrlSetText "";
        _ctrlLocked ctrlSetTooltip "";
    } else {
        switch [_source, _priority] do {
            case ["client","server"];
            case ["mission","server"]: {
                _ctrlLocked ctrlSetText QPATHTOF(locked_ca.paa);
                _ctrlLocked ctrlSetTooltip localize LSTRING(overwritten_by_server_tooltip);
            };
            case ["client","mission"]: {
                _ctrlLocked ctrlSetText QPATHTOF(locked_ca.paa);
                _ctrlLocked ctrlSetTooltip localize LSTRING(overwritten_by_mission_tooltip);
            };
            case ["server","mission"]: {
                _ctrlLocked ctrlSetText QPATHTOF(locked_ca.paa);
                _ctrlLocked ctrlSetTooltip localize LSTRING(overwritten_by_mission_tooltip_server);
            };
            case ["mission","client"]: {
                _ctrlLocked ctrlSetText QPATHTOF(locked_ca.paa);

                if (is3DEN) then {
                    _ctrlLocked ctrlSetTooltip localize LSTRING(overwritten_by_client_tooltip_3den);
                } else {
                    _ctrlLocked ctrlSetTooltip localize LSTRING(overwritten_by_client_tooltip);
                };
            };
            case ["server","client"]: {
                if (isServer) then {
                    _ctrlLocked ctrlSetText "";
                    _ctrlLocked ctrlSetTooltip "";
                } else {
                    _ctrlLocked ctrlSetText QPATHTOF(locked_ca.paa);
                    _ctrlLocked ctrlSetTooltip localize LSTRING(overwritten_by_client_tooltip_server);
                };
            };
        };
    };
}];

_controlsGroup call (_controlsGroup getVariable QFUNC(updateUI_locked));
