/* ----------------------------------------------------------------------------
Function: CBA_fnc_getTerrainProfile

Description:
	A returns the profile of the terain between two positions at a certain
	interval.
Parameters:
	_pos1 - Start position, either an object or position.
    _pos1 - End position, either an object or position.
    _interval - Sampling interval for terrain heights, in meters.
Example:
	_profile = [Player, [0,0,0], 100] call CBA_fnc_getTerrainProfile
Returns:
	Array - [distance, directions, interval, [altitudes]]
Author:
	Nou

---------------------------------------------------------------------------- */
#include "script_component.hpp"

PARAMS_3(_pos1,_pos2,_interval);
_pos1 = _pos1 call CBA_fnc_getPos;
_pos2 = _pos2 call CBA_fnc_getPos;
_direction = abs ([_pos1, _pos2] call BIS_fnc_dirTo);
_distance = [_pos1, _pos2] call BIS_fnc_distance2D;
_intervalDistance = 0;
_profile = [];
_poll = "Logic" createVehicleLocal _pos1;

_poll setPos [_pos1 select 0, _pos1 select 1, 0];
_pollPos = getPosASL _poll;
_alt = [_pollPos select 2, _intervalDistance];
_profile set [(count _profile), _alt];
_lastPos = _pos1;
_intervalDistance = _intervalDistance + _interval;
while{_intervalDistance < _distance} do {
    _pos = [_lastPos, _interval, _direction] call BIS_fnc_relPos;
    _poll setPos [_pos select 0, _pos select 1, 0];
    _pollPos = getPosASL _poll;
    _alt = [_pollPos select 2, _intervalDistance];
    _profile set [(count _profile), _alt];
    _intervalDistance = _intervalDistance + _interval;
    _lastPos = _pos;
};
_poll setPos [_pos2 select 0, _pos2 select 1, 0];
_pollPos = getPosASL _poll;
_alt = [_pollPos select 2, _distance];
_profile set [(count _profile), _alt];

deleteVehicle _poll;

[_distance, _direction, _interval, _profile];
