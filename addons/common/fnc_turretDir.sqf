#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_turretDir

Description:
    Reports azimuth and inclination of a vehicles turret.

Parameters:
    _vehicle         - The Vehicle. <OBJECT>
    _turret          - A Turret. (e.g. [0] for "main turret") <ARRAY>
    _relativeToModel - false (default): report directions relative to world, true: relative to model <BOOLEAN>

Returns:
    Azimuth + Inclination <ARRAY>
        0: _azimuth (0-360 degree) <NUMBER>
        1: _inclination (90 to -90 degree, 0: forward) <NUMBER>

Examples:
    (begin example)
        [vehicle player, [0], true] call CBA_fnc_turretDir
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(turretDir);

params [["_vehicle", objNull, [objNull]], ["_turret", [-1], [[]]], ["_relativeToModel", false, [false]]];

private _turretConfig = [_vehicle, _turret] call CBA_fnc_getTurret;

private _gunBeg = _vehicle selectionPosition getText (_turretConfig >> "gunBeg");
private _gunEnd = _vehicle selectionPosition getText (_turretConfig >> "gunEnd");

if !(_relativeToModel) then {
    _gunBeg = AGLToASL (_vehicle modelToWorld _gunBeg);
    _gunEnd = AGLToASL (_vehicle modelToWorld _gunEnd);
};

private _turretDir = _gunEnd vectorFromTo _gunBeg;

_turretDir params ["_dirX", "_dirY", "_dirZ"];

private _azimuth = _dirX atan2 _dirY;

if (_azimuth < 0) then {
    ADD(_azimuth,360);
};

private _inclination = asin _dirZ;

[_azimuth, _inclination]
