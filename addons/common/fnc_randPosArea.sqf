/* ----------------------------------------------------------------------------
Function: CBA_fnc_randPosArea

Description:
    Find a random (uniformly distributed) position within the given area.

    * You can <CBA_fnc_randPos> to find a position within a simple radius.

Parameters:
    _zone - The zone to find a position within [Marker or Trigger]
    _perimeter - True to return only positions on the area perimeter [Boolean, defaults to false]

Returns:
    Position [Array]

Examples:
   (begin example)
   _position = [marker, true] call CBA_fnc_randPosArea;

   _position = [trigger] call CBA_fnc_randPosArea;
   (end)

Author:
    SilentSpike 2015-07-06
---------------------------------------------------------------------------- */

private ["_zRef","_zSize","_zDir","_zRect","_zPos","_perimeter","_posVector"];
_zRef = _this select 0;
_perimeter = if (count _this > 1) then {_this select 1} else {false};

switch (typeName _zRef) do {
    case "STRING" : {
        _zSize = markerSize _zRef;
        _zDir = markerDir _zRef;
        _zRect = (markerShape _zRef) == "RECTANGLE";
        _zPos = markerPos _zRef;
    };
    case "OBJECT" : {
        _zSize = triggerArea _zRef;
        _zDir = _zSize select 2;
        _zRect = _zSize select 3;
        _zPos = getPos _zRef;
    };
};

private ["_x","_y","_a","_b","_rho","_phi","_x1","_x2","_y1","_y2"];
if (_zRect) then {
    _x = _zSize select 0;
    _y = _zSize select 1;
    _a = _x*2;
    _b = _y*2;

    if (_perimeter) then {
        _rho = random (2*(_a + _b));

        _x1 = (_rho min _a);
        _y1 = ((_rho - _x1) min _b) max 0;
        _x2 = ((_rho - _x1 - _y1) min _a) max 0;
        _y2 = ((_rho - _x1 - _y1 - _x2) min _b) max 0;
        _posVector = [(_x1 - _x2) - _x, (_y1 - _y2) - _y, 0];
    } else {
        _posVector = [random(_a) - _x, random(_b) - _y, 0];
    };
} else {
    _rho = if (_perimeter) then {1} else {random 1};
    _phi = random 360;
    _x = sqrt(_rho) * cos(_phi);
    _y = sqrt(_rho) * sin(_phi);

    _posVector = [_x * (_zSize select 0), _y * (_zSize select 1), 0];
};

_posVector = [_posVector, -_zDir] call BIS_fnc_rotateVector2D;

_zPos vectorAdd _posVector
