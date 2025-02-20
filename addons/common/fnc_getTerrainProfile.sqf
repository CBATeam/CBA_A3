#include "script_component.hpp"
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
    [[0,0,0], [0,0,1000], 10] call CBA_fnc_getTerrainProfile

Author:
    Rommel && Noubernou

---------------------------------------------------------------------------- */

params ["_posA","_posB", ["_resolution", 10]];
_posA = _posA call CBA_fnc_getPos;
_posB = _posB call CBA_fnc_getPos;
_posA set [2,0]; _posB set [2,0];

private _angle = [_posA, _posB] call BIS_fnc_dirTo;
private _2Ddistance = [_posA, _posB] call BIS_fnc_distance2D;

private _logic = "logic" createVehicleLocal _posA;
_logic setPosATL _posA;
private _z = (getPosASL _logic) select 2;
private _return = [];
private _pos = [];

for "_i" from 0 to (_2Ddistance / _resolution) do {
    private _adj = _resolution * _i;
    _pos = [_posA, _adj, _angle] call BIS_fnc_relPos;
    _logic setPosATL _pos;
    private _alt = ((getPosASL _logic) select 2) - _z;
    _return set [_i,[_alt, _adj, _pos]];
};
_logic setPosATL _posB;
private _alt = ((getPosASL _logic) select 2) - _z;
_return pushBack [_alt, _2Ddistance, _pos];

deleteVehicle _logic;

[_2Ddistance, _angle, _return]
