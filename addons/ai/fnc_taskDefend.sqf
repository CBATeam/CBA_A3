/* ----------------------------------------------------------------------------
Function: CBA_fnc_taskDefend

Description:
    A function for a group to defend a parsed location.

    Groups will mount nearby static machine guns and bunker in nearby buildings.
    They may also patrol the radius unless otherwise specified.

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
    Rommel, SilentSpike

---------------------------------------------------------------------------- */

params ["_group", ["_position",[]], ["_radius",50,[0]], ["_threshold",2,[0]], ["_patrol",true,[true]]];

_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine

_position = [_position,_group] select (_position isEqualTo []);
_position = _position call CBA_fnc_getPos;

[_group] call CBA_fnc_clearWaypoints;
_group enableAttack false;

private _statics = _position nearObjects ["StaticWeapon", _radius];
private _buildings = _position nearObjects ["Building", _radius];

// Filter out occupied statics
[_statics,{(_x emptyPositions "Gunner") > 0},true] call CBA_fnc_filter;

// Filter out buildings below the size threshold (and store positions for later use)
{
    if ((_x buildingPos _threshold) isEqualto [0,0,0]) then {
        _buildings set [_forEachIndex,nil];
    } else {
        private _positions = _x buildingPos -1;

        if (isNil {_x getVariable "CBA_taskDefend_positions"}) then {
            _x setVariable ["CBA_taskDefend_positions",_positions];
        };
    };
} forEach _buildings;
_buildings = _buildings arrayIntersect _buildings;

// v1.56 version of the above
/*_buildings = _buildings select {
    private _positions = _x buildingPos -1;

    if (isNil {_x getVariable "CBA_taskDefend_positions"}) then {
        _x setVariable ["CBA_taskDefend_positions",_positions];
    };

    count (_positions) > _threshold
};*/

private _units = units _group;
private _assigned = 0;
{
    // 31% chance to occupy nearest free static weapon
    if ((random 1 < 0.31) && { !(_statics isEqualto []) }) then {
        _x assignAsGunner (_statics deleteAt 0);
        [_x] orderGetIn true;

        _assigned = _assigned + 1;
    } else {
        // 93% chance to occupy a random nearby building position
        if ((random 1 < 0.93) && { !(_buildings isEqualto []) }) then {
            private _building = _buildings call BIS_fnc_selectRandom;
            private _array = _building getVariable ["CBA_taskDefend_positions",[]];

            if !(_array isEqualTo []) then {
                private _pos = _array deleteAt (floor(random(count _array)));

                // If building positions are all taken remove from possible buildings
                if (_array isEqualTo []) then {
                    _buildings = _buildings - [_building];
                    _building setVariable ["CBA_taskDefend_positions",nil];
                };
                _building setVariable ["CBA_taskDefend_positions",_array];

                // AI manipulation trickey to keep them in position until commanded to move
                [_x, _pos] spawn {
                    params ["_unit","_pos"];
                    if (surfaceIsWater _pos) exitwith {};

                    _unit doMove _pos;
                    sleep 5;
                    waituntil {unitReady _unit};
                    _unit disableAI "move";
                    doStop _unit;
                    waituntil {!(unitReady _unit)};
                    _unit enableAI "move";
                };

                _assigned = _assigned + 1;
            };
        };
    };
} forEach _units;

// If half of the group's units aren't assigned then patrol
if (_patrol && {_assigned < (count _units) * 0.5}) then {
    [_group, _position, _radius, 5, "sad", "safe", "red", "limited"] call CBA_fnc_taskpatrol;
};
