/* ----------------------------------------------------------------------------
Function: CBA_fnc_headDir

Description:
    Get the direction of a unit's head.

    For anyone except the local player,    the head is assumed to be facing
    straight forward.

Parameters:
    _unit - Unit to check [Object]
    _object - Relative object/position to get direction to [Object or
        Position Array, defaults to getting compass direction]

Returns:
    [<NUMBER>, <NUMBER>, <BOOL>, <BOOL>]
        * Direction of unit head (for the local player, this is taken to be the
            true head direction; for other players or AI, the value is just the
        * Difference angle (negative or positive), e.g how many degrees turning
            to center object horizontally
        * True/False if given object is in field of view of player relative to
            his head
        * True/False if player is using 3rd person view

Examples:
    (begin example)
        _data = [player] call CBA_fnc_headDir;
        // => returns direction of head (freelook)

        _data = [player, house1] call CBA_fnc_headDir;
        // => returns direction of head, difference angle, if house is in fov
        //    and if 3rd person is on or not

        _data = [ai] call CBA_fnc_headDir;
        // => returns the direction of ai (not head)

        _data = [ai, getpos player] call CBA_fnc_headDir;
        // => direction of ai, difference towards players pos, if player is in
        //    fov of ai, and 3rd person off (default return)
    (end)

TODO:
    Vertical angle.

ImplementationNote:
    positionCameraToWorld is only valid for player object, it is not handled for
    other players or AI!! For these you can only check if its turned towards an
    object, not looking at it.

Author:
    rocko
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(headDir);

private["_azimuth", "_angle", "_dif", "_infov", "_object", "_threed", "_do"];

params ["_unit"];
_object = param [1,_unit];
_threed = false;

_do = (typeName _object != typeName _unit);
if (!_do) then {
    _do = (_object != _unit);
};

if (_do) then {
    _angle = [(_unit call CBA_fnc_getpos),(_object call CBA_fnc_getpos)] call BIS_fnc_dirTo;
} else {
    _angle = 0;
};
if (_unit != player) then
{
    _azimuth = getdir _unit;
} else {
    private ["_position","_viewPos","_vector","_magnitude"];
    _position = positionCameraToWorld [0, 0, 0];
    _threed = if ((_position distance _unit)>2) then {true} else {false};
    _viewPos = positionCameraToWorld [0, 0, 99999999];
    _vector = [
        (_viewPos select 0) - (_position select 0),
        (_viewPos select 1) - (_position select 1),
        (_viewPos select 2) - (_position select 2)
    ];
    _magnitude = [0, 0, 0] distance _vector;
    _vector = [
        (_vector select 0) / _magnitude,
        (_vector select 1) / _magnitude,
        (_vector select 2) / _magnitude
    ];
    _azimuth = (_vector select 0) atan2 (_vector select 1);
    _azimuth = [_azimuth] call CBA_fnc_simplifyAngle;
};

_dif = _angle - _azimuth;

if (_dif < 0) then { _dif = 360 + _dif;};
if (_dif > 180) then { _dif = _dif - 360;};
_infov = if (abs(_dif) < 43) then {true} else {false};

[_azimuth,_dif,_infov,_threed]
