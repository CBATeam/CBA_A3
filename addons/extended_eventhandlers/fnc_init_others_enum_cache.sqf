// Init Others per Object, enumuration cache

// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private ["_types", "_type", "_data", "_cached", "_classes", "_ehSuper", "_hasDefaultEH", "_storageKey"];

PARAMS_1(_unitClass);

_storageKey = ("SLX_XEH_" + _unitClass); // TODO: Cache??

_types = uiNamespace getVariable _storageKey;
//        ded, server, client, SESSION_ID
if (isNil "_types") then { _types = [nil, nil, nil, -1]; uiNamespace setVariable [_storageKey, _types] };
_type = SLX_XEH_MACHINE select 10;

// _data for events (Fired, etc)
_cached = !SLX_XEH_RECOMPILE;
_data = _types select _type;
if (isNil "_data" || !_cached) then { _data = []; _types set [_type, _data]; _cached = false };

// Now load the data from config if !_cached, or load data from cache if _cached already.
private ["_config", "_configData", "_event_id", "_cfgs", "_retData", "_config_id"];

// If already cached, and already ran for this unitClass in this mission (SLX_XEH_ID matches), exit and return existing _data.
if (_cached && (_types select 3) == (uiNamespace getVariable "SLX_XEH_ID")) exitWith {
	TRACE_1("Fully Cached",_unitClass);
	_data;
};

// Skip configFile if already cached - it doesn't until game restart (or future mergeConfigFile ;)).
_cfgs = if (_cached) then { TRACE_1("Partial Cached",_unitClass); SLX_XEH_CONFIG_FILES_VARIABLE } else { TRACE_1("Not Cached",_unitClass); SLX_XEH_CONFIG_FILES };

_ehSuper = inheritsFrom(configFile/"CfgVehicles"/_unitClass/"EventHandlers");
_hasDefaultEH = (configName(_ehSuper)=="DefaultEventhandlers");

// Get array of inherited classes of unit.
if (_cached) then {
	_classes = uiNamespace getVariable ("SLX_XEH_" + _unitClass + "_classes");
} else {
	_classes = [_unitClass];
	while {!((_classes select 0) in SLX_XEH_DEF_CLASSES)} do
	{
		_classes = [(configName (inheritsFrom (configFile/"CfgVehicles"/(_classes select 0))))]+_classes;
	};
	uiNamespace setVariable [("SLX_XEH_" + _unitClass + "_classes"), _classes];
};

_event_id = 0;
{
	// configData array: index 0 .. 2 # normal handlers, player handlers
	_configData = if (count _data > _event_id) then { _data select _event_id } else { [[], []] };

	_data set [_event_id, _configData];
	_config_id = if (_cached) then { 1 } else { 0 };
	{
		_config = _x;
		_retData = [_config, _event_id, _unitClass, _classes, if (_config_id == 0) then { _hasDefaultEH } else { false }] call FUNC(init_others_enum);

		// Normal EH and Player EH code
		(_configData select 0) set [_config_id, _retData select 0];
		(_configData select 1) set [_config_id, _retData select 1];

		INC(_config_id);
	} forEach _cfgs;
	INC(_event_id);
} forEach SLX_XEH_OTHER_EVENTS;

// Tag this unit class with the current session id
_types set [3, uiNamespace getVariable "SLX_XEH_ID"];

// Return data
_data;
