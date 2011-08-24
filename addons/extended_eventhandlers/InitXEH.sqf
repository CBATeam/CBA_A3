#define DEBUG_MODE_FULL
#include "script_component.hpp"

// Compile all necessary scripts and start one vehicle crew initialisation thread
SLX_XEH_DisableLogging = isClass(configFile/"CfgPatches"/"Disable_XEH_Logging");
XEH_LOG("XEH: PreInit Started. v"+getText(configFile >> "CfgPatches" >> "Extended_Eventhandlers" >> "version"));
if (time > 0) then { XEH_LOG("XEH WARNING: Time > 0; This probably means there are no XEH compatible units by default on the map, perhaps add the SLX_XEH_Logic module.") };

private ["_cfgRespawn", "_respawn"];
_cfgRespawn = (missionConfigFile/"respawn");
_respawn = false;
if ( isNumber(_cfgRespawn) ) then
{
	_respawn = !(getNumber(_cfgRespawn) in [0, 1, 4, 5]);
};
if ( isText(_cfgRespawn) ) then
{
	_respawn = !(getText(_cfgRespawn) in ["none", "bird", "group", "side"]);
};


// UNIQUE Session ID since start of game
private ["_id"];
_id = uiNamespace getVariable "SLX_XEH_ID";
if (isNil "_id") then { _id = 1 } else { INC(_id) };
uiNamespace setVariable ["SLX_XEH_ID", _id];


SLX_XEH_MACHINE =
[
	!isDedicated, // 0 - isClient (and thus has player)
	false, // 1 - isJip
	!isServer, // 2 - isDedicatedClient (and thus not a Client-Server)
	isServer, // 3 - isServer
	isDedicated, // 4 - isDedicatedServer (and thus not a Client-Server)
	false, // 5 - Player Check Finished
	!isMultiplayer, // 6 - SP?
	false, // 7 - StartInit Passed
	false, // 8 - Postinit Passed
	isMultiplayer && _respawn,      // 9 - Multiplayer && respawn?
	if (isDedicated) then { 0 } else { if (isServer) then { 1 } else { 2 } }, // Machine type (only 3 possible configurations)
	_id // SESSION_ID
];

// Backup
_fnc_compile = uiNamespace getVariable "SLX_XEH_COMPILE";
if (isNil "_fnc_compile") then { call compile preProcessFileLineNumbers 'extended_eventhandlers\init_compile.sqf' };

SLX_XEH_objects = [];
SLX_XEH_INIT_MEN = [];
// All events except the init event
SLX_XEH_OTHER_EVENTS = [XEH_EVENTS,XEH_CUSTOM_EVENTS];
SLX_XEH_OTHER_EVENTS_FULL = [];
{ SLX_XEH_OTHER_EVENTS_FULL set [_forEachIndex, format["Extended_%1_EventHandlers", _x]] } forEach SLX_XEH_OTHER_EVENTS;

SLX_XEH_OTHER_EVENTS_XEH = [];
{ SLX_XEH_OTHER_EVENTS_XEH set [_forEachIndex, format["Extended_%1EH", _x]] } forEach SLX_XEH_OTHER_EVENTS;

SLX_XEH_CONFIG_FILES = [configFile, campaignConfigFile, missionConfigFile];
SLX_XEH_CONFIG_FILES_VARIABLE = [campaignConfigFile, missionConfigFile];
SLX_XEH_INIT_TYPES = ["all", "server", "client"];
SLX_XEH_DEF_CLASSES = ["", "All"];

SLX_XEH_LOG = { XEH_LOG(_this); };

