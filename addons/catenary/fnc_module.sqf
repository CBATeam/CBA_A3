#include "script_component.hpp"

if (!is3DEN) exitWith {};

(_this select 1) params ["_module"];

private _ropeLength = _module getVariable "ArcLength";
private _segmentCount = _module getVariable "SegmentCount";

private _segmentLength = -1;

if (_segmentCount < 0) then {
    _segmentLength = abs _segmentCount;
} else {
    _segmentCount = round _segmentCount;
};

if (_ropeLength < 0) then {
    _ropeLength = format ["%1x", abs _ropeLength];
};

private _connected = get3DENConnections (get3DENSelected "logic" select {
    typeOf _x == QGVAR(start)
} select 0) select {_x select 0 == "Sync"} apply {_x select 1};

// remove old
private _connections = _module getVariable [QGVAR(connections), []];

{
    _x call FUNC(draw);
} forEach _connections;

_connections = [];

// create new
{
    private _netIds = [_module call BIS_fnc_netId, _x call BIS_fnc_netId];
    _netIds sort true;
    private _name = format ([QGVAR(rope%1$%2)] + _netIds);

    _connections pushBackUnique _name;

    private _data = [_module, _x, _ropeLength, _segmentCount, _segmentLength] call FUNC(connect);
    [_name, _data, nil] call FUNC(draw);
} forEach _connected;

_module setVariable [QGVAR(connections), _connections];

nil
