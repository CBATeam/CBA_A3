#include "script_component.hpp"

_this spawn {
    isNil {
        params ["_display"];

        private _missionName = _display displayCtrl IDC_INT_MISSIONNAME;
        private _text = ctrlText _missionName call CBA_fnc_decodeURL;
        _missionName ctrlSetText _text;
    };
};

if (isNil QGVAR(MenuButtons)) exitWith {};

params ["_display"];

// list of all buttons
private _buttons = [];
_display setVariable [QGVAR(MenuButtons), _buttons];

// inital button placement
private _offset = -1.1 * (count GVAR(MenuButtons) + 4);
if (!isMultiplayer && {getNumber (missionConfigFile >> "replaceAbortButton") > 0}) then {
    _offset = _offset - 1.1;
};

// --- move up old buttons
{
    _offset = _offset + 1.1;
    private _button = _display displayCtrl _x;

    _button ctrlSetPosition [
        POS_X(2),
        POS_Y(18.6 + _offset)
    ];

    _button ctrlCommit 0;
    _buttons pushBack _button;
} forEach [
    IDC_OPTIONS_VIDEO,
    IDC_OPTIONS_AUDIO,
    IDC_OPTIONS_CONFIGURE,
    IDC_OPTIONS_GAMEOPTIONS
];

// --- create custom buttons
private _buttonType = ["RscButtonMenu", "RscButtonMenuLeft"] select isClass (configFile >> "CfgPatches" >> "A3_Data_F_Contact");

{
    _offset = _offset + 1.1;
    _x params ["_displayName", "_tooltip", "_dialog"];

    private _button = _display ctrlCreate [_buttonType, -1];

    _button ctrlSetText toUpper _displayName;
    _button ctrlSetTooltip _tooltip;
    _button buttonSetAction format ["findDisplay %1 createDisplay '%2'", ctrlIDD _display, _dialog];
    _button ctrlEnable false;
    _button ctrlSetFade 1;

    _button ctrlSetPosition [
        POS_X(2),
        POS_Y(18.6 + _offset),
        POS_W(14),
        POS_H(1)
    ];

    _button ctrlCommit 0;
    _buttons pushBack _button;
} forEach GVAR(MenuButtons);

// --- replace expand button action
private _button = _display displayCtrl 101;

