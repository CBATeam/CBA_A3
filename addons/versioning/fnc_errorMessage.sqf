/* ----------------------------------------------------------------------------
Function: CBA_fnc_errorMessage

Description:
    Displays an error message.

Parameters:
    _textHeader  - Header of error message box <STRING>
    _textMessage - Brief description of error <STRING, TEXT>

Example:
    (begin example)
        ["my header", "my message"] call CBA_fnc_errorMessage
    (end)

Returns:
    None

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(errorMessage);

#define OFFSET 2

disableSerialization;

params [
    ["_textHeader", "", [""]],
    ["_textMessage", "", ["", text ""]],
    ["_display", uiNamespace getVariable ["CBA_missionDisplay", findDisplay 46], [displayNull]]
];

if (_textMessage isEqualType "") then {
    _textMessage = parseText _textMessage;
};

// push back further messages
if (!isNull (uiNamespace getVariable [QGVAR(displayErrorMessage), displayNull])) exitWith {
    ((uiNamespace getVariable QGVAR(displayErrorMessage)) getVariable QGVAR(info)) pushBack [_textHeader, _textMessage];
};

_display = _display createDisplay "CBA_DisplayMessage";

uiNamespace setVariable [QGVAR(displayErrorMessage), _display];
_display setVariable [QGVAR(info), [[_textHeader, _textMessage]]];

private _ctrlHeader    = _display displayCtrl IDC_HEADER;
private _ctrlMessage   = _display displayCtrl IDC_MESSAGE;
private _ctrlMessage_B = _display displayCtrl IDC_MESSAGE_BACKGROUND;
private _ctrlButtonL   = _display displayCtrl IDC_BUTTON_L;
private _ctrlButtonR   = _display displayCtrl IDC_BUTTON_R;
private _ctrlButtonL_B = _display displayCtrl IDC_BUTTON_L_BACKGROUND;
private _ctrlButtonM_B = _display displayCtrl IDC_BUTTON_M_BACKGROUND;
private _ctrlButtonR_B = _display displayCtrl IDC_BUTTON_R_BACKGROUND;

// increase text box size
if (OFFSET > 0) then {
    private _position = ctrlPosition _ctrlMessage;
    _offset = OFFSET * (_position select 3);

    _position set [3, (_position select 3) + _offset];
    _ctrlMessage ctrlSetPosition _position;
    _ctrlMessage ctrlCommit 0;

    _position = ctrlPosition _ctrlMessage_B;
    _position set [3, (_position select 3) + _offset];
    _ctrlMessage_B ctrlSetPosition _position;
    _ctrlMessage_B ctrlCommit 0;

    {
        private _position = ctrlPosition _x;
        _position set [1, (_position select 1) + _offset];
        _x ctrlSetPosition _position;
        _x ctrlCommit 0;
    } forEach [_ctrlButtonL, _ctrlButtonR, _ctrlButtonL_B, _ctrlButtonM_B, _ctrlButtonR_B];
};

// set header and message
_ctrlHeader ctrlSetText _textHeader;
_ctrlMessage ctrlSetStructuredText _textMessage;

// prevent clicking this from hiding the buttons
_ctrlMessage ctrlEnable false;

_ctrlButtonL ctrlEnable false;
_ctrlButtonL ctrlSetText "";

_ctrlButtonR ctrlEnable true;
_ctrlButtonR ctrlSetText localize "STR_DISP_OK";
_ctrlButtonR ctrlAddEventHandler ["buttonClick", {
    private _display = ctrlParent (_this select 0);
    private _info = _display getVariable QGVAR(info);
    _info deleteAt 0;

    if (_info isEqualTo []) then {
        // close dialog
        _display closeDisplay 1;
    } else {
        // display next message
        (_display displayCtrl IDC_HEADER) ctrlSetText (_info select 0 select 0);
        (_display displayCtrl IDC_MESSAGE) ctrlSetStructuredText (_info select 0 select 1);
    };
    true
}];

ctrlSetFocus _ctrlButtonR;

// block all key input while message is open
_display displayAddEventHandler ["keyDown", {true}];
