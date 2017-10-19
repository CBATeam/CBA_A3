/* ----------------------------------------------------------------------------
Function: CBA_fnc_getTerrainProfile

Description:
    A function used to find the terrain profile between two positions

Parameters:
    - Position A [Object, Location, Position, Marker or Group]
    - Position B [Object, Location, Position, Marker or Group]
    Optional:
    - Resolution (in Metres)

Returns:
    Array containing [2D Distance, Angle, Terrain Profile (in format [Relative Altitude, 2D Distance from, 3D Distance from])

Example:
    [[0, 0, 0], [0, 0, 1000], 10] call CBA_fnc_getTerrainProfile

Author:
    Rommel && Noubernou

---------------------------------------------------------------------------- */
#include "script_component.hpp"

params ["_posA", "_posB"];

_posA = _posA call CBA_fnc_getPos;
_posB = _posB call CBA_fnc_getPos;
_posA set [2, 0];
_posB set [2, 0];

DEFAULT_PARAM(2,_resolution,10);

private ["_angle", "_2Ddistance", "_return", "_z", "_adj", "_pos", "_alt"];
_angle = [_posA, _posB] call BIS_fnc_dirTo;
_2Ddistance = [_posA, _posB] call BIS_fnc_distance2D;

_logic = "logic" createVehicleLocal _posA;
_logic setPosATL _posA;
_z = (getPosASL _logic) select 2;
_return = [];

for "_i" from 0 to (_2Ddistance / _resolution) do {
    _adj = _resolution * _i;
    _pos = [_posA, _adj, _angle] call BIS_fnc_relPos;
    _logic setPosATL _pos;
    _alt = ((getPosASL _logic) select 2) - _z;
    _return set [_i, [_alt, _adj, _pos]];
};

_logic setPosATL _posB;
_alt = ((getPosASL _logic) select 2) - _z;
_return pushBack [_alt, _2Ddistance, _pos];

deletevehicle _logic;

[_2Ddistance, _angle, _return]
