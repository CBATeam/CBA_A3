/* ----------------------------------------------------------------------------
Function: CBA_fnc_addPauseMenuOption

Description:
    Adds a menu option to the ESC menu "Options" tab.

Parameters:
    _name   - name of the menu button or array of name and tooltip <STRING, ARRAY>
    _dialog - Dialog to open when clicking the menu button <STRING>

Returns:
    Nothing

Examples:
    (begin example)
        _handle = ["Menu Name", "RscMenuDialog"] call CBA_fnc_addPauseMenuOption;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_name", "", ["", []]], ["_dialog", "", [""]]];
_name params [["_displayName", "", [""]], ["_tooltip", "", [""]]];

if (isNil QGVAR(MenuButtons)) then {
    GVAR(MenuButtons) = [];
};

GVAR(MenuButtons) pushBack [_displayName, _tooltip, _dialog];

nil
