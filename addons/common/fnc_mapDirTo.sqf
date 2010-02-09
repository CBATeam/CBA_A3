/* ----------------------------------------------------------------------------
Function: CBA_fnc_mapDirTo

Description:
	Gets the direction between two map grid references.
	
Parameters:
	_pos1 - Origin position array in format [Easting, Northing] [Array]
	_pos2 - End position in format [Easting, Northing] [Array]

Returns:
	Direction from _pos1 to _pos2 [Number]
	
Examples:
	(begin example)
		_dir = [[024,015], [025,014]] call CBA_fnc_mapDirTo;
		// _dir will be 45 degrees
	(end)
	(begin example)
		_dir = [["024","015"], ["025","014"]] call CBA_fnc_mapDirTo;
		// _dir will be 45 degrees
	(end)
	(begin example)
		_dir = ["024015", "025014"] call CBA_fnc_mapDirTo;
		// _dir will be 45 degrees
	(end)


Author:
	Nou (with credit to Headspace for the real math :p)
---------------------------------------------------------------------------- */
#include "script_component.hpp"

SCRIPT(mapDirTo);

private ["_pos1","_pos2","_ret","_x1","_x2","_y1","_y2"];

_pos1 = _this select 0;
_pos2 = _this select 1;

if(IS_STRING(_pos1)) then {
    _posArray = toArray _pos1;
    _pos1 = [];
    _ea = [];
    for "_i" from 0 to (((count _posArray)/2)-1) do {
        _ea set [(count _ea), _posArray select _i];
    };
    _na = [];
    for "_i" from (((count _posArray)/2)) to (((count _posArray))-1) do {
        _na set [(count _na), _posArray select _i];
    };
    _pos1 set[0, parseNumber (toString _ea)];
    _pos1 set[1, parseNumber (toString _na)];
};



if(IS_STRING(_pos2)) then {
    _posArray = toArray _pos2;
    _pos2 = [];
    _ea = [];
    for "_i" from 0 to (((count _posArray)/2)-1) do {
        _ea set [(count _ea), _posArray select _i];
    };
    _na = [];
    for "_i" from (((count _posArray)/2)) to (((count _posArray))-1) do {
        _na set [(count _na), _posArray select _i];
    };
    _pos2 set[0, parseNumber (toString _ea)];
    _pos2 set[1, parseNumber (toString _na)];
};

_x1 = _pos1 select 0;
_x2 = _pos2 select 0;
_y1 = _pos1 select 1;
_y2 = _pos2 select 1;

// check if easting/northings are strings, if so convert.
if(IS_STRING(_x1)) then {
    _x1 = parseNumber _x1;
};

if(IS_STRING(_x2)) then {
    _x2 = parseNumber _x2;
};

if(IS_STRING(_y1)) then {
    _y1 = parseNumber _y1;
};

if(IS_STRING(_y2)) then {
    _y2 = parseNumber _y2;
};

player sideChat format["%1 %2 %3 %4", _x1, _x2, _y1, _y2];

//get compass heading from _pos1 to _pos2
_ret = abs (360 - ((((_x1 - _x2) atan2 (_y1 - _y2))) mod 360));
_ret = _ret mod 360;
_ret