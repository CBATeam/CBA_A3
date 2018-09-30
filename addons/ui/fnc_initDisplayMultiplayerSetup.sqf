#include "script_component.hpp"

params ["_display"];

private _fnc_update = {
    params [["_display", findDisplay IDD_MP_SETUP, [displayNull]]];

    if (isNil QGVAR(update_EHID)) then {
        GVAR(update_EHID) = addMissionEventHandler ["EachFrame", _display getVariable QFUNC(update)];
    };

    if (isNull _display) exitWith {
        removeMissionEventHandler ["EachFrame", GVAR(update_EHID)];
    };

    private _playerList = _display displayCtrl IDC_MPSETUP_ROLES;

    for "-" from 1 to lbSize _playerList do {
        private _text = _playerList lbText 0;
        private _value = _playerList lbValue 0;

        // delete old lb entry
        _playerList lbDelete 0;

        if (_value == -1) then {
            // lb entry was group name
            // look up first unit role and check for hidden callsign
            private _callsign = _playerList lbText 0 splitString SEPARATORS param [1, ""];

            if (_callsign != "") then {
                _text = _callsign;
            };
        } else {
            // lb entry was role name
            // remove hidden callsign if present
            _text = _text splitString SEPARATORS select 0;
        };

        // create new lb entry
        // value determines which slot is linked to the lb entry
        _playerList lbSetValue [_playerList lbAdd _text, _value];
    };
};

_display setVariable [QFUNC(update), _fnc_update];

_display call _fnc_update;

// lb is refreshed every frame, so we have to adjust every frame too
_display displayAddEventHandler ["MouseMoving", _fnc_update];
_display displayAddEventHandler ["MouseHolding", _fnc_update];
