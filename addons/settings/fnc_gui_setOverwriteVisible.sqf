#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_setOverwriteVisible

Description:
    Shows or hides one of the "overwrite" checkboxes of a settings menu row.

    Which of them a row has depends on the source it is showing, so this has to
    be reversible. The checkbox is moved off screen rather than hidden, which is
    how the menu has always done it, and its real position is taken from the row
    when it is created.

Parameters:
    _ctrl - Overwrite checkbox <CONTROL>
    _show - Show the checkbox <BOOL>

Returns:
    None

Examples:
    (begin example)
        [_ctrlOverwriteMission, false] call CBA_settings_fnc_gui_setOverwriteVisible;
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */

params ["_ctrl", "_show"];

_ctrl ctrlSetPosition ([[0, 0, -1, -1], _ctrl getVariable [QGVAR(position), [0, 0, -1, -1]]] select _show);
_ctrl ctrlCommit 0;

_ctrl ctrlEnable _show;
