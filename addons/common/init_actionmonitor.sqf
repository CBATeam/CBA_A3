#include "script_component.hpp"
///////////////////////////////////////////////////////////
// ArmA - actionmonitor.sqf v1.0 Original by BN880, converted by Sickboy (sb_at_dev-heaven.net), 6th Sense - Share the Spirit
// THIS IS FOR PLAYER ACTIONS ONLY  CoC Bn880 11/2003
///////////////////////////////////////////////////////////
private ["_actions", "_i", "_veh"];

while { true } do
{
	_veh = vehicle player;
	_actions = []; _i = 0; _c = count GVAR(actionlist);
	{ _actions set [_i, (vehicle player) addAction (_x select 0)]; _i = _i + 1 } foreach GVAR(actionlist);
	waitUntil { vehicle player != _veh || !(alive player) || count GVAR(actionlist) != _c };
	_i = 0;
	{ _veh removeAction _x; player removeAction _x } foreach _actions;
	sleep 1;
};
