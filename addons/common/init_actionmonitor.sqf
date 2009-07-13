#include "script_component.hpp"
///////////////////////////////////////////////////////////
// ArmA - actionmonitor.sqf v1.0 Original by BN880, converted by Sickboy (sb_at_dev-heaven.net), 6th Sense - Share the Spirit
// THIS IS FOR PLAYER ACTIONS ONLY  CoC Bn880 11/2003
///////////////////////////////////////////////////////////
private ["_actions", "_i", "_v"];

while { true } do
{
	_actions = []; _i = 0;
	_veh = vehicle player; _c = count GVAR(actionlist);
	{ _actions set[_i,call compile ("vehicle "+_x)]; _i = _i+1 } foreach GVAR(actionlist);
	waitUntil { vehicle player!= _veh||!(alive player)||count GVAR(actionlist) != _c };
	_i = 0;
	{ _veh removeaction _x;player removeaction _x } foreach _actions;
	sleep 2;
};
