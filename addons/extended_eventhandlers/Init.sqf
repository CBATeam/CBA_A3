#include "script_component.hpp"

private ["_unit"];
_unit = _this select 0;

/*  Extended event handlers by Solus
*
*  Get all inherited classes, then check if each inherited class has a counter-
*  part in the extended event handlers classes, then and add all lines from
*  each matching EH class and exec them.
*/
private [
	"_Extended_Init_Class", "_isRespawn", "_unitClass", "_classes",
	"_inits", "_init", "_excludeClass", "_excludeClasses", "_isExcluded",
	"_onRespawn", "_useEH", "_i", "_t", "_cfgEntry", "_scopeEntry",
	"_initEntry", "_excludeEntry", "_respawnEntry", "_u", "_eic", "_sim", "_crew",
	"_clientInitEntry", "_serverInitEntry", "_serverInit", "_clientInit",
	"_justCreated", "_playable", "_isMan"
];

#ifdef DEBUG_MODE_FULL
diag_log text format["(%1) XEH BEG: %2", time, _this];
#endif
// Get unit.
_unit = _this select 0;
_Extended_Init_Class = _this select 1;
_isRespawn = if (count _this>2) then { _this select 2 } else { false };

//
// Bug #7432 fix - dedicated 1.05 servers will re-run the init EH when a unit
//                 respawns

// A new unit will be similar to "11c67248# 17488: usmc_soldier_co.p3d" in
// string form before it's fully initialised. The "#" character is 35.
_justCreated=(((toArray format["%1",_unit])find 35)>=0);
_playable=_unit getVariable "slx_xeh_playable";
if (isNil "_playable")then{_playable=false};
_isMan = _unit isKindOf "Man";

