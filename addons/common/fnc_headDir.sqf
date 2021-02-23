#include "script_component.hpp"
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

        _data = [ai, getPos player] call CBA_fnc_headDir;
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
SCRIPT(headDir);

params [
    ["_unit", objNull, [objNull]],
    ["_offset", ""]
];

private _azimuth = 0;
private _isExternalCam = false;
if (_unit != call CBA_fnc_currentUnit) then {
    _azimuth = getDir _unit;
} else {
    private _camPos = AGLToASL positionCameraToWorld [0, 0, 0];
    _isExternalCam = (_camPos vectorDistance getPosASL _unit) > 2;
    private _viewPos = AGLToASL positionCameraToWorld [0, 0, 10000];
    private _vector = _viewPos vectorDiff _camPos;
    _vector = _vector vectorMultiply (1 / vectorMagnitude _vector);
    _azimuth = (_vector select 0) atan2 (_vector select 1);
    _azimuth = [_azimuth] call CBA_fnc_simplifyAngle;
};

private _diff = -_azimuth;

if (_offset isNotEqualTo "") then {
    ADD(_diff,_unit getDir ([_offset] call CBA_fnc_getPos));
};

if (_diff < 0) then {
    ADD(_diff,360);
};

if (_diff > 180) then {
    SUB(_diff,360);
};

private _inFOV = abs _diff < 43;

[_azimuth, _diff, _inFOV, _isExternalCam]
