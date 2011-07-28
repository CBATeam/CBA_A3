/* ----------------------------------------------------------------------------
Function: CBA_fnc_inArea

Description:
	A function used to determine if a position is within a zone.

	The "position" can be given as a marker name, an object,
	location, group or a position array.

	The zone is specificed either as a marker name or a trigger.

Parameters:
	A two-element array, [ position, zone], where

	- position: Marker|Object|Location|Group|Position
	- zone:     Marker|Trigger

Example:
	(begin example)
	// Is the marker "playermarker" inside the "safezone" marker area?
	_safe = [ "playermarker", "safezone"] call CBA_fnc_inArea;

	// is the player within the safe zone marker area?
	_pos = getPos player;
	_safe = [ _pos, "safezone" ] call CBA_fnc_inArea;

	// Deny artillery if target is inside the trigger area
	if ([_target, cityTrigger] call CBA_fnc_inArea) then
	{
		// deny fire mission
	}
	else
	{
		// fire away!
	};
	(end)	

Returns:
	Boolean

Author:
	Rommel

---------------------------------------------------------------------------- */
#include "script_component.hpp"

PARAMS_2(_position,_zRef);

_position = (_position call CBA_fnc_getpos);

private ["_typename"];
_typename = tolower (typename _zRef);

private ["_zSize","_zDir","_zShape","_zPos"];
switch (_typeName) do {
	case ("string") : {
		_zSize = markerSize _zRef;
		_zDir = markerDir _zRef;
		_zShape = tolower (markerShape _zRef);
		_zPos = (_zRef call CBA_fnc_getpos);
	};
	case ("object") : {
		_zSize = triggerArea _zRef;
		_zDir = _zSize select 2;
		_zShape = if (_zSize select 3) then {"rectangle"} else {"ellipse"};
		_zPos = getpos _zRef;
	};
};

if (isnil "_zSize") exitwith {false};

_position = [_zPos,_position,_zDir] call CBA_fnc_vectRotate2D;

private ["_x1","_y1"];
_x1 = _zpos select 0;
_y1 = _zpos select 1;

private ["_x2","_y2"];
_x2 = _position select 0;
_y2 = _position select 1;

private ["_dx","_dy"];
_dx = _x2 - _x1;
_dy = _y2 - _y1;

private ["_zx","_zy"];
_zx = _zsize select 0;
_zy = _zsize select 1;

switch (_zShape) do {
	case ("ellipse") : {
		((_dx^2)/(_zx^2) + (_dy^2)/(_zy^2)) < 1
	};
	case ("rectangle") : {
		(abs _dx < _zx) and (abs _dy < _zy)
	};
};