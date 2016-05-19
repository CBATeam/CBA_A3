/* ----------------------------------------------------------------------------
Function: CBA_fnc_searchNearby

Description:
    A function for a group to search a nearby building.

Parameters:
    Group (Group or Object)

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
    private _behaviour = behaviour (leader _group);

    // Prepare group to search
    _group setBehaviour "Combat";
    _group setFormDir ((leader _group) getDir _building);

    // Search while there are still available positions
    private _positions = _building buildingPos -1;
    while {!(_positions isEqualTo [])} do {
        // Abort search if the group has no units left
        if ((units _group) isEqualTo []) exitWith {};

        // Send all available units to the next available position
        {
            if (_positions isEqualTo []) exitWith {};
            if (unitReady _x) then {
                private _pos = _positions deleteAt 0;
                _x commandMove _pos;
            };
        } forEach (units _group);

        // Provide time for orders to be carried out
        sleep 10;
    };

    // Once units are all finished searching return to previous tasks
    waitUntil {sleep 3; {unitReady _x} count (units _group) >= count (units _group) - 1};
    {
        _x doFollow (leader _group);
    } forEach (units _group);
    _group setBehaviour _behaviour;
    _group lockWP false;
};
