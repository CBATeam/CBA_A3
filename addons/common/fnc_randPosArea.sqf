/* ----------------------------------------------------------------------------
Function: CBA_fnc_randPosArea

Description:
    Find a random (uniformly distributed) position within the given area without rejection sampling.

    * You can use <CBA_fnc_randPos> to find a position within a simple radius.

Parameters:
    _area      - The area to find a position within <MARKER, TRIGGER, LOCATION, ARRAY>
    _perimeter - True to return only positions on the area perimeter (optional, default: false) <BOOLEAN>

Returns:
    Position <ARRAY> (Empty array if invalid area was provided)

Examples:
   (begin example)
       _position = [marker, true] call CBA_fnc_randPosArea;

       _position = [trigger] call CBA_fnc_randPosArea;

      _position = [location] call CBA_fnc_randPosArea;

      _position = [[center, a, b, angle, isRectangle]] call CBA_fnc_randPosArea;
   (end)

Author:
    SilentSpike 2015-07-06
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(randPosArea);

params [
    ["_zRef", [], ["",objNull,locationNull,[]], 5],
    ["_perimeter", false, [true]]
];
private _area = [_zRef] call CBA_fnc_getArea;

if (_area isEqualTo []) exitWith {[]};

_area params ["_center","_a","_b","_angle","_isRect"];

private _posVector = [0,0,0];
if (_isRect) then {
    private _2a = _a*2;
    private _2b = _b*2;

    if (_perimeter) then {
        private _rho = random (4*(_a + _b));

        private _x1 = (_rho min _2a);
        private _y1 = ((_rho - _x1) min _2b) max 0;
        private _x2 = ((_rho - _x1 - _y1) min _2a) max 0;
        private _y2 = ((_rho - _x1 - _y1 - _x2) min _2b) max 0;
        _posVector = [(_x1 - _x2) - _a, (_y1 - _y2) - _b, 0];
    } else {
        _posVector = [random(_2a) - _a, random(_2b) - _b, 0];
    };
} else {
    // Generate point on circle of R=1
    private _rho = [random 1, 1] select _perimeter;
    private _phi = random 360;

    // Scale circle to dimensions of the ellipse
    private _x = sqrt(_rho) * cos(_phi);
    private _y = sqrt(_rho) * sin(_phi);

    _posVector = [_x * _a, _y * _b, 0];
};

_posVector = [_posVector, -_angle] call BIS_fnc_rotateVector2D;

_center vectorAdd _posVector
