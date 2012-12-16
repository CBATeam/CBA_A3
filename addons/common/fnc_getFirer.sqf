/* ----------------------------------------------------------------------------
Function: CBA_fnc_getFirer

Description:
	A function used to find out which unit exactly fired (Replacement for gunner, on multi-turret vehicles).

Parameters:
	Vehicle that fired
	Weapon that was used

Example:
    (begin example)
	_unit = player call CBA_fnc_getFirer
    (end)

Returns:
	Unit
	Turretpath

Author:
	Rocko

---------------------------------------------------------------------------- */

// #define DEBUG_MODE_FULL
#include "script_component.hpp"
#define __cfg (configFile >> "CfgVehicles" >> (typeof _veh) >> "turrets")
private ["_tp", "_tc", "_st", "_stc", "_wtp", "_tu", "_mti", "_mtJ", "_sti", "_stJ", "_gunner", "_mainWeapons", "_r", "_cfg", "_entry"];
PARAMS_2(_veh,_weap);  // Vehicle that fired	// Weapon that was fired
if (_veh isKindOf "CAManBase") exitWith { _r = [_veh, []]; TRACE_1("Result",_r); _r; }; // return the unit itself when it's a Man
if (_veh isKindOf "Air") exitWith { _gunner = gunner _veh; _r = [if (isNull _gunner) then { driver _veh } else { _gunner }, [0]]; TRACE_1("Result",_r); _r; };

_tc  = count __cfg;
if (_tc == 0) exitWith { _r = [objNull, []]; TRACE_1("Result",_r); _r };

_tp = [];

// TODO: Only supports Main Turrets, and SubTurrets on MainTurrets.  No need for infinite level?
// Check MainTurrets
_mtJ = 0; // Custom counter since we ignore class properties (non subclasses)
for "_mti" from 0 to (_tc-1) do {
	_cfg = (__cfg select _mti);
	if (isClass _cfg) then {
		_entry = [_mtJ];
		PUSH(_tp, _entry);

		// Check SubTurrets
		_st = _cfg >> "turrets";
		_stc = count _st;
		if (_stc > 0) then {
			_stJ = 0; // Custom counter since we ignore class properties (non subclasses)
			for "_sti" from 0 to (_stc-1) do {
				_stp = _st select _sti;
				if (isClass _stp) then {
					_entry = [_mtJ, _stJ];
					PUSH(_tp, _entry);

					INC(_stJ);
				};
			};
		};
		INC(_mtJ);
	};
};

_wtp = [];
{
	_weapons = getArray([_veh, _x] call CBA_fnc_getTurret >> "weapons");
	TRACE_3("",_weapons,_x,_veh turretUnit _x);
	if (_weap in _weapons) exitWith { _wtp = _x; };
} foreach _tp;

if (count _wtp == 0) exitWith { _r = [objNull, []]; TRACE_1("Result",_r); _r; }; // Or should we exit with gunner _veh ?

_r = [_veh turretUnit _wtp, _wtp];
TRACE_1("Result",_r);
_r;
