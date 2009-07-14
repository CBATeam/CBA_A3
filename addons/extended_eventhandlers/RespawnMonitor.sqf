/*
	The respawn monitor is only useful for the two respawn types
	"INSTANT" (2) and "BASE" (3) where a completely new player
	unit is created when he or she respawns. For the other respawn
	types (where none is the default unless explicitly specified
	in the description.ext file), we don't need to run this.
*/
private [
	"_cfgRespawn", "_respawn", "_nomonitor", "_initEH", "_name",
	"_playerIsNamed", "_getUnit"
];

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

// Track all playable units (players and AI alike) and when they respawn,
// re-run the Extended Init EH:s on the units that have a "composite" init
// EH defined with the respawn property set to true
_playerIsNamed=false;
{
	_name=vehicleVarName _x;
	
	if (_name != "") then
	{
		if (local player && (player == call compile _name)) then
		{
			_playerIsNamed=true;
		};
		_h=_name spawn
		{
			_getUnit=compile _this;
			_unit=call _getUnit;
			//diag_log text format["XEH RMon: monitoring %1 (%2)",_this, _unit];
			while {true} do
			{
				waitUntil {!alive _unit};
				//waitUntil {_unit == _unit}; // ??
				waitUntil {alive (call _getUnit)};
				_unit=call _getUnit;
				//diag_log text format["XEH RMon: %1 respawned. Re-running SLX_XEH_init", _this];
				if (!isNil "_unit" && !isNull _unit) then
				{
					[_unit, "Extended_Init_EventHandlers", true] call SLX_XEH_init;
				};
				sleep 0.5;
			};
		};
	};
} forEach playableUnits;

// Fallback: playableUnits may contain unnamed units, ie units that have no
// name set in the mission editor. Such units are not monitored by the
// threads created above. If the unit the player on this machine is controlling 
// is not named, fall back to the old XEH way of tracking the player unit.
if (!_playerIsNamed) then
{
	while { true } do
	{
		waitUntil { !(alive player) };
		waitUntil { player == player };
		waitUntil { alive player };
		[player, "Extended_Init_EventHandlers", true] call SLX_XEH_init;
		sleep 0.5;
	};
	//diag_log text "XEH: 'legacy' player respawn monitor started";
};
nil;

