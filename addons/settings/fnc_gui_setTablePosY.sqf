#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_setTablePosY

Description:
    Positions a control in the settings table at the given vertical offset, taking
    x/y/w/h from the control's config class.

    Used both when the table is built and when it is re-flowed after filtering, so
    that both stay in sync.

Parameters:
    _control   - Control to position <CONTROL>
    _tablePosY - Vertical offset in the table <NUMBER>
    _height    - Height override, config height if omitted <NUMBER> (default: nil)

Returns:
    Vertical offset of the next control in the table <NUMBER>

Examples:
    (begin example)
        _tablePosY = [_ctrlSettingGroup, _tablePosY] call CBA_settings_fnc_gui_setTablePosY;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params ["_control", "_tablePosY", "_height"];

private _config = configFile >> ctrlClassName _control;

private _posX = getNumber (_config >> "x");
private _posY = getNumber (_config >> "y") + _tablePosY;
private _width = getNumber (_config >> "w");

if (isNil "_height") then {
    _height = getNumber (_config >> "h");
};

_control ctrlSetPosition [_posX, _posY, _width, _height];
_control ctrlCommit 0;

_posY + _height
