#include "script_component.hpp"

params ["_controlsGroup", "_setting", "_source", "_currentPriority"];

private _ctrlPriority = _controlsGroup controlsGroupCtrl IDC_SETTING_PRIORITY;

for "_index" from 0 to (["client", "mission", "server"] find _source) do {
    private _label = [LSTRING(overwrite_off), LSTRING(overwrite_client), LSTRING(overwrite_mission)] select _index;
    private _tooltip = "";

    if (_source isEqualTo "mission") then {
        _tooltip = [LSTRING(mission_overwrite_off_tooltip), LSTRING(mission_overwrite_client_tooltip), ""] select _index;
    } else {
        if (_source isEqualTo "server") then {
            _tooltip = [LSTRING(server_overwrite_off_tooltip), LSTRING(server_overwrite_client_tooltip), LSTRING(server_overwrite_mission_tooltip)] select _index;
        };
    };

    _ctrlPriority lbSetTooltip [_ctrlPriority lbAdd format ["%1: %2", _index, localize _label], localize _tooltip];
};

_ctrlPriority lbSetCurSel ([0,1,2] select _currentPriority);

if (_source isEqualTo "client") then {
    _ctrlPriority ctrlEnable false;

    // hide, without getting unhidden by controlsGroup
    _ctrlPriority ctrlSetPosition [0,0,-1,-1];
    _ctrlPriority ctrlCommit 0;
} else {
    _ctrlPriority setVariable [QGVAR(params), [_setting, _source]];
    _ctrlPriority ctrlAddEventHandler ["LBSelChanged", {
        EXIT_LOCKED;
        params ["_ctrlPriority", "_value"];
        (_ctrlPriority getVariable QGVAR(params)) params ["_setting", "_source"];

        SET_TEMP_NAMESPACE_PRIORITY(_setting,_value,_source);

        private _controlsGroup = ctrlParentControlsGroup _ctrlPriority;

        {
            _x call (_controlsGroup getVariable QFUNC(updateUI_locked));
        } forEach (_controlsGroup getVariable QGVAR(groups));
    }];

    _controlsGroup setVariable [QFUNC(updateUI_priority), {
        params ["_controlsGroup", "_priority"];

        private _ctrlPriority = _controlsGroup controlsGroupCtrl IDC_SETTING_PRIORITY;
        LOCK;
        _ctrlPriority lbSetCurSel ([0,1,2] select _priority);
        UNLOCK;

        _controlsGroup call (_controlsGroup getVariable QFUNC(updateUI_locked));
    }];
};

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
