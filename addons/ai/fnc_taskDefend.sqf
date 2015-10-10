/* ----------------------------------------------------------------------------
Function: CBA_fnc_taskDefend

Description:
    A function for a group to defend a parsed location. Groups will mount nearby static machine guns, and bunker in nearby buildings. They may also patrol the radius unless otherwise specified.

Parameters:
    - Group (Group or Object)

Optional:
    - Position (XYZ, Object, Location or Group)
    - Defend Radius (Scalar)
    - Building Size Threshold (Integer, default 2)
    - Can patrol (boolean)

Example:
    (begin example)
    [this] call CBA_fnc_taskDefend
    (end)

Returns:
    Nil

Author:
    Rommel

---------------------------------------------------------------------------- */

params ["_group", ["_position",[]], ["_radius",50], ["_threshold",2]];

_group = [_group] call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine

_position = [_position,_group] select (_position isEqualTo []);
_position = _position call CBA_fnc_getPos;

_group enableattack false;

private ["_count", "_list", "_list2", "_units", "_i"];
_statics = [_position, vehicles, _radius, {(_x iskindof "StaticWeapon") && {(_x emptypositions "Gunner" > 0)}}] call CBA_fnc_getnearest;
_buildings = _position nearObjects ["building",_radius];
_units = units _group;
_count = count _units;

{
    if (str(_x buildingpos _threshold) == "[0,0,0]") then {_buildings = _buildings - [_x]};
} foreach _buildings;
_i = 0;
{
    _count = (count _statics) - 1;
    if (random 1 < 0.31 && {_count > -1}) then {
        _x assignasgunner (_statics select _count);
        _statics resize _count;
        [_x] ordergetin true;
        _i = _i + 1;
    } else {
        if (random 1 < 0.93 && {count _buildings > 0}) then {
            private ["_building","_p","_array"];
            _building = _buildings call BIS_fnc_selectRandom;
            _array = _building getvariable "CBA_taskDefend_positions";
            if (isnil "_array") then {
                private "_k"; _k = 0;
                _building setvariable ["CBA_taskDefend_positions",[]];
                while {str(_building buildingpos _k) != "[0,0,0]"} do {
                    _building setvariable ["CBA_taskDefend_positions",(_building getvariable "CBA_taskDefend_positions") + [_k]];
                    _k = _k + 1;
                };
                _array = _building getvariable "CBA_taskDefend_positions";
            };
            if (count _array > 0) then {
                _p = (_building getvariable "CBA_taskDefend_positions") call BIS_fnc_selectRandom;
                _array = _array - [_p];
                if (count _array == 0) then {
                    _buildings = _buildings - [_building];
                    _building setvariable ["CBA_taskDefend_positions",nil];
                };
                _building setvariable ["CBA_taskDefend_positions",_array];
                [_x,_building buildingpos _p] spawn {
                    if (surfaceIsWater (_this select 1)) exitwith {};
                    (_this select 0) domove (_this select 1);
                    sleep 5;
                    waituntil {unitready (_this select 0)};
                    (_this select 0) disableai "move";
                    dostop _this;
                    waituntil {not (unitready (_this select 0))};
                    (_this select 0) enableai "move";
                };
                _i = _i + 1;
            };
        };
    };
} foreach _units;
{
    _x setvariable ["CBA_taskDefend_positions",nil];
} foreach _buildings;
if (count _this > 4 && {!(_this select 4)}) then {_i = _count};
if (_i < _count * 0.5) then {
    [_group, _position, _radius, 5, "sad", "safe", "red", "limited"] call CBA_fnc_taskpatrol;
};
