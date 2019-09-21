#include "script_component.hpp"

#define SEPARATOR_GROUP_NAME "@"
#define SEPARATOR_UID "§"

params ["_display"];

private _fnc_update = {
    params [["_display", findDisplay IDD_MP_SETUP, [displayNull]]];

    if (isNil QGVAR(update_EHID)) then {
        GVAR(update_EHID) = addMissionEventHandler ["EachFrame", _display getVariable QFUNC(update)];
    };

    if (isNull _display) exitWith {
        removeMissionEventHandler ["EachFrame", GVAR(update_EHID)];
    };

    private _playerList = _display displayCtrl IDC_MPSETUP_POOL;
    private _slotList = _display displayCtrl IDC_MPSETUP_ROLES;

    for "-" from 1 to lbSize _slotList do {
        private _uid = "";
        private _text = _slotList lbText 0;
        private _value = _slotList lbValue 0;

        // delete old lb entry
        _slotList lbDelete 0;

        if (_value == -1) then {
            // lb entry was group name
            // look up first unit role and check for hidden callsign
            private _callsign = _slotList lbText 0 splitString SEPARATOR_GROUP_NAME param [1, ""] splitString SEPARATOR_UID select 0;

            if (_callsign != "") then {
                _text = _callsign;
            };
        } else {
            // lb entry was role name
            // remove hidden callsign if present
            _uid = _text splitString SEPARATOR_UID param [1, ""];
            _text = _text splitString SEPARATOR_GROUP_NAME select 0;
        };

        // set UID requirement for slot index
        if (_uid != "") then {
            _playerList ctrlEnable false;
            _slotList setVariable [format [QGVAR(RequiredUID_%1), _value], _uid];
            _text = _text + " RESERVED";
        };

        // create new lb entry
        // value determines which slot is linked to the lb entry
        private _index = _slotList lbAdd _text;
        _slotList lbSetValue [_index, _value];
    };

    // replace URL encoding
    private _missionName = _display displayCtrl IDC_MPSETUP_NAME;

    private _text = ctrlText _missionName;
    with uiNamespace do {
        _text = _text call CBA_fnc_decodeURL;
    };

    _missionName ctrlSetText _text;
};

_display setVariable [QFUNC(update), _fnc_update];

_display call _fnc_update;

// lb is refreshed every frame, so we have to adjust every frame too
_display displayAddEventHandler ["MouseMoving", _fnc_update];
_display displayAddEventHandler ["MouseHolding", _fnc_update];

// check UID requirement
private _slotList = _display displayCtrl IDC_MPSETUP_ROLES;

_slotList ctrlAddEventHandler ["LBSelChanged", {
    params ["_slotList", "_index"];
    private _value = _slotList lbValue _index;

    private _localUID = profileNamespace getVariable [QGVAR(SteamUID), ""];
    private _requiredUID = _slotList getVariable [format [QGVAR(RequiredUID_%1), _value], ""];

    if !(_requiredUID in ["", _localUID]) then {
        // prevent selection
        private _temp = _slotList lbAdd "";
        _slotList lbSetValue [_temp, -1];
        _slotList lbSetCurSel _temp;
    };
}];
