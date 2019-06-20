#include "script_component.hpp"

_this spawn {
    isNil {
        params ["_display"];

        private _missionName = _display displayCtrl IDC_DIARY_MISSION_NAME;
        private _text = ctrlText _missionName call CBA_fnc_decodeURL;
        _missionName ctrlSetText _text;
    };
};
