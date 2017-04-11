#include "script_component.hpp"

params ["_display"];

{
    private _control = _display displayCtrl _x;

    _control ctrlEnable false;
    _control ctrlSetFade 1;
    _control ctrlCommit 0;
} forEach [IDC_ADDON_CONTROLS, IDC_ADDON_OPTIONS];

private _button = _display displayCtrl 101;

_button ctrlRemoveEventHandler ["ButtonClick", 0]; // remove vanilla button
_button ctrlAddEventHandler ["ButtonClick", {
    _this spawn {
        // this is an edit of a BI script, don't change unnecessarily
        disableSerialization;

        params ["_ctrl"];
        _display = ctrlparent _ctrl;

        _offset = 0;
        if (getnumber (missionconfigfile >> "replaceAbortButton") > 0) then { //MUF-test-removed: (getNumber(configfile >> "isDemo") != 1) &&
            _offset = 1.1;
        };

        //if options are expanded (Video Options button is shown), collapse it and vice versa
        //if(ctrlFade (_display displayCtrl 301) < 0.5) then
        _upperPartTime = 0.3; //0.05 for each button
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
            

            (_display displayctrl 301) ctrlSetFade 1;       //Video
            (_display displayctrl 302) ctrlSetFade 1;       //Audio
            (_display displayctrl 303) ctrlSetFade 1;       //Controls
            (_display displayctrl IDC_ADDON_CONTROLS) ctrlSetFade 1;
            (_display displayctrl 307) ctrlSetFade 1;       //Game Options
            (_display displayctrl IDC_ADDON_OPTIONS) ctrlSetFade 1;
            
            (_display displayctrl 301) ctrlCommit _buttonsTime; //Video
            uiSleep _buttonsTime;
            (_display displayctrl 302) ctrlCommit _buttonsTime; //Audio
            uiSleep _buttonsTime;
            (_display displayctrl 303) ctrlCommit _buttonsTime; //Controls
            uiSleep _buttonsTime;
            (_display displayctrl IDC_ADDON_CONTROLS) ctrlCommit _buttonsTime;
            uiSleep _buttonsTime;
            (_display displayctrl 307) ctrlCommit _buttonsTime; //Game
            uiSleep _buttonsTime;
            (_display displayctrl IDC_ADDON_OPTIONS) ctrlCommit _buttonsTime;
            
            (_display displayctrl 301) ctrlEnable false;        //Video
            (_display displayctrl 302) ctrlEnable false;        //Audio
            (_display displayctrl 303) ctrlEnable false;        //Controls
            (_display displayctrl IDC_ADDON_CONTROLS) ctrlEnable false;
            (_display displayctrl 307) ctrlEnable false;        //Game Options
            (_display displayctrl IDC_ADDON_OPTIONS) ctrlEnable false;
            
            
            uiNamespace setVariable ["BIS_DisplayInterrupt_isOptionsExpanded", false];
            //set focus to Options button
            ctrlSetFocus (_display displayctrl 101);    
        } else {
            //expand accordion and show buttons
                
            // 2 additional buttons from CBA
            _offset = _offset + 2 * 1.1;

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
            (_display displayctrl 301) ctrlEnable true; //Video
            (_display displayctrl 302) ctrlEnable true; //Audio
            (_display displayctrl 303) ctrlEnable true; //Controls
            (_display displayctrl IDC_ADDON_CONTROLS) ctrlEnable true;
            (_display displayctrl 307) ctrlEnable true; //Game Options
            (_display displayctrl IDC_ADDON_OPTIONS) ctrlEnable true;
            
            //--- Show all buttons from Options
            (_display displayctrl 301) ctrlSetFade 0;   //Video
            (_display displayctrl 302) ctrlSetFade 0;   //Audio
            (_display displayctrl 303) ctrlSetFade 0;   //Controls
            (_display displayctrl IDC_ADDON_CONTROLS) ctrlSetFade 0;
            (_display displayctrl 307) ctrlSetFade 0;   //Game Options
            (_display displayctrl IDC_ADDON_OPTIONS) ctrlSetFade 0;
            
            uiSleep 0.05;
            
            //From bottom to top
            (_display displayctrl IDC_ADDON_OPTIONS) ctrlCommit 0.15;
            uiSleep _buttonsTime;
            (_display displayctrl 307) ctrlCommit 0.15; //Game
            uiSleep _buttonsTime;
            (_display displayctrl IDC_ADDON_CONTROLS) ctrlCommit 0.15;
            uiSleep _buttonsTime;
            (_display displayctrl 303) ctrlCommit 0.15; //Controls
            uiSleep _buttonsTime;
            (_display displayctrl 302) ctrlCommit 0.15; //Audio
            uiSleep _buttonsTime;
            (_display displayctrl 301) ctrlCommit 0.15; //Video
            
            uiNamespace setVariable ["BIS_DisplayInterrupt_isOptionsExpanded", true];
            //set focus to Options button
            ctrlSetFocus (_display displayctrl 101);
        };
    };
}];
