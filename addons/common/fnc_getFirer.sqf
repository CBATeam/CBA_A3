/* ----------------------------------------------------------------------------
Function: CBA_fnc_getFirer

Description:
	A function used to find out which unit exactly fired (Replacement for gunner, on multi-turret vehicles).
Parameters:
	Vehicle that fired
	Weapon that was used
Example:
	_unit = player call CBA_fnc_getFirer
Returns:
	Unit
	Turretpath
Author:
	Rocko

---------------------------------------------------------------------------- */

// #define DEBUG_MODE_FULL
#include "script_component.hpp"
#define __cfg (configFile >> "CfgVehicles" >> (typeof _v) >> "turrets")
private ["_tp", "_tc", "_tp", "_st", "_stc", "_wtp", "_tu", "_mainWeapons", "_r"];
PARAMS_2(_v,_w);  // Vehicle that fired	// Weapon that was fired
if (_v isKindOf "CAManBase") exitWith { _r = [_v, []]; TRACE_1("Result",_r); _r; }; // return the unit itself when it's a Man
if (_v isKindOf "Air") exitWith { _gunney = gunner _v; _r = [if (isNull _gunney) then { driver _v } else { _gunney }, [0]]; TRACE_1("Result",_r); _r; };

_tp = [];
_tc  = count __cfg;
if (_tc > 0) then {
	for "_mti" from 0 to (_tc-1) do {
		_tp set [(count _tp), [_mti]];
		_st = (__cfg select _mti) >> "turrets";
		_stc = count _st;
		if (_stc > 0) then {
			for "_sti" from 0 to (_stc-1) do {
				_stp = (_st select _sti);
				_tp set [(count _tp), [_mti,_sti]];
			};
		};
	};
};

_wtp = [];
{
	_weapons = getArray([_v, _x] call CBA_fnc_getTurret >> "weapons");
	TRACE_3("",_weapons,_x,_v turretUnit _x);
	if (_w in _weapons) exitWith { _wtp = _x; };
} foreach _tp;

if (count _wtp == 0) exitWith { _r = [objNull, []]; TRACE_1("Result",_r); _r; }; // Or should we exit with gunner _v ?

_r = [_v turretUnit _wtp, _wtp];
TRACE_1("Result",_r);
_r;
