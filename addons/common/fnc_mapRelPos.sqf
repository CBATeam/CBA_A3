/* ----------------------------------------------------------------------------
Function: CBA_fnc_mapRelPos

Description:
	Find a position relative to a known position on the map. Passing strings
	in for the Northing and Easting is the preferred way.

Parameters:
	_pos - Position in 10 digit grid format [Easting, Northing] [Array]
	_dist - Distance from the starting position [Number]
	_dir  - Direction from the starting position [Number]

Returns:
	New grid reference (10 digit) in format [Easting, Northing]
	
Examples:
	(begin example)
		_endPos = [[024,015], 20, 45] call CBA_fnc_mapDirTo;
	(end)
	(begin example)
		// preferred
		_endPos = [["024","015"], 20, 45] call CBA_fnc_mapDirTo;
	(end)
Author:
	Nou (with credit to Headspace, Rommel & Meat187 for the real math :p)
---------------------------------------------------------------------------- */
#include "script_component.hpp"

SCRIPT(mapRelPos);

private ["_pos","_dist","_dir","_northing","_easting","_northingSize",
         "_eastingSize","_e","_n","_posArray","_ea","_na"];

_pos  = _this select 0;
_dist = _this select 1;
_dir  = _this select 2;

if(IS_STRING(_pos)) then {
    _posArray = toArray _pos;
    _pos = [];
    _ea = [];
    for "_i" from 0 to (((count _posArray)/2)-1) do {
        _ea set [(count _ea), _posArray select _i];
    };
    _na = [];
    for "_i" from (((count _posArray)/2)) to (((count _posArray))-1) do {
        _na set [(count _na), _posArray select _i];
    };
    _pos set[0, (toString _ea)];
    _pos set[1, (toString _na)];
};

_easting = _pos select 0;
_northing = _pos select 1;

if(IS_NUMBER(_easting)) then {
    _easting = format["%1", _easting];
};
if(IS_NUMBER(_northing)) then {
    _northing = format["%1", _northing];
};

_eastingSize = (count (toArray _easting)) min 5;
_northingSize = (count (toArray _northing)) min 5;

// Convert the numbers into 5 digits out of a 10 digit ref
_e = (parseNumber _easting)*(10^((10-(_eastingSize*2))/2));
_n = (parseNumber _northing)*(10^((10-(_northingSize*2))/2));

_pos = [_e, _n];

// flip the Y position into its negative value (to compensate for the northings 
// going down)
_pos set [1, ((_pos select 1)*-1)];

//find position relative to passed position
_pos = [floor ((_pos select 0) + _dist*sin _dir), floor ((_pos select 1) + _dist*cos _dir)];
_pos set [1, ((_pos select 1)*-1)];

_pos set [0, ([_pos select 0, 5] call CBA_fnc_formatNumber)];
_pos set [1, ([_pos select 1, 5] call CBA_fnc_formatNumber)];

_pos
