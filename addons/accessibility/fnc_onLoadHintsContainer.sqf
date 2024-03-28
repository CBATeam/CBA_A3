#include "script_component.hpp"

#define VISIBLE_BOX_COUNT 6
#define FADE_TIME 0.1

params ["_ctrl"];
uiNamespace setVariable [QGVAR(hintContainer), _ctrl];
_ctrl setVariable [QGVAR(boxCtrls), []];

// On new hint
[
    QGVAR(hintCreated),
    {
        params ["_hint"];

        _hint params ["_text", "_source", "_createdAt", "_expiresAt"];

        private _hintContainerCtrl = uiNamespace getVariable QGVAR(hintContainer);
        private _boxCtrls = _hintContainerCtrl getVariable QGVAR(boxCtrls);

        private _display = ctrlParent _hintContainerCtrl;
        (ctrlPosition _hintContainerCtrl) params ["_containerX", "_containerY", "_containerW", "_containerH"];

        // see if the layout position has been changed and we need to update the controls
        private _layoutX = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(hints),X)', HINT_CONTAINER_X];
        private _layoutY = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(hints),Y)', HINT_CONTAINER_Y];
        private _layoutW = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(hints),W)', HINT_CONTAINER_W];
        private _layoutH = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(hints),H)', HINT_CONTAINER_H];
        if(_layoutX isNotEqualTo _containerX ||
            {_layoutY isNotEqualTo _containerY} ||
            {_layoutW isNotEqualTo _containerW} ||
            {_layoutH isNotEqualTo _containerH}) then {
                _containerX = _layoutX;
                _containerY = _layoutY;
                _containerW = _layoutW;
                _containerH = _layoutH;

                _hintContainerCtrl ctrlSetPosition [_containerX, _containerY, _containerW, _containerH];
                _hintContainerCtrl ctrlCommit 0;
        };

        private _boxHeight = _containerH / VISIBLE_BOX_COUNT;
        private _iconWidth = _boxHeight * (3/4);
        private _textBoxWidth = _containerW - _iconWidth;

        // push up existing hints
        {
            _x params ["_hint", "_iconCtrl", "_textCtrl", "_backgroundCtrl"];

            private _iconPosition = ctrlPosition _iconCtrl;
            private _newY= (_iconPosition # 1) - _boxHeight;
            _iconPosition set [1, _newY];
            _iconPosition set [2, _iconWidth];
            _iconPosition set [3, _boxHeight];
            _iconCtrl ctrlSetPosition _iconPosition;
            _iconCtrl ctrlCommit 0;

            private _textPosition = ctrlPosition _textCtrl;
            _textPosition set [1, _newY];
            _textPosition set [2, _textBoxWidth];
            _textPosition set [3, _boxHeight];
            _textCtrl ctrlSetPosition _textPosition;
            _textCtrl ctrlCommit 0;

            private _backgroundPosition = ctrlPosition _backgroundCtrl;
            _backgroundPosition set [1, _newY];
            _backgroundPosition set [2, _containerW];
            _backgroundPosition set [3, _boxHeight];
            _backgroundCtrl ctrlSetPosition _backgroundPosition;
            _backgroundCtrl ctrlCommit 0;
        } foreach _boxCtrls;

        // add new hint at lowest level
        private _yCoord = _containerH - _boxHeight;

        private _newBackground = _display ctrlCreate ["RscPicture", -1, _hintContainerCtrl];
        _newBackground ctrlSetPosition [0, _yCoord, _containerW, _boxHeight];
        _newBackground ctrlSetText "#(rgb,1,1,1)color(0,0,0,0.2)";
        _newBackground ctrlCommit 0;

        private _newIcon = _display ctrlCreate ["RscPicture", -1, _hintContainerCtrl];
        _newIcon ctrlSetPosition [0, _yCoord, _iconWidth, _boxHeight];

        //TODO: Instead set graphic that represents the sound or points toward it
        //      Just setting an arrow for now
        _newIcon ctrlSetText "\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\igui_wind_ca.paa";
        _newIcon ctrlCommit 0;

        private _newTextBox = _display ctrlCreate ["RscText", -1, _hintContainerCtrl];
        _newTextBox ctrlSetPosition [_iconWidth, _yCoord, _textBoxWidth, _boxHeight];
        _newTextBox ctrlSetText format ["%1", _text];
        _newTextBox ctrlSetBackgroundColor [0, 0, 0, 0.2];
        _newTextBox ctrlCommit 0;
        _newTextBox ctrlSetFontHeight _boxHeight;
        private _textWidth = ctrlTextWidth _newTextBox;

        // making sure the text fits into the box
        if(_textWidth > _textBoxWidth) then {
            private _textFactor = _textBoxWidth / _textWidth;
            _newTextBox ctrlSetFontHeight (_boxHeight * _textFactor);
        };

        _boxCtrls pushBack [_hint, _newIcon, _newTextBox, _newBackground];
    }
] call CBA_fnc_addEventHandler;

