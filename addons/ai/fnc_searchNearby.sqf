/* ----------------------------------------------------------------------------
Function: CBA_fnc_searchNearby

Description:
    A function for a group to search a nearby building.

Parameters:
    - Group (Group or Object)

Example:
    (begin example)
    [group player] call CBA_fnc_searchNearby
    (end)

Returns:
    Nil

Author:
    Rommel, SilentSpike

---------------------------------------------------------------------------- */

params ["_group",["_timeoutcoef",-1],["_maxtimeout",-1]];

_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine

private _building = nearestBuilding (leader _group);
if ((leader _group) distanceSqr _building > 250e3) exitwith {};

[_group, _building] spawn {
    params ["_group", "_building","_timeoutcoef","_maxtimeout"];
    private _leader = leader _group;

    // Add a waypoint to regroup after the search
    _group lockWP true;
    private _wp = _group addWaypoint [getPosASL _leader, -1, currentWaypoint _group];
    private _cond = "({unitReady _x || !(alive _x)} count thisList) == count thisList";
    private _comp = format ["this setFormation '%1'; this setBehaviour '%2'; deleteWaypoint [group this, currentWaypoint (group this)];", formation _group, behaviour _leader];
    _wp setWaypointStatements [_cond, _comp];

    // Prepare group to search
    _group setBehaviour "Combat";
    _group setFormDir ([_leader, _building] call BIS_fnc_dirTo);

    // Leader will only wait outside if group larger than 2
    if (count (units _group) <= 2) then {
        _leader = objNull;
    };

    // Search while there are still available positions
    private _positions = _building buildingPos -1;

    // Create limiters for each unit
    private _timeout = if (_timeoutcoef > -1 && _maxtimeout > -1) then {(
        count _positions * _timeoutcoef) min _maxtimeout
    } else {
        -1 
    };
    private _timetag = QGVAR(StartSearchTime);
    {_x setVariable [_timetag,time]} forEach units _group;

    while {_positions isNotEqualTo []} do {
        // Update units in case of death
        private _units = (units _group) - [_leader];

        // Abort search if the group has no units left
        if (_units isEqualTo []) exitWith {};

        // Send all available units to the next available position
        {
            if (_positions isEqualTo []) exitWith {};
            if (unitReady _x || {if (_timeout > -1) then {(_x getVariable _timetag) + _timeout < time} else {false}) then {
                private _pos = _positions deleteAt 0;
                _x commandMove _pos;
                _x setVariable [_timetag,time];
                sleep 2;
            };

            sleep .25;
        } forEach _units;
    };
    _group lockWP false;
};
