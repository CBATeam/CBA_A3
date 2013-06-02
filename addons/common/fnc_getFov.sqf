/* ----------------------------------------------------------------------------
Function: CBA_fnc_getFov

Description:
	Get current camera's field of view in radians and zoom.

	Fov is calculated in the same format as it is set up in configs and used
	by camSetFov and alike. Precision is about 95%.

Parameters:
	(optional) base fov value corresponding to 1x zoom (to properly calculate
	current zoom), defaults to 0.33333

Examples:
	(begin example)
	_fovarray = call CBA_fnc_getFov

	_fovarray = 0.4 call CBA_fnc_getFov
	(end)

Returns:
	Array [fov,zoom]

Author:
	q1184

---------------------------------------------------------------------------- */

#include <script_component.hpp>
#define __dist 1

private ["_xoff","_wreal","_pos","_pos2","_xpos","_xpos2","_deltax","_fov","_k"];

_k = if (typename _this == "SCALAR") then {_this} else {0.33333};

_wreal = safezonew/2;
_xoff = -0.05*__dist;

_pos = positioncameratoworld [0,0,__dist];
_xpos = (worldtoscreen _pos) select 0;

_pos2 = positioncameratoworld [_xoff,0,__dist];
_xpos2 = worldtoscreen _pos2;

while {count _xpos2 == 0 || {_xoff > -0.001}} do {
	_xoff = _xoff/2;
	_pos2 = positioncameratoworld [_xoff,0,__dist];
	_xpos2 = worldtoscreen _pos2;
};
if (count _xpos2 == 0) exitwith {-1};

_xpos2 = _xpos2 select 0;
_deltax = _xpos - _xpos2;

_fov = (safezoneh/safezonew)*atan((_wreal*abs(_xoff))/(__dist*_deltax));

_fov = _fov*pi/180;

[_fov,_k/_fov]
