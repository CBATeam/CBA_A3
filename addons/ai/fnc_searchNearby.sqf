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

params ["_group"];
_group = _group call CBA_fnc_getGroup;
_group lockWP true;

private _building = nearestBuilding (leader _group);
if ((leader _group) distanceSqr _building > 250e3) exitwith {_group lockWP false};

[_group,_building] spawn {
    params ["_group","_building"];
    private _leader = leader _group;
    private _behaviour = behaviour _leader;

    // Prepare group to search
    _group setBehaviour "Combat";
    _group setFormDir ([_leader, _building] call BIS_fnc_dirTo);

    // Leader will only wait outside if group larger than 2
    if (count (units _group) <= 2) then {
        _leader = objNull;
    };

    // Search while there are still available positions
    private _positions = _building buildingPos -1;
    while {!(_positions isEqualTo [])} do {
        // Update units in case of death
        private _units = (units _group) - [_leader];

        // Abort search if the group has no units left
        if (_units isEqualTo []) exitWith {};

        // Send all available units to the next available position
        {
            if (_positions isEqualTo []) exitWith {};
            if (unitReady _x) then {
                private _pos = _positions deleteAt 0;
                _x commandMove _pos;
            };
        } forEach _units;

        // Provide time for orders to be carried out
        sleep 10;
    };

    // Once units are all finished searching return to previous tasks
    waitUntil {
        sleep 3;
        private _units = (units _group) - [_leader];
        ({unitReady _x} count _units) >= count _units
    };
    {
        _x doFollow (leader _group); // Not using _leader in case of death
    } forEach (units _group);
    _group setBehaviour _behaviour;
    _group lockWP false;
};