_button ctrlRemoveEventHandler ["ButtonClick", 0]; // remove vanilla button
_button ctrlAddEventHandler ["ButtonClick", {
    // this is an edit of a BI script, don't change unnecessarily
    params ["_ctrl"];
    _display = ctrlparent _ctrl;

    if (!ctrlCommitted _ctrl) exitWith {};

    _buttons = + (_display getVariable QGVAR(MenuButtons));

    _offset = 0;
    if (!isMultiplayer && {getNumber (missionConfigFile >> "replaceAbortButton") > 0}) then {
        _offset = 1.1;
    };

    _upperPartTime = 0.05 * count _buttons;
    _buttonsTime = 0.05;

    //hide buttons and collapse accordion
    if (uiNamespace getvariable "BIS_DisplayInterrupt_isOptionsExpanded") then {
        //move down - background, title, player's name, play, editor, profile, options

        //Title background
        _control = _display displayCtrl 1050;
        _control ctrlSetPosition [1 * GUI_GRID_W + GUI_GRID_X, (14.2 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        //Title - same position as title background
        _control = _display displayCtrl 523;
        _control ctrlSetPosition [1 * GUI_GRID_W + GUI_GRID_X, (14.2 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        //Player's name - same position as title background
        _control = _display displayCtrl 109;
        _control ctrlSetPosition [6 * GUI_GRID_W + GUI_GRID_X, (14.2 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        //Continue button
        _control = _display displayCtrl 2;
        _control ctrlSetPosition [1 * GUI_GRID_W + GUI_GRID_X, (15.3 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        //Save button
        _control = _display displayCtrl 103;
        _control ctrlSetPosition [1 * GUI_GRID_W + GUI_GRID_X, (16.4 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        //Skip button - same position as Save
        _control = _display displayCtrl 1002;
        _control ctrlSetPosition [1 * GUI_GRID_W + GUI_GRID_X, (16.4 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        //Revert
        _control = _display displayCtrl 119;
        _control ctrlSetPosition [1 * GUI_GRID_W + GUI_GRID_X, (17.5 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        //Again - same position as Revert
        _control = _display displayCtrl 1003;
        _control ctrlSetPosition [1 * GUI_GRID_W + GUI_GRID_X, (17.5 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        //Respawn
        _control = _display displayCtrl 1010;
        _control ctrlSetPosition [1 * GUI_GRID_W + GUI_GRID_X, (17.5 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        //Options button
        _control = _display displayCtrl 101;
        _control ctrlSetPosition [1 * GUI_GRID_W + GUI_GRID_X, (18.6 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        private _fnc_hideButton = {
            private _button = (_this select 0) deleteAt 0;

            if (isNil "_button") exitWith {
                (_this select 1) call CBA_fnc_removePerFrameHandler;
            };

            _button ctrlSetFade 1;
            _button ctrlCommit 0.15;
            _button ctrlEnable false;
        };

        [_buttons, -1] call _fnc_hideButton;
        [_fnc_hideButton, _buttonsTime, _buttons] call CBA_fnc_addPerFrameHandler;

        uiNamespace setVariable ["BIS_DisplayInterrupt_isOptionsExpanded", false];
    } else {
        //expand accordion and show buttons

        // additional buttons from CBA minus 4 already existing ones
        _offset = _offset + (count _buttons - 4) * 1.1;

        //Title background
        _control = _display displayCtrl 1050;
        _control ctrlSetPosition [1 * GUI_GRID_W + GUI_GRID_X, (9.8 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        //Title - same position as title background
        _control = _display displayCtrl 523;
        _control ctrlSetPosition [1 * GUI_GRID_W + GUI_GRID_X, (9.8 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        //Player's name - same position as title background
        _control = _display displayCtrl 109;
        _control ctrlSetPosition [6 * GUI_GRID_W + GUI_GRID_X, (9.8 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        //Continue button
        _control = _display displayCtrl 2;
        _control ctrlSetPosition [1 * GUI_GRID_W + GUI_GRID_X, (10.9 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        //Save button
        _control = _display displayCtrl 103;
        _control ctrlSetPosition [1 * GUI_GRID_W + GUI_GRID_X, (12.0 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        //Skip button - same position as Save
        _control = _display displayCtrl 1002;
        _control ctrlSetPosition [1 * GUI_GRID_W + GUI_GRID_X, (12.0 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        //Revert
        _control = _display displayCtrl 119;
        _control ctrlSetPosition [1 * GUI_GRID_W + GUI_GRID_X, (13.1 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        //Again - same position as Revert
        _control = _display displayCtrl 1003;
        _control ctrlSetPosition [1 * GUI_GRID_W + GUI_GRID_X, (13.1 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        //Respawn
        _control = _display displayCtrl 1010;
        _control ctrlSetPosition [1 * GUI_GRID_W + GUI_GRID_X, (13.1 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        //Options button
        _control = _display displayCtrl 101;
        _control ctrlSetPosition [1 * GUI_GRID_W + GUI_GRID_X, (14.2 - _offset) * GUI_GRID_H + GUI_GRID_Y];
        _control ctrlCommit _upperPartTime;

        if (!isMultiplayer && {getNumber (missionConfigFile >> "replaceAbortButton") > 0}) then {
            {
                _x ctrlSetPosition [
                    2 * GUI_GRID_W + GUI_GRID_X,
                    (15.3 - _offset) * GUI_GRID_H + GUI_GRID_Y
                ];

                _offset = _offset - 1.1;
            } forEach _buttons;
        };

        //From bottom to top
        reverse _buttons;

        private _fnc_showButton = {
            private _button = (_this select 0) deleteAt 0;

            if (isNil "_button") exitWith {
                (_this select 1) call CBA_fnc_removePerFrameHandler;
            };

            _button ctrlSetFade 0;
            _button ctrlCommit 0.15;
            _button ctrlEnable true;
        };

        [_buttons, -1] call _fnc_showButton;
        [_fnc_showButton, _buttonsTime, _buttons] call CBA_fnc_addPerFrameHandler;

        uiNamespace setVariable ["BIS_DisplayInterrupt_isOptionsExpanded", true];
    };

    ctrlSetFocus _ctrl;
}];