// On hint expired
[
    QGVAR(hintExpired),
    {
        params ["_hint"];

        private _hintContainerCtrl = uiNamespace getVariable QGVAR(hintContainer);
        private _boxCtrls = _hintContainerCtrl getVariable QGVAR(boxCtrls);

        private _boxIdx = _boxCtrls findIf {(_x # 0) isEqualRef _hint};
        if(_boxIdx < 0) exitWith {};

        private _hintEntry = _boxCtrls select _boxIdx;
        _hintEntry params ["", "_iconCtrl", "_textCtrl", "_backgroundCtrl"];

        // start death fade
        _iconCtrl ctrlSetFade 1;
        _iconCtrl ctrlCommit FADE_TIME;
        _textCtrl ctrlSetFade 1;
        _textCtrl ctrlCommit FADE_TIME;
        _backgroundCtrl ctrlSetFade 1;
        _backgroundCtrl ctrlCommit FADE_TIME;

        [
            {
                params ["", "", "_hintEntry"];
                _hintEntry params ["_hint", "_iconCtrl", "_textCtrl", "_backgroundCtrl"];
                // wait till all controls are committed (have stopped animating)
                ctrlCommitted _iconCtrl && ctrlCommitted _textCtrl && ctrlCommitted _backgroundCtrl
            },
            {   // then delete it and re-arrange the rest
                params ["_hintContainerCtrl", "_boxCtrls", "_hintEntry"];
                private _ctrlsGrpPosition = ctrlPosition _hintContainerCtrl;
                _ctrlsGrpPosition params ["", "", "_containerW", "_containerH"];
                private _boxHeight = _containerH / VISIBLE_BOX_COUNT;

                private _boxIdx = _boxCtrls find _hintEntry;

                // move all above the one removed down by one
                for "_i" from (_boxIdx) to 0 step -1 do {
                    (_boxCtrls select _i) params ["_hint", "_iconCtrl", "_textCtrl", "_backgroundCtrl"];

                    private _iconPosition = ctrlPosition _iconCtrl;
                    private _newY = (_iconPosition # 1) + _boxHeight;
                    _iconPosition set [1, _newY];
                    _iconCtrl ctrlSetPosition _iconPosition;
                    _iconCtrl ctrlCommit 0;

                    private _textPosition = ctrlPosition _textCtrl;
                    _textPosition set [1, _newY];
                    _textCtrl ctrlSetPosition _textPosition;
                    _textCtrl ctrlCommit 0;

                    // background for icon doubles as progress bar when extended into the region of the
                    // text box
                    private _backgroundPosition = ctrlPosition _backgroundCtrl;
                    _backgroundPosition set [1, _newY];
                    _backgroundCtrl ctrlSetPosition _backgroundPosition;
                    _backgroundCtrl ctrlCommit 0;
                };
                _boxCtrls deleteAt _boxIdx;
                _hintEntry params ["_hint", "_iconCtrl", "_textCtrl", "_backgroundCtrl"];
                ctrlDelete _iconCtrl;
                ctrlDelete _textCtrl;
            },
            [_hintContainerCtrl, _boxCtrls, _hintEntry]
        ] call CBA_fnc_waitUntilAndExecute;

    }
] call CBA_fnc_addEventHandler;

// on progress/time update
[
    QGVAR(hintProgress),
    {
        params ["_currentTime"];

        private _hintContainerCtrl = uiNamespace getVariable QGVAR(hintContainer);
        private _boxCtrls = _hintContainerCtrl getVariable QGVAR(boxCtrls);
        {
            if(! ctrlCommitted _backgroundCtrl) exitWith {};

            _x params ["_hint", "_iconCtrl", "_textCtrl", "_backgroundCtrl"];
            _hint params ["_text", "_source", "_createdAt", "_expiresAt"];
            private _initialDuration = _expiresAt - _createdAt;
            private _remainingDuration = _expiresAt - _currentTime;

            // use progress time to set length of background rectangle, aka improvised progress bar
            private _progress = 0 max (_remainingDuration / _initialDuration);
            private _iconPosition = ctrlPosition _iconCtrl;
            private _textPosition = ctrlPosition _textCtrl;
            private _backgroundPosition = ctrlPosition _backgroundCtrl;
            // since the progress bar doubles as the background to the icon, a progress of 0 still has to terminate
            // at icon background width
            _backgroundPosition set [2, (_iconPosition # 2) + _progress * (_textPosition # 2)];
            _backgroundCtrl ctrlSetPosition _backgroundPosition;
            _backgroundCtrl ctrlCommit 0;

        } foreach _boxCtrls;
    }
] call CBA_fnc_addEventHandler;
