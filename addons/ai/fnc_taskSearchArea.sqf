#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_taskSearchArea

Description:
    Given group will indefinitely randomly search the given marker/trigger area.

    Will also perform random building searches.

Parameters:
    _group - The group that will search [Group or Object]
    _area - The area to search [Marker, Trigger or Area Array]

Optional:
    _behaviour - Waypoint behaviour [String, defaults to "UNCHANGED"]
    _combat - Waypoint combat mode [String, defaults to "NO CHANGE"]
    _speed - Waypoint speed [String, defaults to "UNCHANGED"]
    _formation - Waypoint formation [String, defaults to "NO CHANGE"]
    _onComplete - Waypoint completion code [String, defaults to ""]
    _timeout - Waypoint timeout [Array, defaults to [0,0,0]]

Returns:
    None

Examples:
   (begin example)
   [this, "Mark1"] call CBA_fnc_taskSearchArea;
   [(allGroups select 2), [getPos player, 200, 200, 0, false]] call CBA_fnc_taskSearchArea;
   (end)

Author:
    SilentSpike 2015-08-17
---------------------------------------------------------------------------- */
params [
    ["_group", objNull, [objNull,grpNull]],
    ["_area", "", ["",objNull, locationNull,[]], 5],
    ["_behaviour", "UNCHANGED", [""]],
    ["_combat", "NO CHANGE", [""]],
    ["_speed", "UNCHANGED", [""]],
    ["_formation", "NO CHANGE", [""]],
    ["_onComplete", "", [""]],
    ["_timeout", [0, 0, 0], [[]], 3]
];

_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine

// Collect arguments for use in recursive calls (not using `select` to include default values)
private _args = [_area, _behaviour, _combat, _speed, _formation, _onComplete, _timeout];

// Retrieve cached arguments in case of recursive call
if (isNil {param [1]}) then {
    _args = _group getVariable [QGVAR(taskSearch), _args];
} else {
    // Clear existing waypoints and cache arguments upon first call
    [_group] call CBA_fnc_clearWaypoints;
    {
        _x enableAI "PATH";
    } forEach units _group;

    _group setVariable [QGVAR(taskSearch), _args];
};
_args params ["_area", "_behaviour", "_combat", "_speed", "_formation", "_onComplete", "_timeout"];

// Select a random position in the area
private _pos = [_area] call CBA_fnc_randPosArea;

// Exit if any bad input was used (has to run after all the above code)
if ((_pos isEqualTo []) || {_area isEqualTo ""} || {isNull _group}) exitWith {ERROR_3("Bad Input [_pos: %1][_area: %2][_group: %3]", _pos, _area, _group);};

// Prepare recursive function call statement
private _statements = ["[this] call CBA_fnc_taskSearchArea"];

// Prepare building search statement
private _building = nearestBuilding _pos;
if ((_building distanceSqr _pos) < 400) then {
    // Clear waypoint to prevent getting stuck in a search loop
    _statements append [
        "deleteWaypoint [group this, currentWaypoint (group this)]",
        "[group this] call CBA_fnc_searchNearby"
    ];
};

// Inject the statement in this order to ensure valid syntax
_statements pushBack _onComplete;
_onComplete = _statements joinString ";";

// Add the waypoint
[
    _group,
    _pos,
    0,
    "MOVE",
    _behaviour,
    _combat,
    _speed,
    _formation,
    _onComplete,
    _timeout,
    5
] call CBA_fnc_addWaypoint;
