#include "script_component.hpp"

#define IDCBASE 12000

params ["_display"];

for "_idc" from IDCBASE to (IDCBASE + 99) do {
    private _control = _display displayCtrl _idc;

    private _fnc_keepAspectRatio = {
        params ["_control"];
        uiNamespace getVariable "RscDisplayOptionsLayout_data" select (ctrlIDC _control - IDCBASE) params ["_tagName", "_varName", "", "_canResize", "_grid"];
        if !(_canResize) exitWith {};

        private _config = configFile >> "CfgUIGrids" >> _tagName >> "Variables" >> _varName;
        private _keepAspectRatio = getNumber (_config >> "keepAspectRatio") == 1;
        if !(_keepAspectRatio) exitWith {};

        private _varBase = _tagName + "_" + _varName + "_";
        _grid params ["_pos", "_gridW", "_gridH"];
        _pos params ["_posX", "_posY", "_posW", "_posH"];

        if (_posX isEqualType "") then {_posX = call compile _posX};
        if (_posY isEqualType "") then {_posY = call compile _posY};
        if (_posW isEqualType "") then {_posW = call compile _posW};
        if (_posH isEqualType "") then {_posH = call compile _posH};

        private _aspectRatio = _posW/_posH;

        private _posXTemp = uiNamespace getVariable [_varBase + "X", _posX];
        private _posYTemp = uiNamespace getVariable [_varBase + "Y", _posY];
        private _posWTemp = uiNamespace getVariable [_varBase + "W", _posW];
        private _posHTemp = uiNamespace getVariable [_varBase + "H", _posH];

        if (_posXTemp isEqualType "") then {_posXTemp = call compile _posXTemp};
        if (_posYTemp isEqualType "") then {_posYTemp = call compile _posYTemp};
        if (_posWTemp isEqualType "") then {_posWTemp = call compile _posWTemp};
        if (_posHTemp isEqualType "") then {_posHTemp = call compile _posHTemp};

        private _aspectRatioTemp = _posWTemp/_posHTemp;

        if (_aspectRatio != _aspectRatioTemp) then {
            // correct aspect ratio
            _posHTemp = _posWTemp/_aspectRatio;

            // update values
            uiNamespace setVariable [_varBase + "X", _posXTemp];
            uiNamespace setVariable [_varBase + "Y", _posYTemp];
            uiNamespace setVariable [_varBase + "W", _posWTemp];
            uiNamespace setVariable [_varBase + "H", _posHTemp];

            // apply values
            private _script = _control getVariable [QGVAR(setPos), scriptNull];
            terminate _script;
            _script = [_control, [_posXTemp, _posYTemp, _posWTemp, _posHTemp]] spawn {
                isNil {
                    params ["_control", "_posTemp"];
                    _control ctrlSetPosition _posTemp;
                    _control ctrlCommit 0;
                };
            };
            _control setVariable [QGVAR(setPos), _script];
        };
    };

    _control ctrlAddEventHandler ["MouseMoving", _fnc_keepAspectRatio];
    _control ctrlAddEventHandler ["MouseHolding", _fnc_keepAspectRatio];
};
