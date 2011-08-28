// Init/InitPost per Object, enumuration

// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private [
	"_fSetInit", "_onRespawn", "_useEH", "_inits", "_i", "_t", "_name", "_idx", "_names", "_init", "_clientInit", "_serverInit",
	"_cfgEntry", "_respawnEntry", "_scopeEntry", "_initEntry", "_serverInitEntry", "_clientInitEntry",
	"_excludeEntry", "_excludeClass", "_excludeClasses", "_replaceDEH", "_replaceEntry", "_flatInits"
];

// Function to update the event handler or handlers at a given index
// into the _inits array
_fSetInit = {
	private ["_cur"];
	PARAMS_3(_idx,_init,_type);

	_cur = _inits select _idx;
	if (isNil"_cur")then{ _cur = [nil, nil, nil]; _inits set [_idx, _cur] };
	_cur set [_type, _init];
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
				_init = compile(getText _cfgEntry);
				[_idx, _init, 0] call _fSetInit;
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
						if (!(call _isExcluded) && (call _useEH)) then
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
									[0, _init, 0] call _fSetInit;
								} else {
									[_idx, _init, 0] call _fSetInit;
								};
							};
							if (SLX_XEH_MACHINE select 3) then
							{
								if (isText _serverInitEntry) then
								{
									_serverInit = compile(getText _serverInitEntry);
									[_idx, _serverInit, 1] call _fSetInit;
								};
							};
							if (SLX_XEH_MACHINE select 0) then
							{
								if (isText _clientInitEntry) then
								{
									_clientInit = compile(getText _clientInitEntry);
									[_idx, _clientInit, 2] call _fSetInit;
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

_flatInits = [];
{
	// It's an array of handlers (all, server, client)
	if !(isNil "_x") then { {if !(isNil "_x") then { PUSH(_flatInits,_x) } } forEach _x };
} forEach _inits;

_flatInits;
