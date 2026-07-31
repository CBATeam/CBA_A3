#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_confirmDiscard

Description:
    Closes the settings menu, listing first what would be thrown away.

    Nothing pending means no prompt, and neither does a setting that was touched
    and put back, since that would change nothing if saved.

    Uses its own dialog rather than BIS_fnc_guiMessage, which does nothing at all
    in 3DEN and offers no way to decline elsewhere.

Parameters:
    _display - Settings menu display <DISPLAY>

Returns:
    Closing was deferred to the prompt <BOOL>

Examples:
    (begin example)
        [_display] call CBA_settings_fnc_gui_confirmDiscard;
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */

params ["_display"];

private _names = call FUNC(gui_getLiveEdits);
private _count = count _names;

if (_count == 0) exitWith {
    _display closeDisplay IDC_CANCEL;
    false
};

private _dialog = _display createDisplay QGVAR(confirmDiscard);

// Stringtables have no plural forms, so the two readings are separate keys
private _text = format [
    [LLSTRING(discardChanges_one), LLSTRING(discardChanges)] select (_count > 1),
    _count
];

private _shown = _names select [0, CONFIRM_LIST_MAX];

{
    _text = _text + format ["<br/> - %1", _x];
} forEach _shown;

private _hidden = _count - (count _shown);

if (_hidden > 0) then {
    _text = _text + format ["<br/> " + LLSTRING(discardChanges_more), _hidden];
};

(_dialog displayCtrl IDC_CONFIRM_TEXT) ctrlSetStructuredText parseText _text;

// One line per setting, plus the sentence above them. Nothing in a controls group reflows on
// its own, so the panel and the buttons are moved to match
private _lines = 1 + (count _shown) + (parseNumber (_hidden > 0));
private _height = POS_H(CONFIRM_BASE_HEIGHT) + (_lines * POS_H(CONFIRM_LINE_HEIGHT));

private _ctrlGroup = _dialog displayCtrl IDC_CONFIRM_GROUP;
(ctrlPosition _ctrlGroup) params ["_groupX", "_groupY", "_groupW"];
_ctrlGroup ctrlSetPosition [_groupX, _groupY, _groupW, _height];
_ctrlGroup ctrlCommit 0;

private _ctrlText = _dialog displayCtrl IDC_CONFIRM_TEXT;
(ctrlPosition _ctrlText) params ["_textX", "_textY", "_textW"];
_ctrlText ctrlSetPosition [_textX, _textY, _textW, _lines * POS_H(CONFIRM_LINE_HEIGHT)];
_ctrlText ctrlCommit 0;

private _ctrlBackground = _dialog displayCtrl IDC_CONFIRM_BACKGROUND;
(ctrlPosition _ctrlBackground) params ["_bgX", "_bgY", "_bgW"];
_ctrlBackground ctrlSetPosition [_bgX, _bgY, _bgW, _height - _bgY];
_ctrlBackground ctrlCommit 0;

{
    (ctrlPosition _x) params ["_btnX", "", "_btnW", "_btnH"];
    _x ctrlSetPosition [_btnX, _height - _btnH - POS_H(0.3), _btnW, _btnH];
    _x ctrlCommit 0;
} forEach [_dialog displayCtrl IDC_CONFIRM_OK, _dialog displayCtrl IDC_CANCEL];

// The menu has to outlive the prompt, so the prompt is what closes it
_dialog setVariable [QGVAR(parentDisplay), _display];

(_dialog displayCtrl IDC_CONFIRM_OK) ctrlAddEventHandler ["ButtonClick", {
    private _dialog = ctrlParent (_this select 0);
    private _parent = _dialog getVariable [QGVAR(parentDisplay), displayNull];

    _dialog closeDisplay IDC_OK;
    _parent closeDisplay IDC_CANCEL;
}];

true
