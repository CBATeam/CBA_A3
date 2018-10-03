#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_notify

Description:
    Displays a small notification to the player

Parameters:
    title of the notification, displayed in the top left
    message displayed in the center
    (optional) color of the notification title

Returns:
    Nothing

Examples:
    (begin example)
        ["ARC", "Not Connected to Discord", [1,0,0,1]] call cba_fnc_notify;
        ["CBA", "This text is white!"] call cba_fnc_notify;
    (end)

Author:
    SynixeBrett

---------------------------------------------------------------------------- */
SCRIPT(notify);

if !(hasInterface) exitWith {  };

params [
    ["_title", ""],
    ["_message", ""],
    ["_color", [1,1,1,1]]
];

if !(canSuspend) exitWith {[_title, _message, _color] spawn CBA_fnc_notify};

disableSerialization;

// Require a _title and _message

if (_title isEqualTo "" && {_message isEqualTo ""}) exitWith {};

private _display = findDisplay 46;

private _index = uiNamespace getVariable [QGVAR(NotificationIndex), 0];
uiNamespace setVariable [QGVAR(NotificationIndex), _index + 1];

waitUntil {_index - GVAR(NotificationCurrentIndex) < GVAR(NotificationMax)};

private _position = _index % GVAR(NotificationMax);
private _safezoneX = safezoneW + safezoneX;

// Create the 3 displays in the offscreen position

private _ctrlBackground = _display ctrlCreate ["RscPicture", 20];
_ctrlBackground ctrlSetPosition [
    _safezoneX,
    (0.24 + (_position * 0.08)) * safezoneH + (safezoneY * -0.5) ,
    0.1 * safezoneW,
    0.06 * safezoneH
];
_ctrlBackground ctrlSetText "#(argb,8,8,3)color(0,0,0,0.75)";
_ctrlBackground ctrlCommit 0;

private _ctrlTitle = _display ctrlCreate ["RscStructuredText", 10];
_ctrlTitle ctrlSetPosition [
    _safezoneX,
    (0.24 + (_position * 0.08)) * safezoneH + (safezoneY * -0.5),
    0.1 * safezoneW,
    0.0255 * safezoneH
];
_ctrlTitle ctrlSetStructuredText parseText _title;
_ctrlTitle ctrlSetTextColor _color;
_ctrlTitle ctrlCommit 0;

private _ctrlNotification = _display ctrlCreate ["RscStructuredText", 30];
_ctrlNotification ctrlSetPosition
[
    _safezoneX,
    (0.26 + (_position * 0.08)) * safezoneH + (safezoneY * -0.5),
    0.1 * safezoneW,
    0.06 * safezoneH
];
_ctrlNotification ctrlSetStructuredText parseText _message;
_ctrlNotification ctrlCommit 0;

// move the displays onscreen

private _ctrls = [_ctrlBackground, _ctrlTitle, _ctrlNotification];
{
    private _position = ctrlPosition _x;
    private _posX = 0.9 * safezoneW + safezoneX;
    _position set [0, _posX];
    _x ctrlSetPosition _position;
    _x ctrlCommit (uiNamespace getVariable [QGVAR(NotificationSpeed), 0.5]);
} forEach _ctrls;

// sleep while the notification is onscreen

sleep ((uiNamespace getVariable [QGVAR(NotificationLifetime), 3]) - 1);
waitUntil {_index isEqualTo GVAR(NotificationCurrentIndex)};
sleep 1;

// move the displays offscreen

{
    _position = ctrlPosition _x;
    _position set [0, (_safezoneX)];
    _x ctrlSetPosition _position;
    _x ctrlCommit (uiNamespace getVariable [QGVAR(NotificationSpeed), 0.5]);
} forEach _ctrls;

sleep (uiNamespace getVariable [QGVAR(NotificationSpeed), 0.5]);

// delete the displays

{
    ctrlDelete _x;
} forEach _ctrls;

INC(GVAR(NotificationCurrentIndex));
