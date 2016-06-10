/* ----------------------------------------------------------------------------
Function: CBA_fnc_viewDir

Description:
    Reports azimuth and inclination of a units head or weapon direction.

Parameters:
    _vehicle - The Unit or Vehicle. <OBJECT>
    _weapon  - Weapon. (optional, use the weapons direction instead) <STRING>

Returns:
    Azimuth + Inclination <ARRAY>
        0: _azimuth (0-360 degree, 0/360: North, 90: East, 180: South, 270: West) <NUMBER>
        1: _inclination (180 to -180 degree, 0: horizontally forward) <NUMBER>

Examples:
    (begin example)
        player call CBA_fnc_viewDir;
        [player, currentWeapon player] call CBA_fnc_viewDir;
        [vehicle player, "M2HB"] call CBA_fnc_viewDir;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(viewDir);

params [["_vehicle", objNull, [objNull]], ["_weapon", nil, [""]]];

private _viewVector = [0,0,0];

if (isNil "_weapon") then {
    // no weapon mode
    if (_vehicle call CBA_fnc_isPerson) then {
        // soldiers
        _viewVector = getCameraViewDirection _vehicle;
    } else {
        // vehicles
        _viewVector = vectorDir _vehicle;
    };
} else {
    _viewVector = _vehicle weaponDirection _weapon;
};

_viewVector params ["_dirX", "_dirY", "_dirZ"];

private _azimuth = _dirX atan2 _dirY;

if (_azimuth < 0) then {
    ADD(_azimuth,360);
};

private _inclination = asin _dirZ;

[_azimuth, _inclination]
