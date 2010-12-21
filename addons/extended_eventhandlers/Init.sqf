// #define DEBUG_MODE_FULL
#include "script_component.hpp"

/*  Extended event handlers by Solus
*
*  Get all inherited classes, then check if each inherited class has a counter-
*  part in the extended event handlers classes, then and add all lines from
*  each matching EH class and exec them.
*/
private [
	"_slx_xeh_unit", "_Extended_Init_Class", "_isRespawn", "_slx_xeh_unitClass", "_classes",
	"_inits", "_init", "_excludeClass", "_excludeClasses", "_isExcluded",
	"_onRespawn", "_useEH", "_i", "_t", "_cfgEntry", "_scopeEntry",
	"_initEntry", "_excludeEntry", "_respawnEntry", "_u", "_eic", "_sim", "_crew",
	"_clientInitEntry", "_serverInitEntry", "_serverInit", "_clientInit",
	"_justCreated", "_playable", "_isMan", "_names", "_idx", "_fSetInit", "_post"
];

#ifdef DEBUG_MODE_FULL
	diag_log text format["(%1) XEH BEG: %2, %3", time, _this, local (_this select 0), typeOf (_this select 0)];
#endif

// Get unit.
_slx_xeh_unit = _this select 0;
if (isNull _slx_xeh_unit) exitWith {
	#ifdef DEBUG_MODE_FULL
		diag_log text format["(%1) XEH EXIT - NULL OBJECT: %2", time, _this];
	#endif
};
_Extended_Init_Class = _this select 1;
_isRespawn = if (count _this < 3) then { false } else { _this select 2 };

_post = _Extended_Init_Class == "Extended_InitPost_EventHandlers";

// Multiplayer respawn handling
// Bug #7432 fix - all machines will re-run the init EH where the unit is not local, when a unit respawns
_isMan = _slx_xeh_unit isKindOf "Man";

if (count _this == 2 && _isMan && (time>0) && (SLX_XEH_MACHINE select 9) && !_post) exitWith
{
	// Delay initialisation until we can check if it's a respawned unit
	// or a createUnit:ed one. (Respawned units will have the object variable
	// "slx_xeh_isplayable" set to true)
	#ifdef DEBUG_MODE_FULL
		diag_log text format["(%1) XEH: (Bug #7432) deferring init for %2 ",time, _this];
	#endif

	// Wait for the unit to be fully "ready"
	if (SLX_XEH_MACHINE select 7) then {
		_h = [_slx_xeh_unit,_Extended_Init_Class] spawn SLX_XEH_INIT_DELAYED;
	} else {
		SLX_XEH_DELAYED set [count SLX_XEH_DELAYED, _slx_xeh_unit];
	};

	#ifdef DEBUG_MODE_FULL
	diag_log text format["(%1) XEH END: %2", time, _this];
	#endif
	nil;
};

// Get array of inherited classes of unit.
_slx_xeh_unitClass = typeOf _slx_xeh_unit;
_classes = [_slx_xeh_unitClass];
while { !((_classes select 0) in ["", "All"]) } do
{
	_classes = [(configName (inheritsFrom (configFile/"CfgVehicles"/(_classes select 0))))]+_classes;
};

// Check each class to see if there is a counterpart in extended event handlers
// If there is, add it to an array of init event handlers "_inits". Use
// _names to keep track of handler entry names so that a given handler
// of a certain name can be overriden in a child class.
// (See dev-heaven.net issues #12104 and #12108)
_names = [];	// event handler config entry names
_inits = [];	// array of handlers or arrays with handlers, the
			// later being used for XEH handlers that make use of
			// the serverInit and clientInit feature.
_init = {};
_excludeClass = "";
_excludeClasses = [];
_isExcluded = { (_slx_xeh_unitClass isKindOf _excludeClass) || ({ _slx_xeh_unitClass isKindOf _x }count _excludeClasses>0) };

