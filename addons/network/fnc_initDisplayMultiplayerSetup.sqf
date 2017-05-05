
params ["_display"];

private _fnc_update = {
    params ["_display"];
    private _playerList = _display displayCtrl 109;

    for "_" from 0 to (lbSize _playerList - 1) do {
        private _text = _playerList lbText 0;
        private _value = _playerList lbValue 0;

        // delete old
        _playerList lbDelete 0;

        if (_value == -1) then {
            (_playerList lbText 0 splitString "|") params [["_role", ""], ["_callsign", ""]];

            if (_callsign != "") then {
                _text = _callsign;
            };
        } else {
            _text = _text splitString "|" select 0;
        };

        _playerList lbSetValue [_playerList lbAdd _text, _value];
    };
};

_display displayAddEventHandler ["MouseMoving", _fnc_update];
_display displayAddEventHandler ["MouseHolding", _fnc_update];