// Process each new unit
SLX_XEH_F_INIT = {
	private [
		"_i", "_c", "_entry", "_entryServer", "_entryClient", "_Inits"
	];
	_Inits = [];
	#ifdef DEBUG_MODE_FULL
	_msg = format["XEH BEG: Init %1", _this];
	XEH_LOG(_msg);
	#endif

	if (isClass _this) then
	{
		_i = 0;
		_c = count _this;
		while { _i<_c } do
		{
			_entry = _this select _i;
			if (isClass _entry) then
			{
				_entryServer = (_entry/"serverInit");
				_entryClient = (_entry/"clientInit");
				_entry = (_entry/"init");
				if (isText _entry) then
				{
					_Inits set [count _Inits, compile(getText _entry)];
				};
				if (SLX_XEH_MACHINE select 3) then
				{
					if (isText _entryServer) then
					{
						_Inits set [count _Inits, compile(getText _entryServer)];
					};
				};
				if (!isDedicated) then
				{
					if (isText _entryClient) then
					{
						_Inits set [count _Inits, compile(getText _entryClient)];
					};
				};
			} else {
				if (isText _entry) then
				{
					_Inits set [count _Inits, compile(getText _entry)];
				};
			};
			INC(_i);
		};
		{
			#ifdef DEBUG_MODE_FULL
				XEH_LOG(_x);
			#endif
			call _x;
		} forEach _Inits;
	};
	#ifdef DEBUG_MODE_FULL
	_msg = format["XEH END: Init %1", _this];
	XEH_LOG(_msg);
	#endif
};


