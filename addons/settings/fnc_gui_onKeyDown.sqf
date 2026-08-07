#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_onKeyDown

Description:
    Handles key presses in the Addon Options menu.

Parameters:
    _display - Addon Options dialog <DISPLAY>
    _key     - DIK code of the pressed key <NUMBER>
    _shift   - Shift held <BOOL>
    _ctrl    - Ctrl held <BOOL>

Returns:
    Key was handled <BOOL>

Examples:
    (begin example)
        _display displayAddEventHandler ["KeyDown", {_this call CBA_settings_fnc_gui_onKeyDown}];
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */

params ["_display", "_key", "", "_ctrl"];

// ----- vanilla options are shown, don't take keys away from them
if !(ctrlShown (_display displayCtrl IDC_ADDONS_GROUP)) exitWith {false};

private _handled = false;

switch (_key) do {
    // ----- focus the search bar
    case DIK_F: {
        if (_ctrl) then {
            ctrlSetFocus (_display displayCtrl IDC_SEARCH_EDIT);
            _handled = true;
        };
    };
    // ----- swallow enter in the search bar, it would close the dialog
    case DIK_NUMPADENTER;
    case DIK_RETURN: {
        if (_display getVariable [QGVAR(searchFocus), false]) then {
            [_display] call FUNC(gui_search);
            _handled = true;
        };
    };
};

_handled
