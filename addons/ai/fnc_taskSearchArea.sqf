/* ----------------------------------------------------------------------------
Function: CBA_fnc_taskSearchArea

Description:
    Given group will indefinitely randomly search the given marker/trigger area.

    Will also perform random building searches.

Parameters:
    _group - The group that will search [Group or Object]
    _area - The area to search [Marker or Trigger]

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
   (end)

Author:
    SilentSpike 2015-08-17
---------------------------------------------------------------------------- */
#include "script_component.hpp"
params [
    ["_group", objNull, [objNull,grpNull]],
    ["_area", "", ["",objNull,locationNull,[]], 5],
    ["_behaviour", "UNCHANGED", [""]],
    ["_combat", "NO CHANGE", [""]],
    ["_speed", "UNCHANGED", [""]],
    ["_formation", "NO CHANGE", [""]],
    ["_onComplete", "", [""]],
    ["_timeout", [0,0,0], [[]], 3]
];

_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine

// Collect arguments for use in recursive calls (not using `select` to include default values)
private _args = [_area,_behaviour,_combat,_speed,_formation,_onComplete,_timeout];

// Retrieve cached arguments in case of recursive call
if (isNil {param [1]}) then {
    _args = _group getVariable [QGVAR(taskSearch),_args];
} else {
    // Clear existing waypoints and cache arguments upon first call
    [_group] call CBA_fnc_clearWaypoints;
    _group setVariable [QGVAR(taskSearch),_args];
};
_args params ["_area","_behaviour","_combat","_speed","_formation","_onComplete","_timeout"];

// Select a random position in the area
private _pos = [_area] call CBA_fnc_randPosArea;

// Exit if any bad input was used (has to run after all the above code)
if ((_pos isEqualTo []) || {_area isEqualTo ""} || {isNull _group}) exitWith {};

// Prepare recursive function call statement
private _statement = "[this] call CBA_fnc_taskSearchArea;";

// Prepare building search statement
private _building = nearestBuilding _pos;
if ((_building distanceSqr _pos) < 400) then {
    _statement = _statement + "[this] call CBA_fnc_searchNearby;";
};

// Inject the statement in this order to ensure valid syntax
_onComplete = _statement + _onComplete;

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
