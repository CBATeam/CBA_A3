// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private ["_types", "_type", "_data", "_cached", "_storageKey", "_classes", "_config_id"];

PARAMS_4(_unitClass,_useDEHinit,_ehType,_isRespawn);

_storageKey = ("SLX_XEH_" + _unitClass + _ehType); // TODO: Cache??

_types = uiNamespace getVariable _storageKey;
//        ded, server, client, SESSION_ID
if (isNil "_types") then { _types = [nil, nil, nil, -1]; uiNamespace setVariable [_storageKey, _types] };
_type = SLX_XEH_MACHINE select 10;

// _data - inits
_cached = !SLX_XEH_RECOMPILE;
_data = _types select _type;
if (isNil "_data" || !_cached) then { _data = [[], [], []]; _types set [_type, _data]; _cached = false };

// Now load the data from config if !_cached, or load data from cache if _cached already.
private ["_config", "_configData", "_cfgs", "_retData"];

// If already cached, and already ran for this unitClass in this mission (SLX_XEH_ID matches), exit and return existing _data.
if (_cached && (_types select 3) == (uiNamespace getVariable "SLX_XEH_ID")) exitWith {
	TRACE_2("Fully Cached",_unitClass,_ehType);
	_data;
};

// Skip configFile if already cached - it doesn't until game restart (or future mergeConfigFile ;)).
_cfgs = if (_cached) then { TRACE_2("Partial Cached",_unitClass,_ehType); SLX_XEH_CONFIG_FILES_VARIABLE } else { SLX_XEH_CONFIG_FILES };

// Get array of inherited classes of unit.
if (_cached) then {
	_classes = uiNamespace getVariable ("SLX_XEH_" + _unitClass + "_classes");
} else {
	_classes = [_unitClass];
	while { !((_classes select 0) in SLX_XEH_DEF_CLASSES) } do
	{
		_classes = [(configName (inheritsFrom (configFile/"CfgVehicles"/(_classes select 0))))]+_classes;
	};
	uiNamespace setVariable [("SLX_XEH_" + _unitClass + "_classes"), _classes];
};

_config_id = if (_cached) then { 1 } else { 0 };
{
	_config = _x;
	_retData = [_config >> _ehType, _unitClass, _classes, _useDEHinit, _isRespawn] call FUNC(init_enum);
	_data set [_config_id, _retData];
	INC(_config_id);
} forEach _cfgs;

// Tag this unit class with the current session id
_types set [3, uiNamespace getVariable "SLX_XEH_ID"];

// Return data
_data;
