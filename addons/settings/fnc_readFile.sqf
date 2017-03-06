/* ----------------------------------------------------------------------------
Function: CBA_settings_fnc_readFile

Description:
    Reads and applies settings from a file.
    Only considered as public API from a static settings addon!

Parameters:
    _path - Path to file to read from. <STRING>

Returns:
    Successfully read settings from file. <BOOL>

Author:
    commy2, Jonpas
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params ["_path"];

private _source = ["client", "server"] select (isMultiplayer && isServer);
private _info = loadFile _path;

if (_info == "") exitWith {false};

_info = _info call FUNC(parse);
{
    _x params ["_setting", "_value", "_force"];
    [_setting, _value, _force, _source] call FUNC(set);
} forEach _info;

true