if (_isMan && (isDedicated && (time>0) && (_justCreated || _playable))) then
{
	if (_justCreated) then
	{
		// Delay initialisation until we can check if it's a respawned unit
		// or a createUnit:ed one. (Respawned units will have the object variable
		// "slx_xeh_isplayable" set to true)
		#ifdef DEBUG_MODE_FULL
		diag_log text format["(%1) XEH: (Bug #7432) deferring init for %2 ",time, _this];
		#endif
		// Wait for the unit to be fully "ready"
		_h=_unit spawn
		{
			waitUntil {((toArray str(_this))find 35) == -1};
			#ifdef DEBUG_MODE_FULL
			diag_log text format["(%1) XEH BEG: (Bug #7432) %2 is now ready for init", time, _this];
			#endif
			[_this, "Extended_Init_EventHandlers"] spawn SLX_XEH_init;
		};
	};
	if (_playable && !_isRespawn) then
	{
		#ifdef DEBUG_MODE_FULL
		diag_log text format ["(%1) XEH: %2 respawned. Don't re-run the init EH", time, _unit];
		#endif
	};
}
else
{
	// Get array of inherited classes of unit.
	_unitClass = typeOf _unit;
	_classes = [_unitClass];
	while { !((_classes select 0) in ["", "All"]) } do
	{
		_classes = [(configName (inheritsFrom (configFile/"CfgVehicles"/(_classes select 0))))]+_classes;
	};
	
	// Check each class to see if there is a counterpart in extended event handlers
	// If there is, add it to an array of init event handlers "_inits"
	_inits = [];
	_init = {};
	_excludeClass = "";
	_excludeClasses = [];
	_isExcluded = { (_unitClass isKindOf _excludeClass) || ({ _unitClass isKindOf _x }count _excludeClasses>0) };
	
	/*  If we're called following a respawn, the use of a XEH init EH is
	*  determined by the "composite EH" class property "onRespawn". The default
	*  is to not call the XEH init EH, since the ArmA default behaviour is that
	*  "init" event handlers are not called when a unit respawns.
	*/
	_onRespawn=false;
	_useEH = { if (_isRespawn) then { _onRespawn } else { true } };
	
	/*
	*  Several BIS vehicles use a set of EH:s in the BIS "DefaultEventhandlers"
	*  ("DEH" in the following) class - Car, Tank, Helicopter, Plane and Ship.
	* 
	*  Further, The AAV class uses a variation of this DefaultEventhandlers set with
	*  it's own specific init EH.  Here, we make sure to include the BIS DEH init
	*  event handler and make it the first one that will be called by XEH. The AAV
	*  is accomodated by code further below and two composite 
	*  Extended_Init_EventHandlers definitions in the config.cpp that define
	*  a property "replaceDefault" which will replace the DEH init with the
	*  class-specific BIS init EH for that vehicle.
	*/
	_useDEHinit = false;
	if (_Extended_Init_Class =="Extended_Init_EventHandlers") then
	{
		_ehSuper = inheritsFrom(configFile/"CfgVehicles"/_unitClass/"EventHandlers");
		if (configName(_ehSuper)=="DefaultEventhandlers") then
		{
			if (isText (configFile/"DefaultEventhandlers"/"init")) then
			{
				_useDEHinit = true;
				_DEHinit = getText(configFile/"DefaultEventhandlers"/"init");
				_inits = [compile(_DEHinit)];
			};
		};
	};
	
	{
		_configFile=_x;
		{
			if ((configName (_configFile/_Extended_Init_Class/_x))!= "") then
			{
				_i = 0;
				_t = count (_configFile/_Extended_Init_Class/_x);
				while { _i<_t } do
				{
					_cfgEntry = (_configFile/_Extended_Init_Class/_x) select _i;
					// Standard XEH init string
					if (isText _cfgEntry && [] call _useEH) then
					{
						_inits set [count _inits, compile(getText _cfgEntry)];
					}
					else
					{
						// Composite XEH init class
						if (isClass _cfgEntry) then
						{
							_scopeEntry = _cfgEntry / "scope";
							_initEntry = _cfgEntry / "init";
							_serverInitEntry = _cfgEntry / "serverInit";
							_clientInitEntry = _cfgEntry / "clientInit";
							_excludeEntry = _cfgEntry / "exclude";
							_respawnEntry = _cfgEntry / "onRespawn";
							_replaceEntry = _cfgEntry / "replaceDEH";
							if (isText _excludeEntry) then
							{
								_excludeClass = (getText _excludeEntry);
							}
							else
							{
								if (isArray _excludeEntry) then
								{
									_excludeClasses = (getArray _excludeEntry);
								};
							};
							_onRespawn = false;
							if (isText _respawnEntry) then
							{
								_onRespawn = ({ (getText _respawnEntry) == _x }count["1", "true"]>0);
							}
							else
							{
								if (isNumber _respawnEntry) then
								{
									_onRespawn = ((getNumber _respawnEntry) == 1);
								};
							};
							_replaceDEH = false;
							if (isText _replaceEntry) then
							{
								_replaceDEH = ({ (getText _replaceEntry) == _x }count["1", "true"]>0);
							}
							else
							{
								if (isNumber _replaceEntry) then
								{
									_replaceDEH = ((getNumber _replaceEntry) == 1);
								};
							};
							_scope = if (isNumber _scopeEntry) then { getNumber _scopeEntry } else { 2 };
							if !(_scope == 0 && (_unitClass != _x)) then
							{
								if (!([] call _isExcluded) && [] call _useEH) then
								{
									if (isText _initEntry) then
									{
										/*  If the init EH is private and vehicle is of the
										*  "wrong" class, do nothing, ie don't add the EH.
										*  Also, if we're called after a respawn and the
										*  init EH shouldn't be used, then don't.
										*/
										_init = compile(getText _initEntry);
										if (_useDEHinit && _replaceDEH) then
										{
											_inits set [0, _init];
										}
										else
										{
											_inits set [count _inits, _init];
										};
									};
									if (isServer) then
									{
										if (isText _serverInitEntry) then
										{
											_serverInit = compile(getText _serverInitEntry);
											_inits set [count _inits, _serverInit];
										};
									};
									if !(isDedicated) then
									{
										if (isText _clientInitEntry) then
										{
											_clientInit = compile(getText _clientInitEntry);
											_inits set [count _inits, _clientInit];
										};
									};
								};
							};
						};
					};
					_i = _i+1;
				};
			};
		} forEach _classes;
	} forEach [configFile, campaignConfigFile, missionConfigFile];
	
	// Now call all the init EHs on the unit.
	#ifdef DEBUG_MODE_FULL
	diag_log text format["(%1) XEH RUN: %2 - %3", time, _this, _inits];
	#endif
	
	{ [_unit] call _x } forEach _inits;
};
#ifdef DEBUG_MODE_FULL
diag_log text format["(%1) XEH END: %2", time, _this];
#endif

nil;
