/* ----------------------------------------------------------------------------
Function: CBA_fnc_taskDefend

Description:
    A function for a group to defend a parsed location. Should be ran locally.

    Units will mount nearby static machine guns and garrison in nearby buildings.
    10% chance to patrol the radius unless specified differently (100% when no available building positions).
    0% chance to hold defensive positions in combat unless specified differently.

Parameters:
    _group      - the group <GROUP, OBJECT>
    _position   - centre of area to defend <ARRAY, OBJECT, LOCATION, GROUP> (Default: _group)
    _radius     - radius of area to defend <NUMBER> (Default: 50)
    _threshold  - minimum building positions required to be considered for garrison <NUMBER> (Default: 3)
    _patrol     - chance for each unit to patrol instead of garrison, true for default, false for 0% <NUMBER, BOOLEAN> (Default: 0.1)
    _hold       - chance for each unit to hold their garrison in combat, true for 100%, false for 0% <NUMBER, BOOLEAN> (Default: 0)

Returns:
    None

Examples:
    (begin example)
        [this] call CBA_fnc_taskDefend
    (end)

Author:
    Rommel, SilentSpike
---------------------------------------------------------------------------- */
params [
    ["_group", grpNull, [grpNull, objNull]],
    ["_position", [], [[], objNull, grpNull, locationNull], 3],
    ["_radius", 50, [0]],
    ["_threshold", 3, [0]],
    ["_patrol", 0.1, [true, 0]],
    ["_hold", 0, [true, 0]]
];

// Input validation stuff here
_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine

_position = [_position, _group] select (_position isEqualTo []);
_position = _position call CBA_fnc_getPos;

if (_patrol isEqualType true) then {
    _patrol = [0, 0.1] select _patrol;
};

if (_hold isEqualType true) then {
    _hold = [0,1] select _hold;
};

// Start of the actual function
[_group] call CBA_fnc_clearWaypoints;
{
    _x enableAI "PATH";
} forEach units _group;

private _statics = _position nearObjects ["StaticWeapon", _radius];
private _buildings = _position nearObjects ["Building", _radius];

// Filter out occupied statics
_statics = _statics select {locked _x != 2 && {(_x emptyPositions "Gunner") > 0}};

// Filter out buildings below the size threshold (and store positions for later use)
_buildings = _buildings select {
    private _positions = _x buildingPos -1;

    if (isNil {_x getVariable "CBA_taskDefend_positions"}) then {
        _x setVariable ["CBA_taskDefend_positions", _positions];
    };

    count (_positions) >= _threshold
};

// If patrolling is enabled then the leader must be free to lead it
private _units = units _group;
if (_patrol > 0 && {count _units > 1}) then {
    _units deleteAt (_units find (leader _group));
};

{
    // 31% chance to occupy nearest free static weapon
    if ((random 1 < 0.31) && { !(_statics isEqualto []) }) then {
        _x assignAsGunner (_statics deleteAt 0);
        [_x] orderGetIn true;
    } else {
        // Respect chance to patrol, or force if no building positions left
        if !((_buildings isEqualto []) || { (random 1 < _patrol) }) then {
            private _building = selectRandom _buildings;
            private _array = _building getVariable ["CBA_taskDefend_positions", []];

            if !(_array isEqualTo []) then {
                private _pos = _array deleteAt (floor (random (count _array)));

                // If building positions are all taken remove from possible buildings
                if (_array isEqualTo []) then {
                    _buildings deleteAt (_buildings find _building);
                    _building setVariable ["CBA_taskDefend_positions", nil];
                } else {
                    _building setVariable ["CBA_taskDefend_positions", _array];
                };

                // Wait until AI is in position then force them to stay
                [_x, _pos, _hold] spawn {
                    params ["_unit", "_pos", "_hold"];
                    if (surfaceIsWater _pos) exitwith {};

                    _unit doMove _pos;
                    waituntil {unitReady _unit};
                    if (random 1 < _hold) then {
                        _unit disableAI "PATH";
                    } else {
                        doStop _unit;
                    };

                    // This command causes AI to repeatedly attempt to crouch when engaged
                    // If ever fixed by BI then consider uncommenting
                    // _unit setUnitPos "UP";
                };
            };
        };
    };
} forEach _units;

// Unassigned (or combat reacted) units will patrol
[_group, _position, _radius, 5, "sad", "safe", "red", "limited"] call CBA_fnc_taskPatrol;
