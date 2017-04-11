#include "script_component.hpp"

params ["_display"];

// list of all buttons
private _buttons = [];
_display setVariable [QGVAR(MenuButtons), _buttons];

// inital button placement
private _offset = 0;

// --- create custom buttons
{
    _x params ["_displayName", "_tooltip", "_dialog"];

    private _button = _display ctrlCreate ["RscButtonMenu", -1];

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
    _offset = _offset - 1.1;
} forEach GVAR(MenuButtons);

// --- move up old buttons
{
    private _button = _display displayCtrl _x;

    //_button ctrlEnable false;
    //_button ctrlSetFade 1;

    _button ctrlSetPosition [
        POS_X(2),
        POS_Y(18.6 + _offset)
    ];

    _button ctrlCommit 0;

    _buttons pushBack _button;
    _offset = _offset - 1.1;
} forEach [
    IDC_OPTIONS_GAMEOPTIONS,
    IDC_OPTIONS_CONFIGURE,
    IDC_OPTIONS_AUDIO,
    IDC_OPTIONS_VIDEO
];

reverse _buttons;

// --- replace expand button action
private _button = _display displayCtrl 101;

_button ctrlRemoveEventHandler ["ButtonClick", 0]; // remove vanilla button
_button ctrlAddEventHandler ["ButtonClick", {
    _this spawn {
        // this is an edit of a BI script, don't change unnecessarily
        disableSerialization;

        params ["_ctrl"];
        _display = ctrlparent _ctrl;

        _buttons = + (_display getVariable QGVAR(MenuButtons));

        _offset = 0;
        if (getnumber (missionconfigfile >> "replaceAbortButton") > 0) then { //MUF-test-removed: (getNumber(configfile >> "isDemo") != 1) &&
            _offset = 1.1;
        };

        //if options are expanded (Video Options button is shown), collapse it and vice versa
        //if(ctrlFade (_display displayCtrl 301) < 0.5) then
        _upperPartTime = 0.05 * count _buttons; //0.05 for each button
        _buttonsTime = 0.05;

        //hide buttons and collapse accordion
        if (uiNamespace getvariable "BIS_DisplayInterrupt_isOptionsExpanded") then {
            //move down - background, title, player's name, play, editor, profile, options
            
            //Title background
            _control = _display displayctrl 1050;
            _control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((14.2 - _offset) * GUI_GRID_H + GUI_GRID_Y)];                                                                                                                 
            _control ctrlCommit _upperPartTime;
            
            //Title - same position as title background
            _control = _display displayctrl 523;
            _control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((14.2 - _offset) * GUI_GRID_H + GUI_GRID_Y)];                                                                                                                 
            _control ctrlCommit _upperPartTime;
            
            //Player's name - same position as title background
            _control = _display displayctrl 109;
            _control ctrlSetPosition [(6 * GUI_GRID_W + GUI_GRID_X), ((14.2 - _offset) * GUI_GRID_H + GUI_GRID_Y)];                                                                                                                 
            _control ctrlCommit _upperPartTime;
            
            //Continue button
            _control = _display displayctrl 2;
            _control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((15.3 - _offset) * GUI_GRID_H + GUI_GRID_Y)];                                                                                                                 
            _control ctrlCommit _upperPartTime;
            
            //Save button
            _control = _display displayctrl 103;
            _control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((16.4 - _offset) * GUI_GRID_H + GUI_GRID_Y)];                                                                                                                 
            _control ctrlCommit _upperPartTime;
            
            //Skip button - same position as Save
            _control = _display displayctrl 1002;
            _control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((16.4 - _offset) * GUI_GRID_H + GUI_GRID_Y)];                                                                                                                 
            _control ctrlCommit _upperPartTime;
            
            //Revert
            _control = _display displayctrl 119;
            _control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((17.5 - _offset) * GUI_GRID_H + GUI_GRID_Y)];                                                                                                                 
            _control ctrlCommit _upperPartTime;
            
            //Again - same position as Revert
            _control = _display displayctrl 1003;
            _control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((17.5 - _offset) * GUI_GRID_H + GUI_GRID_Y)];                                                                                                                 
            _control ctrlCommit _upperPartTime;
            
            //Options button
            _control = _display displayctrl 101;
            _control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((18.6 - _offset) * GUI_GRID_H + GUI_GRID_Y)];                                                                                                                 
            _control ctrlCommit _upperPartTime;
            
            {
                _x ctrlSetFade 1;
            } forEach _buttons;
            
            uiSleep 0.05;

            {
                _x ctrlCommit _buttonsTime;
                uiSleep _buttonsTime;
            } forEach _buttons;

            {
                _x ctrlEnable false;
            } forEach _buttons;
            
            uiNamespace setVariable ["BIS_DisplayInterrupt_isOptionsExpanded", false];
            //set focus to Options button
            ctrlSetFocus (_display displayctrl 101);    
        } else {
            //expand accordion and show buttons
                
            // additional buttons from CBA minus 4 already existing ones
            _offset = _offset + (count _buttons - 4) * 1.1;

            //Title background
            _control = _display displayctrl 1050;
            _control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((9.8 - _offset) * GUI_GRID_H + GUI_GRID_Y)];                                                                                                                  
            _control ctrlCommit _upperPartTime;
            
            //Title - same position as title background
            _control = _display displayctrl 523;
            _control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((9.8 - _offset) * GUI_GRID_H + GUI_GRID_Y)];                                                                                                                  
            _control ctrlCommit _upperPartTime;
            
            //Player's name - same position as title background
            _control = _display displayctrl 109;
            _control ctrlSetPosition [(6 * GUI_GRID_W + GUI_GRID_X), ((9.8 - _offset) * GUI_GRID_H + GUI_GRID_Y)];                                                                                                                  
            _control ctrlCommit _upperPartTime;
            
            //Continue button
            _control = _display displayctrl 2;
            _control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((10.9 - _offset) * GUI_GRID_H + GUI_GRID_Y)];                                                                                                                 
            _control ctrlCommit _upperPartTime;
            
            //Save button
            _control = _display displayctrl 103;
            _control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((12.0 - _offset) * GUI_GRID_H + GUI_GRID_Y)];                                                                                                                 
            _control ctrlCommit _upperPartTime;
            
            //Skip button - same position as Save
            _control = _display displayctrl 1002;
            _control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((12.0 - _offset) * GUI_GRID_H + GUI_GRID_Y)];                                                                                                                 
            _control ctrlCommit _upperPartTime;
            
            //Revert
            _control = _display displayctrl 119;
            _control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((13.1 - _offset) * GUI_GRID_H + GUI_GRID_Y)];                                                                                                                 
            _control ctrlCommit _upperPartTime;
            
            //Again - same position as Revert
            _control = _display displayctrl 1003;
            _control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((13.1 - _offset) * GUI_GRID_H + GUI_GRID_Y)];                                                                                                                 
            _control ctrlCommit _upperPartTime;
            
            //Options button
            _control = _display displayctrl 101;
            _control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((14.2 - _offset) * GUI_GRID_H + GUI_GRID_Y)];                                                                                                             
            _control ctrlCommit _upperPartTime;
            
            if (getnumber (missionconfigfile >> "replaceAbortButton") > 0) then {
                // but these remain unmoved
                _offset = _offset - 2 * 1.1;

                //Video button
                _control = _display displayctrl 301;
                _control ctrlSetPosition [(2 * GUI_GRID_W + GUI_GRID_X), ((18.6 - 5 * 1.1 - _offset) * GUI_GRID_H + GUI_GRID_Y)];
                
                //Audio button
                _control = _display displayctrl 302;
                _control ctrlSetPosition [(2 * GUI_GRID_W + GUI_GRID_X), ((18.6 - 4 * 1.1 - _offset) * GUI_GRID_H + GUI_GRID_Y)];
                
                //Controls button
                _control = _display displayctrl 303;
                _control ctrlSetPosition [(2 * GUI_GRID_W + GUI_GRID_X), ((18.6 - 3 * 1.1 - _offset) * GUI_GRID_H + GUI_GRID_Y)];
                
                // CBA Addon Controls button
                _control = _display displayctrl IDC_ADDON_CONTROLS;
                _control ctrlSetPosition [(2 * GUI_GRID_W + GUI_GRID_X), ((18.6 - 2 * 1.1 - _offset) * GUI_GRID_H + GUI_GRID_Y)];
                
                //Game button
                _control = _display displayctrl 307;
                _control ctrlSetPosition [(2 * GUI_GRID_W + GUI_GRID_X), ((18.6 - 1 * 1.1 - _offset) * GUI_GRID_H + GUI_GRID_Y)];
                
                // CBA Addon Options button
                _control = _display displayctrl IDC_ADDON_OPTIONS;
                _control ctrlSetPosition [(2 * GUI_GRID_W + GUI_GRID_X), ((18.6 - _offset) * GUI_GRID_H + GUI_GRID_Y)];
            };

            //Enable and show buttons
            {
                _x ctrlEnable true;
                _x ctrlSetFade 0;
            } forEach _buttons;
            
            uiSleep 0.05;

            //From bottom to top
            reverse _buttons;

            {
                _x ctrlCommit 0.15;
                uiSleep _buttonsTime;
            } forEach _buttons;
            
            uiNamespace setVariable ["BIS_DisplayInterrupt_isOptionsExpanded", true];
            //set focus to Options button
            ctrlSetFocus (_display displayctrl 101);
        };
    };
}];