// NEW Init (+InitPost) Function
SLX_XEH_F2_INIT = {
	private [
		"_fSetInit", "_onRespawn", "_useEH", "_inits", "_i", "_t", "_name", "_idx", "_names", "_init", "_clientInit", "_serverInit",
		"_cfgEntry", "_respawnEntry", "_scopeEntry", "_initEntry", "_serverInitEntry", "_clientInitEntry",
		"_excludeEntry", "_excludeClass", "_excludeClasses"
	];

	// Function to update the event handler or handlers at a given index
	// into the _inits array
	_fSetInit = {
		private ["_idx", "_init", "_type", "_handler", "_cur"];
		_idx=_this select 0;
		_init = _this select 1;
		_type=SLX_XEH_INIT_TYPES find (_this select 2);	// 0 1 2
	
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
	_isExcluded = { (_unitClass isKindOf _excludeClass) || ({ _unitClass isKindOf _x }count _excludeClasses>0) };

	PARAMS_5(_configFile,_unitClass,_classes,_useDEHinit,_isRespawn);

	{
		if ((configName (_configFile/_x))!= "") then
		{
			_i = 0;
			_t = count (_configFile/_x);
			while { _i<_t } do
			{
				_cfgEntry = (_configFile/_x) select _i;
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
				if (isText _cfgEntry && (call _useEH)) then
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
						if !(_scope == 0 && (_unitClass != _x)) then
						{
							if (!([] call _isExcluded) && (call _useEH)) then
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
				INC(_i);
			};
		};
	} forEach _classes;

	_inits;
};

SLX_XEH_F2_INIT_CACHE = {

	PARAMS_5(_unitClass,_classes,_useDEHinit,_ehType,_isRespawn);

	// TODO: Use more unique variable names inside uiNamespace.
	private ["_types", "_type", "_data", "_cached", "_storageKey"];

	_storageKey = _unitClass + _ehType;

	_types = uiNamespace getVariable _storageKey;
	//        ded, server, client, SESSION_ID
	if (isNil "_types") then { _types = [nil, nil, nil, -1]; uiNamespace setVariable [_storageKey, _types] };
	_type = SLX_XEH_MACHINE select 10;

	// _data - inits
	_cached = true;
	_data = _types select _type;
	if (isNil "_data") then { _data = []; _types set [_type, _data]; _cached = false };

	// Now load the data from config if !_cached, or load data from cache if _cached already.
	private ["_config", "_configData", "_event_id"];

	// If already cached, and already ran for this unitClass in this mission (SLX_XEH_ID matches), exit and return existing _data.
	if (_cached && (_types select 3) == (uiNamespace getVariable "SLX_XEH_ID")) exitWith {
		TRACE_2("Fully Cached",_unitClass,_ehType);
		_data;
	};

	// Skip configFile if already cached - it doesn't until game restart (or future mergeConfigFile ;)).
	_cfgs = if (_cached) then { TRACE_2("Partial Cached",_unitClass,_ehType); SLX_XEH_CONFIG_FILES_VARIABLE } else { SLX_XEH_CONFIG_FILES };

	_data = [];
	{
		_config = _x;
		_retdata = [_config >> _ehType, _unitClass, _classes, _useDEHinit, _isRespawn] call SLX_XEH_F2_INIT;
		ADD(_data,_retData); // Or use ForEach and PUSH ?
	} forEach _cfgs;

	// Tag this unit class with the current session id
	_types set [3, uiNamespace getVariable "SLX_XEH_ID"];

	// Return data
	_data;
};


// NEW Init Other Function
SLX_XEH_F2_INIT_OTHER = {
	// #define DEBUG_MODE_FULL
	// #include "script_component.hpp"

	private [
		"_event", "_Extended_EH_Class", "_handlers", "_handlersPlayer", "_names", "_namesPlayer", "_handler", "_handlerPlayer",
		"_configFile", "_class", "_i", "_t", "_excludeClass", "_excludeClasses", "_name", "_idx", "_idxPlayer", "_scope", "_f", "_h", "_fSetHandler", "_isExcluded",
		"_cfgEntry", "_scopeEntry", "_Entry"
	];

	// Adds or updates a handler in the _handlers or _handlersPlayer arrays
	// used when collecting event handlers.
	_fSetHandler = {
		private ["_idx", "_handler", "_h", "_type", "_cur"];

		_idx = _this select 0;
		_handler = _this select 1;
		_type= SLX_XEH_INIT_TYPES find (_this select 2);

		_h = "";
		_cur = _handlers select _idx;
		if (isNil"_cur")then{_cur="";};
		if (typeName _cur == "ARRAY") then
		{
			_h = _cur;
			_h set [_type, _handler]
		} else {
			if (_type > 0) then
			{
				_h=[_cur,"",""];
				_h set [_type, _handler];
			} else {
				_h=_handler;
			};
		};
		_handlers set [_idx, _h];
	};

	_isExcluded = { (_unitClass isKindOf _excludeClass) || ({ _unitClass isKindOf _x }count _excludeClasses>0) };

	_f = {
		private ["_handlers", "_eventCus", "_idx", "_handlerEntry", "_serverHandlerEntry", "_clientHandlerEntry", "_replaceEntry", "_replaceDEH"];
		_eventCus = format["%1%2",_event, _this select 0];
		_handlers = _this select 1;
		_idx = _this select 2;
		_handlerEntry = _cfgEntry / _eventCus;
		_serverHandlerEntry = _cfgEntry / format["server%1", _eventCus];
		_clientHandlerEntry = _cfgEntry / format["client%1", _eventCus];
		// If the particular EH is private and vehicle is of the
		// "wrong" class, do nothing, ie don't add the EH.
		//diag_log ["EventCus",_eventCus, getText _handlerEntry,_handlers];
		if !(_scope == 0 && (_unitClass != _class)) then
		{
			if !( [] call _isExcluded ) then
			{
				if (isText _handlerEntry) then
				{
					if (isText _replaceEntry) then
					{
						_replaceDEH = ({ (getText _replaceEntry) == _x }count["1", "true"]>0);
					} else {
						if (isNumber _replaceEntry) then
						{
							_replaceDEH = ((getNumber _replaceEntry) == 1);
						};
					};
					if (_hasDefaultEH && _replaceDEH) then
					{
						//_handlers set [0, getText _handlerEntry];
						[0, getText _handlerEntry, "all"] call _fSetHandler;
					} else {
						//_handlers set [count _handlers, getText _handlerEntry];
						[_idx, getText _handlerEntry, "all"] call _fSetHandler;
					};
				};
				if (SLX_XEH_MACHINE select 3) then
				{
					if (isText _serverHandlerEntry) then
					{
						//_handlers set [count _handlers, getText _serverHandlerEntry];
						[_idx, getText _serverHandlerEntry, "server"] call _fSetHandler;
					};
				};
				if (SLX_XEH_MACHINE select 0) then
				{
					if (isText _clientHandlerEntry) then
					{
						//_handlers set [count _handlers, getText _clientHandlerEntry];
						[_idx, getText _clientHandlerEntry, "client"] call _fSetHandler;
					};
				};
			} else {
				#ifdef DEBUG_MODE_FULL
					str(["Excluded", _class, _excludeClass, _excludeClasses]) call SLX_XEH_LOG;
				#endif
			};
		} else {
			#ifdef DEBUG_MODE_FULL
				str(["Scoped", _class, _scope]) call SLX_XEH_LOG;
			#endif
		};
	};

	PARAMS_5(_configFile,_event_id,_unitClass,_classes,_hasDefaultEh);

	_event = SLX_XEH_OTHER_EVENTS select _event_id;
	_Extended_EH_Class = SLX_XEH_OTHER_EVENTS_FULL select _event_id; // format["Extended_%1_EventHandlers", _event];

	// Check each class to see if there is a counterpart in the extended event
	// handlers, add all lines from matching classes to an array, "_handlers"
	_handlers = []; _handlersPlayer = [];
	_names = []; _namesPlayer = [];

	// Does the vehicle's class EventHandlers inherit from the BIS
	// DefaultEventhandlers? If so, include BIS own default handler for the
	// event type currently being processed and make it the first
	// EH to be called.
	if (_hasDefaultEH && isText(configFile/"DefaultEventhandlers"/_event)) then
	{
		_handlers = [getText(configFile/"DefaultEventhandlers"/_event)];
	};

	// Search the mission config file (description.ext), then campaign
	// config file (description.ext) and finally addon config for
	// extended event handlers to use.
	{
		_class = _x;
		if ((configName (_configFile/_Extended_EH_Class/_class))!= "") then
		{
			_i = 0;
			_t = count (_configFile/_Extended_EH_Class/_class);
			while { _i<_t } do
			{
				_excludeClass = "";
				_excludeClasses = [];
				_cfgEntry = (_configFile/_Extended_EH_Class/_class) select _i;
				_name = configName _cfgEntry;
				_idx = _names find _name;
				if (_idx < 0) then
				{
					_idx = count _handlers;
					_names set [_idx, _name];
				};
				_idxPlayer = _namesPlayer find _name;
				if (_idxPlayer < 0) then
				{
					_idxPlayer = count _handlersPlayer;
					_namesPlayer set [_idxPlayer, _name];
				};
				// Standard XEH event handler string
				if (isText _cfgEntry) then
				{
					//_handlers set [count _handlers, getText _cfgEntry];
					_handlers set [_idx, getText _cfgEntry];
				} else {
					// Composite XEH event handler class
					if (isClass _cfgEntry) then
					{
						_scopeEntry = _cfgEntry / "scope";
						_excludeEntry = _cfgEntry / "exclude";
						_replaceEntry = _cfgEntry / "replaceDEH";
						_replaceDEH = false;

						if (isText _excludeEntry) then
						{
							_excludeClass = (getText _excludeEntry);
						} else {
							if (isArray _excludeEntry) then
							{
								_excludeClasses = (getArray _excludeEntry);
							};
						};
						_scope = if (isNumber _scopeEntry) then { getNumber _scopeEntry } else { 2 };
						// Handle event, serverEvent and clientEvent, for both normal and player
						{ _x call _f } forEach [["", _handlers, _idx], ["Player", _handlersPlayer, _idxPlayer]];
					};
				};
				INC(_i);
			};
		};
	} forEach _classes;

	// Now concatenate all the handlers into one string
	_handler = "";
	{
		if (typeName _x=="STRING") then
		{
			// Some entries are empty, because they do not contain all variants (server, client, and normal)
			if (_x != "") then {
				_handler = _handler + _x + ";"
			};
		} else {
			_h=_x;
			// Some entries are empty, because they do not contain all variants (server, client, and normal)
			{
				if (_x != "") then {
					_handler = _handler + _x + ";"
				};
			} forEach _h;
		};
	} forEach _handlers;

	_handlerPlayer = "";
	{
		if (typeName _x=="STRING") then
		{
			// Some entries are empty, because they do not contain all variants (server, client, and normal)
			if (_x != "") then {
				_handlerPlayer = _handlerPlayer + _x + ";"
			};
		} else {
			_h=_x;
			{
				// Some entries are empty, because they do not contain all variants (server, client, and normal)
				if (_x != "") then {
					_handlerPlayer = _handlerPlayer + _x + ";"
				};
			} forEach _h;
		};
	} forEach _handlersPlayer;

	[_handler, _handerPlayer];
};

SLX_XEH_F2_INIT_OTHERS_CACHE = {

	PARAMS_3(_unitClass,_classes,_hasDefaultEH);

	// TODO: Use more unique variable names inside uiNamespace.
	private ["_types", "_type", "_data", "_cached"];
	_types = uiNamespace getVariable _unitClass;
	//        ded, server, client, SESSION_ID
	if (isNil "_types") then { _types = [nil, nil, nil, -1]; uiNamespace setVariable [_unitClass, _types] };
	_type = SLX_XEH_MACHINE select 10;
	
	// _data for events (Fired, etc)
	_cached = true;
	_data = _types select _type;
	if (isNil "_data") then { _data = []; _types set [_type, _data]; _cached = false };

	// Now load the data from config if !_cached, or load data from cache if _cached already.
	private ["_config", "_configData", "_event_id"];
	
	// If already cached, and already ran for this unitClass in this mission (SLX_XEH_ID matches), exit and return existing _data.
	if (_cached && (_types select 3) == (uiNamespace getVariable "SLX_XEH_ID")) exitWith {
		TRACE_1("Fully Cached",_unitClass);
		_data;
	};

	// Skip configFile if already cached - it doesn't until game restart (or future mergeConfigFile ;)).
	_cfgs = if (_cached) then { TRACE_1("Partial Cached",_unitClass); SLX_XEH_CONFIG_FILES_VARIABLE } else { SLX_XEH_CONFIG_FILES };

	_event_id = 0;
	{
		// configData array: index 0 .. 2 # normal handlers, player handlers
		_configData = [[], []];
		_data set [_event_id, _configData];
		{
			_config = _x;
			_retdata = [_config, _event_id, _unitClass, _classes, _hasDefaultEH] call SLX_XEH_F2_INIT_OTHER;
			// Normal EH and Player EH code
			PUSH((_configData select 0),compile (_retData select 0));
			PUSH((_configData select 1),compile (_retData select 1));
		} forEach _cfgs;
		INC(_event_id);
	} forEach SLX_XEH_OTHER_EVENTS;
	
	// Tag this unit class with the current session id
	_types set [3, uiNamespace getVariable "SLX_XEH_ID"];
	
	// Return data
	_data;
};


// Add / Remove the playerEvents
// TODO: Improve
SLX_XEH_F_ADDPLAYEREVENTS = {
	private ["_event", "_curEvt"];
	if (isNull _this) exitWith {}; // not a valid object
	{
		_event = format["Extended_%1EH",_x];
		_curEvt = _this getVariable _event;
		if (isNil "_curEvt") then { _curEvt = [] };
		_this setVariable [_event, [
			if (count _curEvt > 0) then { _curEvt select 0 } else { [] },
			[compile format["{ _this call _x } forEach ((_this select 0) getVariable '%1_Player')",_event] ]
		]];
	} forEach SLX_XEH_OTHER_EVENTS;
};
SLX_XEH_F_REMOVEPLAYEREVENTS = {
	private ["_event", "_curEvt"];
	if (isNull _this) exitWith {}; // not a valid object
	{
		_event = format["Extended_%1EH",_x];
		_curEvt = _this getVariable _event;
		if (isNil "_curEvt") then { _curEvt = [] };
		if (count _curEvt > 0) then { _this setVariable [_event, [_curEvt select 0]] };
	} forEach SLX_XEH_OTHER_EVENTS;
};

// The actual XEH functions that are called from within the engine eventhandlers.
// This can also be uesd for better debugging
#ifdef DEBUG_MODE_FULL
	#define XEH_FUNC(A) SLX_XEH_EH_##A = { if ('A' in ['Respawn', 'MPRespawn', 'Killed', 'MPKilled', 'Hit', 'MPHit']) then { diag_log ['A',_this, local (_this select 0), typeOf (_this select 0)] }; { { _this call _x } forEach _x }forEach((_this select 0)getVariable'Extended_##A##EH') }
#endif
#ifndef DEBUG_MODE_FULL
	#define XEH_FUNC(A) SLX_XEH_EH_##A = { { { _this call _x } forEach _x }forEach((_this select 0)getVariable'Extended_##A##EH') }
#endif

XEH_FUNC(Hit);
XEH_FUNC(AnimChanged);
XEH_FUNC(AnimStateChanged);
XEH_FUNC(Dammaged);
XEH_FUNC(Engine);
XEH_FUNC(FiredNear);
XEH_FUNC(Fuel);
XEH_FUNC(Gear);
XEH_FUNC(GetIn);
XEH_FUNC(GetOut);
XEH_FUNC(IncomingMissile);
XEH_FUNC(Hit);
XEH_FUNC(Killed);
XEH_FUNC(LandedTouchDown);
XEH_FUNC(LandedStopped);
XEH_FUNC(Respawn);
XEH_FUNC(MPHit);
XEH_FUNC(MPKilled);
XEH_FUNC(MPRespawn);

SLX_XEH_EH_Init = { PUSH(SLX_XEH_PROCESSED_OBJECTS,_this select 0); [_this select 0,'Extended_Init_EventHandlers']call SLX_XEH_init };
SLX_XEH_EH_RespawnInit = { PUSH(SLX_XEH_PROCESSED_OBJECTS,_this select 0); [_this select 0, "Extended_Init_EventHandlers", true] call SLX_XEH_init };
SLX_XEH_EH_GetInMan = { {[_this select 2, _this select 1, _this select 0] call _x}forEach((_this select 2)getVariable'Extended_GetInManEH') };
SLX_XEH_EH_GetOutMan = { {[_this select 2, _this select 1, _this select 0] call _x}forEach((_this select 2)getVariable'Extended_GetOutManEH') };
SLX_XEH_EH_Fired =
{
	#ifdef DEBUG_MODE_FULL
		// diag_log ['Fired',_this, local (_this select 0), typeOf (_this select 0)];
	#endif
	_this call SLX_XEH_EH_FiredBis; _feh = ((_this select 0)getVariable'Extended_FiredEH'); if (count _feh > 0) then { _c=count _this;if(_c<6)then{_this set[_c,nearestObject[_this select 0,_this select 4]];_this set[_c+1,currentMagazine(_this select 0)]}else{_this = +_this; _mag=_this select 5;_this set[5,_this select 6];_this set[6,_mag]};{_this call _x}forEach _feh }
};
SLX_XEH_EH_FiredBis = {
	{_this call _x}forEach((_this select 0)getVariable'Extended_FiredBisEH');
};

// XEH init functions
SLX_XEH_initPlayable =
{
	_unit = _this select 0;
	_var = _unit getVariable "SLX_XEH_PLAYABLE";
	if !(isNil "_var") exitWith {}; // Already set
	if (_unit in playableUnits || isPlayer _unit || _unit == player) then
	{
		#ifdef DEBUG_MODE_FULL
			str(['Playable unit!', _unit]) call SLX_XEH_LOG;
		#endif
		if (_unit == player) then {
			_unit setVariable ['SLX_XEH_PLAYABLE', true, true]; // temporary until better solution for players in MP..
		} else {
			// Workaround for JIP players thinking they are respawners :P
			_unit setVariable ['SLX_XEH_PLAYABLE', true];
		};
	};
};

SLX_XEH_init = COMPILE_FILE2(extended_eventhandlers\Init.sqf);
SLX_XEH_initPost = COMPILE_FILE2(extended_eventhandlers\InitPost.sqf);
SLX_XEH_initOthers = COMPILE_FILE2(extended_eventhandlers\InitOthers.sqf);
SLX_XEH_postInit = COMPILE_FILE2(extended_eventhandlers\PostInit.sqf);

SLX_XEH_DELAYED = [];
SLX_XEH_INIT_DELAYED = {
	private ["_unit", "_unitPlayable"];
	_unit = _this select 0;

	
	if (isNull _unit) exitWith {
		#ifdef DEBUG_MODE_FULL
			format["XEH BEG: (Bug #7432) %2 Null Object", time, _unit] call SLX_XEH_LOG;
		#endif
	};

	#ifdef DEBUG_MODE_FULL
		format["XEH BEG: (Bug #7432) %2 is now ready for init", time, _unit] call SLX_XEH_LOG;
	#endif

	_unitPlayable = _unit getVariable "SLX_XEH_PLAYABLE";
	if (isNil "_unitPlayable") then { _unitPlayable = false };

	// If unit already has the variable, it is a respawned unit.
	// Set by InitPost Man-eventhandler.
	if (_unitPlayable) then {
		[_unit, "Extended_Init_EventHandlers", true, true] call SLX_XEH_init; // is respawn
	} else {
		[_unit, "Extended_Init_EventHandlers", false, true] call SLX_XEH_init; // is not respawn
	};
};

// XEH for non XEH supported addons
// Only works until someone uses removeAllEventhandlers on the object
// Only works if there is at least 1 XEH-enabled object on the Map - Place SLX_XEH_Logic to make sure XEH initializes.
// TODO: Perhaps do a config verification - if no custom eventhandlers detected in _all_ CfgVehicles classes, don't run this XEH handler - might be too much processing.
SLX_XEH_EVENTS_NAT = [XEH_EVENTS];
SLX_XEH_EVENTS_FULL_NAT = [];
{ SLX_XEH_EVENTS_FULL_NAT set [_forEachIndex, format["Extended_%1_EventHandlers", _x]] } forEach SLX_XEH_EVENTS_NAT;

SLX_XEH_EXCLUDES = ["LaserTarget"]; // TODO: Anything else?? - Ammo crates for instance have no XEH by default due to crashes) - however, they don't appear in 'vehicles' list anyway.
SLX_XEH_PROCESSED_OBJECTS = []; // Used to maintain the list of processed objects
SLX_XEH_CLASSES = []; // Used to cache classes that have full XEH setup
SLX_XEH_FULL_CLASSES = []; // Used to cache classes that NEED full XEH setup
SLX_XEH_EXCL_CLASSES = []; // Used for exclusion classes

// Used by SupportMonitor
SLX_XEH_FNC_SUPPORTM = {
	private ["_obj", "_cfg", "_init", "_initAr", "_XEH", "_type", "_excl"];
	_obj = _this select 0;
	_type = typeOf _obj;

	if (_type in SLX_XEH_EXCL_CLASSES) exitWith { TRACE_2("Exclusion, abort (cache hit)",_obj,_type) };

	_excl = getNumber(configFile >> "CfgVehicles" >> _type >> "SLX_XEH_DISABLED") == 1;
	if !(_excl) then { { if (_obj isKindOf _x) exitWith { _excl = true } } forEach SLX_XEH_EXCLUDES };
	if (_excl) exitWith {
		TRACE_2("Exclusion, abort and caching",_obj,_type);
		PUSH(SLX_XEH_EXCL_CLASSES,_type);
	};

	_cfg = (configFile >> "CfgVehicles" >> _type >> "EventHandlers");

	// No EH class - Needs full XEH
	if !(isClass _cfg) exitWith {
		TRACE_2("Adding XEH Full and caching",_obj,_type);
		PUSH(SLX_XEH_FULL_CLASSES,_type);
		[_obj] call SLX_XEH_EH_Init;
	};

	// Check 2 - XEH init EH detected
	_XEH = false;
	_init = _cfg >> "init";
	if (isText _init) then {
		_initAr = toArray(getText(_init));
		if (count _initAr > 11) then {
			_ar = [];
			for "_i" from 0 to 11 do {
				PUSH(_ar,_initAr select _i);
			};
			if (toString(_ar) == "if(isnil'SLX") then { _XEH = true };
		};
	};

	if (_XEH) then {
		TRACE_2("Has XEH init",_obj,_type)
	} else {
		TRACE_2("Adding XEH init",_obj,_type);
		[_obj] call SLX_XEH_EH_Init;
	};
};

// Used on Init of all objects, not on respawn.
SLX_XEH_FNC_SUPPORTM2 = {
	private ["_obj", "_type", "_cfg", "_partial", "_full"];
	_obj = _this select 0;
	_type = typeOf _obj;

	// No XEH EH entries at all - Needs full XEH
	if (_type in SLX_XEH_FULL_CLASSES) exitWith {
		TRACE_2("Adding XEH Full (cache hit)",_obj,_type);
		{ _obj addEventHandler [_x, compile format["_this call SLX_XEH_EH_%1", _x]] } forEach SLX_XEH_EVENTS_NAT;
	};

	// Already has Full XEH EH entries - Needs nothing!
	if (_type in SLX_XEH_CLASSES) exitWith { TRACE_2("Already XEH (cache hit)",_obj,_type) };

	_cfg = (configFile >> "CfgVehicles" >> _type >> "EventHandlers");

	// Add script-eventhandlers for those events that are not setup properly.
	_partial = false; _full = true;

	{
		_event = (_cfg >> _x);
		_XEH = false;

		if (isText _event) then {
			_eventAr = toArray(getText(_event));
			if (count _eventAr > 13) then {
				_ar = [];
				for "_i" from 0 to 13 do {
					PUSH(_ar,_eventAr select _i);
				};
				if (toString(_ar) == "_this call SLX") then { _full = false; _XEH = true };
			};
		};
		if !(_XEH) then {
			_partial = true;
			TRACE_3("Adding missing EH",_obj,_type,_x);
			_obj addEventHandler [_x, compile format["_this call SLX_XEH_EH_%1", _x]];
		};
	} forEach SLX_XEH_EVENTS_NAT;

	if !(_partial) then { TRACE_2("Caching",_obj,_type); PUSH(SLX_XEH_CLASSES,_type); };
	if (_full) then { TRACE_2("Caching (full)",_obj,_type); PUSH(SLX_XEH_FULL_CLASSES,_type); };
};

/*
* Process the crews of vehicles. This "thread" will run just
* before PostInit and the mission init.sqf is processed. The order of execution is
*
*  1) all config.cpp init EHs (including all Extended_Init_Eventhandlers)
*  2) all the init lines in the mission.sqm
*  3) spawn:ed "threads" are started
*  4) the mission's init.sqf/sqs is run
*/

GVAR(init_obj) = "HeliHEmpty" createVehicleLocal [0, 0, 0];
GVAR(init_obj) addEventHandler ["killed", {
	XEH_LOG("XEH: VehicleCrewInit: "+str(count vehicles));
	{
		_sim = getText(configFile/"CfgVehicles"/(typeOf _x)/"simulation");
		_crew = crew _x;
		/*
		* If it's a vehicle then start event handlers for the crew.
		* (Vehicles have crew and are neither humanoids nor game logics)
		*/
		if ((count _crew>0)&&{ _sim == _x }count["soldier", "invisible"] == 0) then
		{
			{ if !(_x in SLX_XEH_INIT_MEN) then { [_x] call SLX_XEH_EH_Init } } forEach _crew;
		};
	} forEach vehicles;
	SLX_XEH_INIT_MEN = nil;
	
	deleteVehicle GVAR(init_obj);GVAR(init_obj) = nil
}];

GVAR(init_obj) setDamage 1; // Schedule to run itsy bitsy later

// Prepare postInit
GVAR(init_obj2) = "HeliHEmpty" createVehicleLocal [0, 0, 0];
GVAR(init_obj2) addEventHandler ["killed", {
	call SLX_XEH_postInit;
	deleteVehicle GVAR(init_obj2);GVAR(init_obj2) = nil;
}];

// Schedule PostInit
[] spawn {
	// Warn if PostInit takes longer than 10 tickTime seconds
	[] spawn
	{
		private["_time2Wait"];
		_time2Wait = diag_ticktime + 10;
		waituntil {diag_ticktime > _time2Wait};
		if !(SLX_XEH_MACHINE select 8) then { XEH_LOG("WARNING: PostInit did not finish in a timely fashion"); };
	};

	// On Server + Non JIP Client, we are now after all objects have inited
	// and at the briefing, still time == 0
	if (isNull player) then
	{
		#ifdef DEBUG_MODE_FULL
		"NULL PLAYER" call SLX_XEH_LOG;
		#endif
		if !((SLX_XEH_MACHINE select 4) || (SLX_XEH_MACHINE select 6)) then // only if MultiPlayer and not dedicated
		{
			#ifdef DEBUG_MODE_FULL
			"JIP" call SLX_XEH_LOG;
			#endif
	
			SLX_XEH_MACHINE set [1, true]; // set JIP
			// TEST for weird jip-is-server-issue :S
			if (!(SLX_XEH_MACHINE select 2) || SLX_XEH_MACHINE select 3 || SLX_XEH_MACHINE select 4) then {
				str(["WARNING: JIP Client, yet wrong detection", SLX_XEH_MACHINE]) call SLX_XEH_LOG;
				SLX_XEH_MACHINE set [2, true]; // set Dedicated client
				SLX_XEH_MACHINE set [3, false]; // set server
				SLX_XEH_MACHINE set [4, false]; // set dedicatedserver
			};
			waitUntil { !(isNull player) };
		};
	};
	
	if !(isNull player) then
	{
		if (isNull (group player) && player isKindOf "CAManBase") then
		{
			// DEBUG TEST: Crashing due to JIP, or when going from briefing
			//			 into game
			#ifdef DEBUG_MODE_FULL
			"NULLGROUP" call SLX_XEH_LOG;
			#endif
			waitUntil { !(isNull (group player)) };
		};
		waitUntil { local player };
	};

	GVAR(init_obj2) setDamage 1; // Schedule to run itsy bitsy later
};


// Load and call any "pre-init", run-once event handlers
call COMPILE_FILE2(extended_eventhandlers\PreInit.sqf);
XEH_LOG("XEH: PreInit Finished");
