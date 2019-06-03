#include "script_component.hpp"

_this spawn {
    isNil {
        params ["_display"];

        private _missionName = _display displayCtrl IDC_DIARY_MISSION_NAME;
        private _text = [ctrlText _missionName, "%20", " "] call CBA_fnc_replace;
        _missionName ctrlSetText _text;
    };
};
