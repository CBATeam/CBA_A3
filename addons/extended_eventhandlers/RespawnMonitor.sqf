/*
   The respawn monitor is only useful for the two respawn types
   "INSTANT" (2) and "BASE" (3) where a completely new player
   unit is created when he or she respawns. For the other respawn
   types (where none is the default unless explicitly specified
   in the description.ext file), we don't need to run this.
*/
private ["_cfgRespawn", "_respawn", "_nomonitor", "_initEH"];

_cfgRespawn = (missionConfigFile/"respawn");

_nomonitor = true;
if ( isNumber(_cfgRespawn) ) then
{
	_respawn = getNumber(_cfgRespawn);
	_nomonitor = _respawn in [0, 1, 4, 5];
};
if ( isText(_cfgRespawn) ) then
{
	_respawn = getText(_cfgRespawn);
	_nomonitor = { _respawn == _x }count["none", "bird", "group", "side"]>0;
};
if (_nomonitor) exitWith {};

// waitUntil { SLX_XEH_MACHINE select 5 };
// if !(SLX_XEH_MACHINE select 0) exitWith {};

while { true } do
{
	waitUntil { !(alive player) };
	waitUntil { player == player };
	waitUntil { alive player };
	[player, "Extended_Init_EventHandlers", true] call SLX_XEH_init;
};
