// Init Others per Object, enumuration

// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private [
	"_event", "_Extended_EH_Class", "_handlers", "_handlersPlayer", "_names", "_namesPlayer", "_handler", "_handlerPlayer",
	"_configFile", "_class", "_i", "_t", "_excludeClass", "_excludeClasses", "_name", "_idx", "_idxPlayer", "_scope", "_f", "_h", "_fSetHandler", "_isExcluded",
	"_cfgEntry", "_scopeEntry", "_Entry"
];

// Adds or updates a handler in the _handlers or _handlersPlayer arrays
// used when collecting event handlers.
_fSetHandler = {
	private ["_cur"];

	PARAMS_3(_idx,_handler,_type);

	_cur = _handlers select _idx;
	if (isNil"_cur")then{_cur=[nil,nil,nil]; _handlers set [_idx,_cur] };
	_cur set [_type, _handler]
};

_isExcluded = { (_unitClass isKindOf _excludeClass) || ({ _unitClass isKindOf _x }count _excludeClasses>0) };

_f = {
	private ["_handlerEntry", "_serverHandlerEntry", "_clientHandlerEntry", "_replaceDEH"];

	PARAMS_3(_eventCus,_handlers,_idx);

	_eventCus = format["%1%2",_event, _eventCus];
	_handlerEntry = _cfgEntry / _eventCus;
	_serverHandlerEntry = _cfgEntry / format["server%1", _eventCus];
	_clientHandlerEntry = _cfgEntry / format["client%1", _eventCus];
	// If the particular EH is private and vehicle is of the
	// "wrong" class, do nothing, ie don't add the EH.
	//diag_log ["EventCus",_eventCus, getText _handlerEntry,_handlers];
	if !(_scope == 0 && (_unitClass != _class)) then
	{
		if !(call _isExcluded) then
		{
			if (isText _handlerEntry) then
			{
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
				if (_hasDefaultEH && _replaceDEH) then
				{
					[0, getText _handlerEntry, 0] call _fSetHandler;
				} else {
					[_idx, getText _handlerEntry, 0] call _fSetHandler;
				};
			};
			if (SLX_XEH_MACHINE select 3) then
			{
				if (isText _serverHandlerEntry) then
				{
					[_idx, getText _serverHandlerEntry, 1] call _fSetHandler;
				};
			};
			if (SLX_XEH_MACHINE select 0) then
			{
				if (isText _clientHandlerEntry) then
				{
					[_idx, getText _clientHandlerEntry, 2] call _fSetHandler;
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
	_handlers = [[getText(configFile/"DefaultEventhandlers"/_event)]];
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
				[_idx, getText _cfgEntry, 0] call _fSetHandler;
			} else {
				// Composite XEH event handler class
				if (isClass _cfgEntry) then
				{
					_scopeEntry = _cfgEntry / "scope";
					_excludeEntry = _cfgEntry / "exclude";
					_replaceEntry = _cfgEntry / "replaceDEH";

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
	_h=_x;
	// It's an array of handlers (all, server, client)
	if !(isNil "_h") then { {if !(isNil "_x") then { _handler = _handler + _x + ";" } } forEach _h };
} forEach _handlers;

_handlerPlayer = "";
{
	_h=_x;
	// It's an array of handlers (all, server, client)
	if !(isNil "_h") then { {if !(isNil "_x") then { _handlerPlayer = _handlerPlayer + _x + ";" } } forEach _h };
} forEach _handlersPlayer;

[_handler, _handlerPlayer];
