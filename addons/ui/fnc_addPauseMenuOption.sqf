#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addPauseMenuOption

Description:
    Adds a menu option to the ESC menu "Options" tab.

Parameters:
    _name         - name of the menu button or array of name and tooltip <STRING, ARRAY>
    _dialogOrCode - Dialog to open or code to execute when clicking the menu button <STRING, CODE>
    _condition    - condition to check whether the menu button should be shown (optional, default: {true}) <CODE>
    _params       - parameters passed to the condition and dialog code (optional, default: []) <ARRAY>

Returns:
    Nothing

Examples:
    (begin example)
        ["Menu Name", "RscDebugConsole"] call CBA_fnc_addPauseMenuOption;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params [["_name", "", ["", []]], ["_dialogOrCode", "", ["", {}]], ["_condition", {true}, [{}]], ["_params", []]];
_name params [["_displayName", "", [""]], ["_tooltip", "", [""]]];

if (isNil QGVAR(MenuButtons)) then {
    GVAR(MenuButtons) = [];
};

GVAR(MenuButtons) pushBack [_displayName, _tooltip, _dialogOrCode, _condition, _params];

nil
