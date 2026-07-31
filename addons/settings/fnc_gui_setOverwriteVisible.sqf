#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_setOverwriteVisible

Description:
    Shows or hides one of the "overwrite" checkboxes of a settings menu row.

    Which of them a row has depends on the source it is showing, so this has to
    be reversible.

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

_ctrl ctrlShow _show;
_ctrl ctrlEnable _show;
