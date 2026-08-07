#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_rowClassInfo

Description:
    Returns the config position and the child control IDCs of a control, cached
    per control class.

    Every row of a given type has the same config position and the same children,
    and a category creates hundreds of rows, so reading this from config once per
    row is by far the most expensive part of opening one. There are only a handful
    of row classes, so this ends up being a handful of config reads per session.

Parameters:
    _control - Control to look up <CONTROL>

Returns:
    _info - Config info of the control's class <ARRAY>
        0: _position - Config position, [x, y, w, h] <ARRAY>
        1: _idcs     - IDCs of the class' child controls <ARRAY>

Examples:
    (begin example)
        (_ctrlSettingGroup call CBA_settings_fnc_gui_rowClassInfo) params ["_position", "_idcs"];
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */

params ["_control"];

private _class = ctrlClassName _control;

// config doesn't change at runtime, so the cache outlives the mission
private _cache = uiNamespace getVariable QGVAR(rowClassInfo);

if (isNil "_cache") then {
    _cache = createHashMap;
    uiNamespace setVariable [QGVAR(rowClassInfo), _cache];
};

private _info = _cache get _class;

if (isNil "_info") then {
    private _config = configFile >> _class;

    // a child without an idc reads as 0, which resolves to controlNull and is
    // silently skipped by the callers
    _info = [
        [getNumber (_config >> "x"), getNumber (_config >> "y"), getNumber (_config >> "w"), getNumber (_config >> "h")],
        ("true" configClasses (_config >> "controls")) apply {getNumber (_x >> "idc")}
    ];

    _cache set [_class, _info];
};

_info