// Function to update the event handler or handlers at a given index
// into the _inits array
_fSetInit = {
	private ["_idx", "_init", "_type", "_handler", "_cur"];

	_idx=_this select 0;
	_init = _this select 1;
	_type=["all", "server", "client"] find (_this select 2);	// 0 1 2

	_handler={};
	_cur=_inits select _idx;
	if (isNil"_cur")then{_cur={};};
	if (typeName _cur == "ARRAY") then
	{
		_handler = _cur;
		_handler set [_type, _init];
	} else {
		if (_type > 0) then
		{
			_handler=[_cur,{},{}];
			_handler set [_type, _init];
		} else {
			_handler=_init;
		};
	};
	_inits set [_idx, _handler];
};


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
	_ehSuper = inheritsFrom(configFile/"CfgVehicles"/_slx_xeh_unitClass/"EventHandlers");
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
				_name = configName _cfgEntry;
				_idx = _names find _name;
				if (_idx < 0) then
				{
					// This particular handler entry name hasn't been seen
					// yet, so add it to the end of the _inits array
					_idx = count _inits;
					_names set [_idx, _name];
				};
				// Standard XEH init string
				if (isText _cfgEntry && [] call _useEH) then
				{
					_inits set [_idx, compile(getText _cfgEntry)];
				} else {
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
						_excludeClasses = [];
						_excludeClass = "";
						if (isText _excludeEntry) then
						{
							_excludeClass = (getText _excludeEntry);
						} else {
							if (isArray _excludeEntry) then
							{
								_excludeClasses = (getArray _excludeEntry);
							};
						};
						_onRespawn = false;
						if (isText _respawnEntry) then
						{
							_onRespawn = ({ (getText _respawnEntry) == _x }count["1", "true"]>0);
						} else {
							if (isNumber _respawnEntry) then
							{
								_onRespawn = ((getNumber _respawnEntry) == 1);
							};
						};
						_replaceDEH = false;
						if (isText _replaceEntry) then
						{
							_replaceDEH = ({ (getText _replaceEntry) == _x }count["1", "true"]>0);
						} else {
							if (isNumber _replaceEntry) then
							{
								_replaceDEH = ((getNumber _replaceEntry) == 1);
							};
						};
						_scope = if (isNumber _scopeEntry) then { getNumber _scopeEntry } else { 2 };
						if !(_scope == 0 && (_slx_xeh_unitClass != _x)) then
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
										//_inits set [0, _init];
										[0, _init, "all"] call _fSetInit;
									} else {
										//_inits set [_idx, _init];
										[_idx, _init, "all"] call _fSetInit;
									};
								};
								if (SLX_XEH_MACHINE select 3) then
								{
									if (isText _serverInitEntry) then
									{
										_serverInit = compile(getText _serverInitEntry);
										//_inits set [_idx, _serverInit];
										[_idx, _serverInit, "server"] call _fSetInit;
									};
								};
								if (SLX_XEH_MACHINE select 0) then
								{
									if (isText _clientInitEntry) then
									{
										_clientInit = compile(getText _clientInitEntry);
										//_inits set [_idx, _clientInit];
										[_idx, _clientInit, "client"] call _fSetInit;
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
diag_log text format["(%1) XEH RUN: %2 - %3 - %4", time, _this, typeOf (_this select 0), _inits];
#endif

// Naughty but more flexible...
if !(_isRespawn) then {
	// Compile code for other EHs to run and put them in the setVariable.
	// Set up code for the remaining event handlers too...
	// This is in PostInit as opposed to (pre)Init,
	// because units in a player's group setVariables are lost (counts at least for disabledAI = 1;)
	// Run men's SLX_XEH_initOthers in PostInit, only when in Multiplayer
	if !((_isMan && isMultiplayer && !_post) || ((!_isMan || !isMultiplayer) && _post)) then { _inits set [count _inits, {_this call SLX_XEH_initOthers}] };
	// Run supportM
	if !(_post) then { _inits set [count _inits, {_this call SLX_XEH_FNC_SUPPORTM2}] };
};

if !(_post) then { _inits set [count _inits, {_this call SLX_XEH_initPost}] } else {
	if (_isMan) then { _inits set [count _inits, {_this call SLX_XEH_initPlayable }] };
};

{
	private ["_h"];
	if (typeName _x=="CODE") then
	{
		// Normal code type handler
		[_slx_xeh_unit] call _x;
	} else {
		// It's an array of handlers (all, server, client)
		_h=_x;
		{[_slx_xeh_unit] call _x} forEach _h;
	};
} forEach _inits;

#ifdef DEBUG_MODE_FULL
diag_log text format["(%1) XEH END: %2", time, _this];
#endif

nil;
